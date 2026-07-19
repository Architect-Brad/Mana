/* ─────────────────────────────────────────────────────────────────────────
 * virtio_mmio.h — Virtio 1.0 MMIO transport for QEMU virt
 *
 * QEMU virt provides up to 32 virtio-mmio slots at:
 *   base = 0x0a000000 + slot * 0x200
 *   irq  = 48 + slot   (SPI 16+slot → GIC ID 32+16+slot)
 * ───────────────────────────────────────────────────────────────────────── */
#ifndef MANA_VIRTIO_MMIO_H
#define MANA_VIRTIO_MMIO_H

#include <stddef.h>
#include <stdint.h>

#define VIRTIO_MMIO_BASE        0x0a000000UL
#define VIRTIO_MMIO_STRIDE      0x200
#define VIRTIO_MMIO_IRQ_BASE    48          /* first virtio-mmio GIC IRQ */
#define VIRTIO_MMIO_MAX_SLOTS   32

/* Magic "virt" little-endian */
#define VIRTIO_MMIO_MAGIC       0x74726976

/* Device IDs */
#define VIRTIO_ID_BLOCK         2
#define VIRTIO_ID_INPUT         18

/* Feature bits (common) */
#define VIRTIO_F_VERSION_1      (1ULL << 32)

/* Status bits */
#define VIRTIO_STATUS_ACKNOWLEDGE   1
#define VIRTIO_STATUS_DRIVER        2
#define VIRTIO_STATUS_DRIVER_OK     4
#define VIRTIO_STATUS_FEATURES_OK   8
#define VIRTIO_STATUS_FAILED        128

/* Queue descriptor flags */
#define VIRTQ_DESC_F_NEXT       1
#define VIRTQ_DESC_F_WRITE      2
#define VIRTQ_DESC_F_INDIRECT   4

/* Used ring flags */
#define VIRTQ_USED_F_NO_NOTIFY  1
#define VIRTQ_AVAIL_F_NO_INTERRUPT 1

/* MMIO register offsets (virtio 1.0, legacy=off) */
#define VIRTIO_MMIO_MAGIC_VALUE         0x000
#define VIRTIO_MMIO_VERSION             0x004
#define VIRTIO_MMIO_DEVICE_ID           0x008
#define VIRTIO_MMIO_VENDOR_ID           0x00c
#define VIRTIO_MMIO_DEVICE_FEATURES     0x010
#define VIRTIO_MMIO_DEVICE_FEATURES_SEL 0x014
#define VIRTIO_MMIO_DRIVER_FEATURES     0x020
#define VIRTIO_MMIO_DRIVER_FEATURES_SEL 0x024
#define VIRTIO_MMIO_QUEUE_SEL           0x030
#define VIRTIO_MMIO_QUEUE_NUM_MAX       0x034
#define VIRTIO_MMIO_QUEUE_NUM           0x038
#define VIRTIO_MMIO_QUEUE_READY         0x044
#define VIRTIO_MMIO_QUEUE_NOTIFY        0x050
#define VIRTIO_MMIO_INTERRUPT_STATUS    0x060
#define VIRTIO_MMIO_INTERRUPT_ACK       0x064
#define VIRTIO_MMIO_STATUS              0x070
#define VIRTIO_MMIO_QUEUE_DESC_LOW      0x080
#define VIRTIO_MMIO_QUEUE_DESC_HIGH     0x084
#define VIRTIO_MMIO_QUEUE_AVAIL_LOW     0x090
#define VIRTIO_MMIO_QUEUE_AVAIL_HIGH    0x094
#define VIRTIO_MMIO_QUEUE_USED_LOW      0x0a0
#define VIRTIO_MMIO_QUEUE_USED_HIGH     0x0a4
#define VIRTIO_MMIO_CONFIG_GENERATION   0x0fc
#define VIRTIO_MMIO_CONFIG              0x100

struct virtq_desc {
    uint64_t addr;
    uint32_t len;
    uint16_t flags;
    uint16_t next;
} __attribute__((packed));

struct virtq_avail {
    uint16_t flags;
    uint16_t idx;
    uint16_t ring[];   /* flexible; sized by queue */
} __attribute__((packed));

struct virtq_used_elem {
    uint32_t id;
    uint32_t len;
} __attribute__((packed));

struct virtq_used {
    uint16_t flags;
    uint16_t idx;
    struct virtq_used_elem ring[];
} __attribute__((packed));

/* One virtqueue */
struct virtqueue {
    uint16_t            qsize;
    uint16_t            free_head;
    uint16_t            num_free;
    uint16_t            last_used_idx;
    struct virtq_desc  *desc;
    struct virtq_avail *avail;
    struct virtq_used  *used;
    void               *notify_cookie; /* parent device */
};

/* One MMIO transport + device */
struct virtio_device {
    volatile uint32_t *regs;
    uint32_t           irq;
    uint32_t           device_id;
    uint64_t           features;
    struct virtqueue   vq[4];
    int                nq;
    int                slot;
};

static inline uint32_t virtio_r32(struct virtio_device *d, uint32_t off) {
    return d->regs[off / 4];
}

static inline void virtio_w32(struct virtio_device *d, uint32_t off, uint32_t v) {
    d->regs[off / 4] = v;
}

/* Scan slots for a device with the given ID. Returns 0 on success. */
int  virtio_find_device(uint32_t device_id, struct virtio_device *out);

/* Negotiate features (caller ORs desired bits into want; returns negotiated). */
uint64_t virtio_negotiate_features(struct virtio_device *d, uint64_t want);

/* Allocate and program queue `qidx` with `qsize` descriptors (power of 2). */
int  virtio_setup_queue(struct virtio_device *d, int qidx, uint16_t qsize);

/* Mark driver OK / enable interrupts path */
void virtio_driver_ok(struct virtio_device *d);

/* Descriptor helpers */
int  virtq_alloc_desc(struct virtqueue *vq);
void virtq_free_desc_chain(struct virtqueue *vq, uint16_t head);
void virtq_push(struct virtqueue *vq, uint16_t head);
void virtq_notify(struct virtio_device *d, int qidx);
int  virtq_pop_used(struct virtqueue *vq, uint16_t *id_out, uint32_t *len_out);

/* Ack MMIO interrupt; returns status bits */
uint32_t virtio_ack_interrupt(struct virtio_device *d);

#endif /* MANA_VIRTIO_MMIO_H */
