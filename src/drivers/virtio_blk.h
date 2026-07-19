/* ─────────────────────────────────────────────────────────────────────────
 * virtio_blk.h — Virtio block device (persistent storage for Minix FS)
 * ───────────────────────────────────────────────────────────────────────── */
#ifndef MANA_VIRTIO_BLK_H
#define MANA_VIRTIO_BLK_H

#include <stddef.h>
#include <stdint.h>

/* Init virtio-blk. Returns 0 on success. */
int  virtio_blk_init(void);
int  virtio_blk_present(void);

/* Capacity in 512-byte sectors */
uint64_t virtio_blk_sectors(void);

/* Synchronous read/write. len must be a multiple of 512.
 * Returns 0 on success, -1 on error. */
int  virtio_blk_read(uint64_t sector, void *buf, size_t len);
int  virtio_blk_write(uint64_t sector, const void *buf, size_t len);

void virtio_blk_irq(void);
int  virtio_blk_irq_num(void);

#endif /* MANA_VIRTIO_BLK_H */
