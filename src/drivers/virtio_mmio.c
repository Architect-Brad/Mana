/* ─────────────────────────────────────────────────────────────────────────
 * virtio_mmio.c — Virtio 1.0 MMIO transport
 * ───────────────────────────────────────────────────────────────────────── */
#include "virtio_mmio.h"
#include "kmalloc.h"
#include "uart.h"
#include <stddef.h>

int virtio_find_device(uint32_t device_id, struct virtio_device *out) {
    int saw_magic = 0;
    for (int slot = 0; slot < VIRTIO_MMIO_MAX_SLOTS; slot++) {
        volatile uint32_t *regs =
            (volatile uint32_t *)(VIRTIO_MMIO_BASE + (uint64_t)slot * VIRTIO_MMIO_STRIDE);

        uint32_t magic = regs[VIRTIO_MMIO_MAGIC_VALUE / 4];
        if (magic != VIRTIO_MMIO_MAGIC)
            continue;
        saw_magic++;

        uint32_t version = regs[VIRTIO_MMIO_VERSION / 4];
        uint32_t id      = regs[VIRTIO_MMIO_DEVICE_ID / 4];
        if (id == 0)
            continue; /* empty slot */

        if (id != device_id)
            continue;

        /* Prefer modern (version 2). Accept version 1 only if nothing else. */
        if (version < 1)
            continue;

        out->regs      = regs;
        out->irq       = VIRTIO_MMIO_IRQ_BASE + (uint32_t)slot;
        out->device_id = id;
        out->features  = 0;
        out->nq        = 0;
        out->slot      = slot;

        /* Reset device */
        virtio_w32(out, VIRTIO_MMIO_STATUS, 0);
        virtio_w32(out, VIRTIO_MMIO_STATUS, VIRTIO_STATUS_ACKNOWLEDGE);
        virtio_w32(out, VIRTIO_MMIO_STATUS,
                   VIRTIO_STATUS_ACKNOWLEDGE | VIRTIO_STATUS_DRIVER);

        uart_printf("[virtio] found id=%u slot=%d ver=%u irq=%u\n",
                    id, slot, version, out->irq);
        return 0;
    }
    if (!saw_magic) {
        /* One-shot diagnostic: is the MMIO window mapped? */
        volatile uint32_t *r0 = (volatile uint32_t *)VIRTIO_MMIO_BASE;
        uart_printf("[virtio] no mmio magic @%x (slot0=%x) — use QEMU "
                    "virtio-mmio or -device virtio-*-device\n",
                    (unsigned)VIRTIO_MMIO_BASE, (unsigned)r0[0]);
    }
    return -1;
}

uint64_t virtio_negotiate_features(struct virtio_device *d, uint64_t want) {
    /* Read device features (lo + hi) */
    virtio_w32(d, VIRTIO_MMIO_DEVICE_FEATURES_SEL, 0);
    uint64_t dev = virtio_r32(d, VIRTIO_MMIO_DEVICE_FEATURES);
    virtio_w32(d, VIRTIO_MMIO_DEVICE_FEATURES_SEL, 1);
    dev |= ((uint64_t)virtio_r32(d, VIRTIO_MMIO_DEVICE_FEATURES)) << 32;

    uint64_t negotiated = dev & want;
    /* Always require VERSION_1 for modern */
    negotiated |= VIRTIO_F_VERSION_1;
    if (!(dev & VIRTIO_F_VERSION_1)) {
        uart_puts("[virtio] device missing VERSION_1\n");
        virtio_w32(d, VIRTIO_MMIO_STATUS, VIRTIO_STATUS_FAILED);
        return 0;
    }

    virtio_w32(d, VIRTIO_MMIO_DRIVER_FEATURES_SEL, 0);
    virtio_w32(d, VIRTIO_MMIO_DRIVER_FEATURES, (uint32_t)negotiated);
    virtio_w32(d, VIRTIO_MMIO_DRIVER_FEATURES_SEL, 1);
    virtio_w32(d, VIRTIO_MMIO_DRIVER_FEATURES, (uint32_t)(negotiated >> 32));

    uint32_t st = virtio_r32(d, VIRTIO_MMIO_STATUS);
    virtio_w32(d, VIRTIO_MMIO_STATUS, st | VIRTIO_STATUS_FEATURES_OK);
    st = virtio_r32(d, VIRTIO_MMIO_STATUS);
    if (!(st & VIRTIO_STATUS_FEATURES_OK)) {
        uart_puts("[virtio] FEATURES_OK rejected\n");
        virtio_w32(d, VIRTIO_MMIO_STATUS, VIRTIO_STATUS_FAILED);
        return 0;
    }

    d->features = negotiated;
    return negotiated;
}

/* Align up to 16 for rings */
static size_t align16(size_t n) { return (n + 15) & ~(size_t)15; }

int virtio_setup_queue(struct virtio_device *d, int qidx, uint16_t qsize) {
    if (qidx < 0 || qidx >= 4)
        return -1;

    virtio_w32(d, VIRTIO_MMIO_QUEUE_SEL, (uint32_t)qidx);
    uint32_t max = virtio_r32(d, VIRTIO_MMIO_QUEUE_NUM_MAX);
    if (max == 0)
        return -1;
    if (qsize > max)
        qsize = (uint16_t)max;
    if (qsize < 2)
        return -1;

    /* Layout: desc[qsize] | avail | used  (page-ish contiguous blob) */
    size_t desc_sz  = sizeof(struct virtq_desc) * qsize;
    size_t avail_sz = sizeof(uint16_t) * (3 + qsize); /* flags, idx, ring[qsize], used_event */
    size_t used_sz  = sizeof(uint16_t) * 3 + sizeof(struct virtq_used_elem) * qsize;
    size_t total    = align16(desc_sz) + align16(avail_sz) + align16(used_sz);

    uint8_t *mem = (uint8_t *)kmalloc(total + 64);
    if (!mem)
        return -1;
    /* 16-byte align */
    uintptr_t base = ((uintptr_t)mem + 15) & ~(uintptr_t)15;
    uint8_t *p = (uint8_t *)base;

    struct virtq_desc  *desc  = (struct virtq_desc *)p;
    p += align16(desc_sz);
    struct virtq_avail *avail = (struct virtq_avail *)p;
    p += align16(avail_sz);
    struct virtq_used  *used  = (struct virtq_used *)p;

    /* Free list: 0 → 1 → … → qsize-1 → 0xFFFF */
    for (uint16_t i = 0; i < qsize; i++) {
        desc[i].addr  = 0;
        desc[i].len   = 0;
        desc[i].flags = 0;
        desc[i].next  = (uint16_t)(i + 1);
    }
    desc[qsize - 1].next = 0xFFFF;

    avail->flags = 0;
    avail->idx   = 0;
    used->flags  = 0;
    used->idx    = 0;

    struct virtqueue *vq = &d->vq[qidx];
    vq->qsize         = qsize;
    vq->free_head     = 0;
    vq->num_free      = qsize;
    vq->last_used_idx = 0;
    vq->desc          = desc;
    vq->avail         = avail;
    vq->used          = used;
    vq->notify_cookie = d;

    virtio_w32(d, VIRTIO_MMIO_QUEUE_NUM, qsize);

    uint64_t da = (uint64_t)(uintptr_t)desc;
    uint64_t aa = (uint64_t)(uintptr_t)avail;
    uint64_t ua = (uint64_t)(uintptr_t)used;

    virtio_w32(d, VIRTIO_MMIO_QUEUE_DESC_LOW,  (uint32_t)da);
    virtio_w32(d, VIRTIO_MMIO_QUEUE_DESC_HIGH, (uint32_t)(da >> 32));
    virtio_w32(d, VIRTIO_MMIO_QUEUE_AVAIL_LOW, (uint32_t)aa);
    virtio_w32(d, VIRTIO_MMIO_QUEUE_AVAIL_HIGH,(uint32_t)(aa >> 32));
    virtio_w32(d, VIRTIO_MMIO_QUEUE_USED_LOW,  (uint32_t)ua);
    virtio_w32(d, VIRTIO_MMIO_QUEUE_USED_HIGH, (uint32_t)(ua >> 32));

    virtio_w32(d, VIRTIO_MMIO_QUEUE_READY, 1);

    if (qidx + 1 > d->nq)
        d->nq = qidx + 1;

    return 0;
}

void virtio_driver_ok(struct virtio_device *d) {
    uint32_t st = virtio_r32(d, VIRTIO_MMIO_STATUS);
    virtio_w32(d, VIRTIO_MMIO_STATUS, st | VIRTIO_STATUS_DRIVER_OK);
}

int virtq_alloc_desc(struct virtqueue *vq) {
    if (vq->num_free == 0)
        return -1;
    uint16_t i = vq->free_head;
    vq->free_head = vq->desc[i].next;
    vq->num_free--;
    vq->desc[i].next  = 0;
    vq->desc[i].flags = 0;
    return (int)i;
}

void virtq_free_desc_chain(struct virtqueue *vq, uint16_t head) {
    uint16_t i = head;
    for (;;) {
        uint16_t next = vq->desc[i].next;
        int last = !(vq->desc[i].flags & VIRTQ_DESC_F_NEXT);
        vq->desc[i].next  = vq->free_head;
        vq->desc[i].flags = 0;
        vq->free_head     = i;
        vq->num_free++;
        if (last)
            break;
        i = next;
    }
}

void virtq_push(struct virtqueue *vq, uint16_t head) {
    uint16_t idx = vq->avail->idx % vq->qsize;
    /* ring is flexible array — access via pointer arithmetic */
    uint16_t *ring = (uint16_t *)((uint8_t *)vq->avail + 4);
    ring[idx] = head;
    __asm__ __volatile__("dmb sy" ::: "memory");
    vq->avail->idx++;
    __asm__ __volatile__("dmb sy" ::: "memory");
}

void virtq_notify(struct virtio_device *d, int qidx) {
    virtio_w32(d, VIRTIO_MMIO_QUEUE_NOTIFY, (uint32_t)qidx);
}

int virtq_pop_used(struct virtqueue *vq, uint16_t *id_out, uint32_t *len_out) {
    __asm__ __volatile__("dmb sy" ::: "memory");
    if (vq->last_used_idx == vq->used->idx)
        return 0;

    uint16_t i = vq->last_used_idx % vq->qsize;
    struct virtq_used_elem *ring =
        (struct virtq_used_elem *)((uint8_t *)vq->used + 4);
    if (id_out)
        *id_out = (uint16_t)ring[i].id;
    if (len_out)
        *len_out = ring[i].len;
    vq->last_used_idx++;
    return 1;
}

uint32_t virtio_ack_interrupt(struct virtio_device *d) {
    uint32_t st = virtio_r32(d, VIRTIO_MMIO_INTERRUPT_STATUS);
    if (st)
        virtio_w32(d, VIRTIO_MMIO_INTERRUPT_ACK, st);
    return st;
}
