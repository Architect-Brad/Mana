/* ─────────────────────────────────────────────────────────────────────────
 * virtio_input.c — Virtio input keyboard driver
 *
 * Two queues: eventq (device → driver) and statusq (driver → device).
 * We only need eventq for keyboard.
 * ───────────────────────────────────────────────────────────────────────── */
#include "virtio_input.h"
#include "virtio_mmio.h"
#include "board.h"
#include "gic.h"
#include "kmalloc.h"
#include "uart.h"

/* virtio_input_event — 8 bytes */
struct virtio_input_event {
    uint16_t type;
    uint16_t code;
    uint32_t value;
} __attribute__((packed));

#define EVENTQ_SIZE   64
#define KEY_RING_SIZE 128

static struct virtio_device  g_input_dev;
static int                   g_input_ok;
static struct virtio_input_event *g_evbuf; /* EVENTQ_SIZE buffers */

static struct mana_key_event g_key_ring[KEY_RING_SIZE];
static volatile uint16_t     g_key_head;
static volatile uint16_t     g_key_tail;

static void key_push(uint16_t code, uint8_t value) {
    uint16_t next = (uint16_t)((g_key_head + 1) % KEY_RING_SIZE);
    if (next == g_key_tail)
        return; /* drop on overflow */
    g_key_ring[g_key_head].code  = code;
    g_key_ring[g_key_head].value = value;
    g_key_head = next;
}

int virtio_input_poll(struct mana_key_event *ev) {
    if (g_key_tail == g_key_head)
        return 0;
    *ev = g_key_ring[g_key_tail];
    g_key_tail = (uint16_t)((g_key_tail + 1) % KEY_RING_SIZE);
    return 1;
}

static void refill_eventq(void) {
    struct virtqueue *vq = &g_input_dev.vq[0];
    while (vq->num_free > 0) {
        int di = virtq_alloc_desc(vq);
        if (di < 0)
            break;
        /* Map desc index → buffer slot (1:1 while qsize == EVENTQ_SIZE) */
        vq->desc[di].addr  = (uint64_t)(uintptr_t)&g_evbuf[di];
        vq->desc[di].len   = sizeof(struct virtio_input_event);
        vq->desc[di].flags = VIRTQ_DESC_F_WRITE;
        vq->desc[di].next  = 0;
        virtq_push(vq, (uint16_t)di);
    }
    virtq_notify(&g_input_dev, 0);
}

void virtio_input_irq(void) {
    if (!g_input_ok)
        return;
    virtio_ack_interrupt(&g_input_dev);

    struct virtqueue *vq = &g_input_dev.vq[0];
    uint16_t id;
    uint32_t len;
    while (virtq_pop_used(vq, &id, &len)) {
        if (id < EVENTQ_SIZE && len >= sizeof(struct virtio_input_event)) {
            struct virtio_input_event *e = &g_evbuf[id];
            if (e->type == EV_KEY && e->value <= 2)
                key_push(e->code, (uint8_t)e->value);
        }
        virtq_free_desc_chain(vq, id);
    }
    refill_eventq();
}

int virtio_input_irq_num(void) {
    return g_input_ok ? (int)g_input_dev.irq : -1;
}

int virtio_input_present(void) {
    return g_input_ok;
}

int virtio_input_init(void) {
    g_input_ok = 0;
    g_key_head = g_key_tail = 0;

    if (virtio_find_device(VIRTIO_ID_INPUT, &g_input_dev) != 0) {
        uart_puts("[virtio-input] no device (ok if not on QEMU cmdline)\n");
        return -1;
    }

    /* Minimal features: VERSION_1 only */
    if (!virtio_negotiate_features(&g_input_dev, VIRTIO_F_VERSION_1))
        return -1;

    if (virtio_setup_queue(&g_input_dev, 0, EVENTQ_SIZE) != 0) {
        uart_puts("[virtio-input] queue setup failed\n");
        return -1;
    }

    g_evbuf = (struct virtio_input_event *)kcalloc(
        EVENTQ_SIZE, sizeof(struct virtio_input_event));
    if (!g_evbuf)
        return -1;

    virtio_driver_ok(&g_input_dev);

    /* Enable GIC line */
    gicd_enable_int((irq_no)g_input_dev.irq);

    g_input_ok = 1;
    refill_eventq();

    uart_printf("[virtio-input] keyboard ready (irq %u)\n", g_input_dev.irq);
    return 0;
}
