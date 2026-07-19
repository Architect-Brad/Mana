/* ─────────────────────────────────────────────────────────────────────────
 * virtio_blk.c — Virtio block (synchronous request/response)
 * ───────────────────────────────────────────────────────────────────────── */
#include "virtio_blk.h"
#include "virtio_mmio.h"
#include "gic.h"
#include "kmalloc.h"
#include "uart.h"

#define VIRTIO_BLK_T_IN   0
#define VIRTIO_BLK_T_OUT  1
#define VIRTIO_BLK_S_OK   0

struct virtio_blk_req {
    uint32_t type;
    uint32_t reserved;
    uint64_t sector;
} __attribute__((packed));

struct virtio_blk_config {
    uint64_t capacity;
    /* rest ignored */
} __attribute__((packed));

#define BLK_QSIZE 16

static struct virtio_device g_blk;
static int                 g_blk_ok;
static uint64_t            g_sectors;
static volatile int        g_req_done;
static volatile uint8_t    g_req_status;

/* Bounce for header + status so desc chains stay simple */
static struct virtio_blk_req *g_hdr;
static uint8_t               *g_status;

int virtio_blk_present(void) { return g_blk_ok; }
uint64_t virtio_blk_sectors(void) { return g_sectors; }
int virtio_blk_irq_num(void) {
    return g_blk_ok ? (int)g_blk.irq : -1;
}

void virtio_blk_irq(void) {
    if (!g_blk_ok)
        return;
    virtio_ack_interrupt(&g_blk);

    struct virtqueue *vq = &g_blk.vq[0];
    uint16_t id;
    uint32_t len;
    while (virtq_pop_used(vq, &id, &len)) {
        (void)len;
        g_req_status = *g_status;
        g_req_done   = 1;
        virtq_free_desc_chain(vq, id);
    }
}

static int blk_xfer(int is_write, uint64_t sector, void *buf, size_t len) {
    if (!g_blk_ok || len == 0 || (len % 512) != 0)
        return -1;

    struct virtqueue *vq = &g_blk.vq[0];
    if (vq->num_free < 3)
        return -1;

    g_hdr->type     = is_write ? VIRTIO_BLK_T_OUT : VIRTIO_BLK_T_IN;
    g_hdr->reserved = 0;
    g_hdr->sector   = sector;
    *g_status       = 0xFF;
    g_req_done      = 0;

    int d0 = virtq_alloc_desc(vq);
    int d1 = virtq_alloc_desc(vq);
    int d2 = virtq_alloc_desc(vq);
    if (d0 < 0 || d1 < 0 || d2 < 0)
        return -1;

    /* hdr (device reads) */
    vq->desc[d0].addr  = (uint64_t)(uintptr_t)g_hdr;
    vq->desc[d0].len   = sizeof(*g_hdr);
    vq->desc[d0].flags = VIRTQ_DESC_F_NEXT;
    vq->desc[d0].next  = (uint16_t)d1;

    /* data */
    vq->desc[d1].addr  = (uint64_t)(uintptr_t)buf;
    vq->desc[d1].len   = (uint32_t)len;
    vq->desc[d1].flags = VIRTQ_DESC_F_NEXT | (is_write ? 0 : VIRTQ_DESC_F_WRITE);
    vq->desc[d1].next  = (uint16_t)d2;

    /* status (device writes) */
    vq->desc[d2].addr  = (uint64_t)(uintptr_t)g_status;
    vq->desc[d2].len   = 1;
    vq->desc[d2].flags = VIRTQ_DESC_F_WRITE;
    vq->desc[d2].next  = 0;

    virtq_push(vq, (uint16_t)d0);
    virtq_notify(&g_blk, 0);

    /* Spin until used ring updates (IRQ or poll) */
    for (int spins = 0; spins < 10000000; spins++) {
        if (g_req_done)
            break;
        /* poll used ring in case IRQ path not wired yet */
        virtio_blk_irq();
        if (g_req_done)
            break;
    }

    if (!g_req_done) {
        uart_puts("[virtio-blk] timeout\n");
        return -1;
    }
    return (*g_status == VIRTIO_BLK_S_OK) ? 0 : -1;
}

int virtio_blk_read(uint64_t sector, void *buf, size_t len) {
    return blk_xfer(0, sector, buf, len);
}

int virtio_blk_write(uint64_t sector, const void *buf, size_t len) {
    return blk_xfer(1, sector, (void *)buf, len);
}

int virtio_blk_init(void) {
    g_blk_ok = 0;
    g_sectors = 0;

    if (virtio_find_device(VIRTIO_ID_BLOCK, &g_blk) != 0) {
        uart_puts("[virtio-blk] no device\n");
        return -1;
    }

    if (!virtio_negotiate_features(&g_blk, VIRTIO_F_VERSION_1))
        return -1;

    /* capacity from config space */
    volatile uint32_t *cfg =
        (volatile uint32_t *)((uintptr_t)g_blk.regs + VIRTIO_MMIO_CONFIG / 4);
    /* config is byte-addressed from device view; our regs are word ptrs.
     * Re-read via byte pointer for safety. */
    volatile uint8_t *cfg8 =
        (volatile uint8_t *)((uintptr_t)g_blk.regs) + VIRTIO_MMIO_CONFIG;
    uint64_t cap = 0;
    for (int i = 0; i < 8; i++)
        cap |= ((uint64_t)cfg8[i]) << (8 * i);
    g_sectors = cap;
    (void)cfg;

    if (virtio_setup_queue(&g_blk, 0, BLK_QSIZE) != 0) {
        uart_puts("[virtio-blk] queue setup failed\n");
        return -1;
    }

    g_hdr    = (struct virtio_blk_req *)kmalloc(sizeof(*g_hdr));
    g_status = (uint8_t *)kmalloc(1);
    if (!g_hdr || !g_status)
        return -1;

    virtio_driver_ok(&g_blk);
    gicd_enable_int((irq_no)g_blk.irq);
    g_blk_ok = 1;

    uart_printf("[virtio-blk] ready: %u sectors (%u MB) irq=%u\n",
                (unsigned)g_sectors,
                (unsigned)(g_sectors / 2048),
                g_blk.irq);
    return 0;
}
