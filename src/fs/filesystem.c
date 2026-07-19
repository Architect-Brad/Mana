#include "filesystem.h"
#include "kmalloc.h"
#include "minix.h"
#include <stdint.h>

static struct super_block sb;
struct inode s_inode;

static void ensure_superblock(void) {
  if (sb.s_magic == 0x137f || sb.s_magic == 0x137F)
    return;
  uint8_t block[BLOCK_SIZE];
  blk_read(1, block);
  sb = *(struct super_block *)block;
}

/* ── Disk storage ────────────────────────────────────────────────────────
 * By default, disk[] is zero-initialised (BSS). Run 'mkfs' at the shell
 * to format it, then use the filesystem normally.
 *
 * To pre-load a WAD file at build time:
 *   python3 tools/pack_wad.py doom1.wad
 * This generates src/fs/disk_image.c which defines disk[] with the WAD
 * already embedded. The Makefile picks it up automatically.
 * ─────────────────────────────────────────────────────────────────────── */
#ifdef MANA_PRELOADED_DISK
/* Linked from build/disk.img via objcopy (see Makefile doom-disk) */
extern uint8_t _binary_disk_img_start[];
#define disk _binary_disk_img_start
#else
uint8_t disk[DISK_SIZE_BYTES]; /* empty — format with 'mkfs' at runtime */
#endif

void blk_read(size_t block_num, uint8_t *buffer) {
  if (block_num >= BLOCK_NUM) {
    return;
  }
  size_t offset = block_num * BLOCK_SIZE;

  for (int i = 0; i < BLOCK_SIZE; i++) {
    buffer[i] = disk[offset + i];
  }
}

void blk_write(size_t block_num, uint8_t *buffer) {
  if (block_num >= BLOCK_NUM) {
    return;
  }
  size_t offset = block_num * BLOCK_SIZE;

  for (int i = 0; i < BLOCK_SIZE; i++) {
    disk[offset + i] = buffer[i];
  }
}

void mkfs() {
  uint8_t block[BLOCK_SIZE] = {0};
  blk_read(1, block);
  struct super_block *sba = (struct super_block *)block;
  sba->s_ninodes = 512;
  sba->s_nzones = (uint16_t)(BLOCK_NUM > 65535 ? 65535 : BLOCK_NUM);
  sba->s_imap_blocks = 1;
  sba->s_zmap_blocks = 8; /* covers 8*1024*8 = 65536 zone bits */
  sba->s_firstdatazone = 30;
  sba->s_log_zone_size = 0;
  sba->s_max_size = (uint32_t)DISK_SIZE_BYTES;
  sba->s_magic = 0x137f;

  blk_write(1, block);

  uint8_t imap_buf[BLOCK_SIZE] = {0};
  imap_buf[0] |= (1 << 0);
  blk_write(2, imap_buf);

  uint8_t zmap_buf_A[BLOCK_SIZE] = {0};
  uint8_t zmap_buf_B[BLOCK_SIZE] = {0};

  {
    uint8_t zmap_zero[BLOCK_SIZE] = {0};
    for (uint16_t zb = 0; zb < sba->s_zmap_blocks; zb++)
      blk_write(3 + zb, zmap_zero);
  }

  uint8_t inode_root[BLOCK_SIZE] = {0};
  uint16_t inode_table_start = 2 + sba->s_imap_blocks + sba->s_zmap_blocks;
  blk_read(inode_table_start, inode_root);

  uint8_t zero_block[BLOCK_SIZE] = {0};

  for (uint16_t blk = inode_table_start; blk < sba->s_firstdatazone; blk++) {
    blk_write(blk, zero_block);
  }
  struct inode *root = (struct inode *)inode_root;

  root->i_mode = 0x41ED;
  root->i_uid = 0;
  root->i_gid = 0;
  root->i_size = 0;
  root->i_time = 0;
  root->i_nlinks = 1;

  blk_write(inode_table_start, inode_root);

  sb.s_ninodes = sba->s_ninodes;
  sb.s_nzones = sba->s_nzones;
  sb.s_imap_blocks = sba->s_imap_blocks;
  sb.s_zmap_blocks = sba->s_zmap_blocks;
  sb.s_firstdatazone = sba->s_firstdatazone;
  sb.s_magic = sba->s_magic;
}

// Allocate a free inode, return its number (1-based), or 0 if full
uint16_t alloc_inode(void) {
  ensure_superblock();
  // Buffer large enough to hold the entire inode bitmap
  uint8_t bitmap[BLOCK_SIZE * sb.s_imap_blocks];

  // Read the inode bitmap from disk (starting at block 2)
  for (uint16_t blk = 0; blk < sb.s_imap_blocks; blk++) {
    blk_read(2 + blk, &bitmap[blk * BLOCK_SIZE]);
  }

  // Scan for a free inode (bit = 0)
  for (uint16_t ino = 0; ino < sb.s_ninodes; ino++) {
    uint16_t byte_index = ino / 8;
    uint8_t bit_pos = ino % 8;

    if (!(bitmap[byte_index] & (1 << bit_pos))) {
      // Found a free inode — mark it used (set bit to 1)
      bitmap[byte_index] |= (1 << bit_pos);

      // Write the modified block(s) back to disk
      // For simplicity, write all bitmap blocks (only one block in our case)
      for (uint16_t blk = 0; blk < sb.s_imap_blocks; blk++) {
        blk_write(2 + blk, &bitmap[blk * BLOCK_SIZE]);
      }

      // Inode numbers are 1‑based
      return ino + 1;
    }
  }

  // No free inode found
  return 0;
}

// AI function i made my own also but was verry bad compared to this so i am
// using this one only i understand it so good for me
uint16_t alloc_zone(void) {
  ensure_superblock();
  uint8_t bitmap[BLOCK_SIZE * 8]; /* max zmap blocks we support */
  if (sb.s_zmap_blocks > 8)
    return 0;

  uint16_t zmap0 = 2 + sb.s_imap_blocks;
  for (uint16_t blk = 0; blk < sb.s_zmap_blocks; blk++) {
    blk_read(zmap0 + blk, &bitmap[blk * BLOCK_SIZE]);
  }

  for (uint16_t b = 0; b < sb.s_nzones; b++) {
    uint16_t byte_index = b / 8;
    uint8_t bit_pos = b % 8;

    if (!(bitmap[byte_index] & (1 << bit_pos))) {
      bitmap[byte_index] |= (1 << bit_pos);

      for (uint16_t blk = 0; blk < sb.s_zmap_blocks; blk++) {
        blk_write(zmap0 + blk, &bitmap[blk * BLOCK_SIZE]);
      }

      return sb.s_firstdatazone + b;
    }
  }

  return 0; // disk full
}

void free_zone(uint16_t block_number) {
  ensure_superblock();
  uint16_t z = block_number - sb.s_firstdatazone;
  uint16_t zmap0 = 2 + sb.s_imap_blocks;
  uint16_t byte_number = z / 8;
  uint16_t blk = zmap0 + (byte_number / BLOCK_SIZE);
  uint16_t off = byte_number % BLOCK_SIZE;
  uint8_t bit_pos = z % 8;
  uint8_t bitmap[BLOCK_SIZE];
  blk_read(blk, bitmap);
  bitmap[off] &= (uint8_t)~(1u << bit_pos);
  blk_write(blk, bitmap);
}

void free_inode(uint16_t inum) {
  ensure_superblock();
  uint16_t ino = inum - 1; // bit index
  uint8_t bitmap[BLOCK_SIZE];
  blk_read(2, bitmap);

  uint16_t byte_number = ino / 8;
  uint8_t bit_pos = ino % 8;

  // Clear the bit (set to 0)
  bitmap[byte_number] &= ~(1 << bit_pos);

  blk_write(2, bitmap);
}

void read_inode(uint16_t inum, struct inode *ip) {
  ensure_superblock();
  uint16_t index = inum - 1;
  uint16_t itable = 2 + sb.s_imap_blocks + sb.s_zmap_blocks;
  uint16_t block_num = itable + (index / 32);
  uint16_t byte_offset = (index % 32) * 32;

  uint8_t block[BLOCK_SIZE];
  blk_read(block_num, block);

  *ip = *(struct inode *)(block + byte_offset);
}

void write_inode(uint16_t inum, struct inode *ip) {
  ensure_superblock();
  uint16_t index = inum - 1;
  uint16_t itable = 2 + sb.s_imap_blocks + sb.s_zmap_blocks;
  uint16_t block_num = itable + (index / 32);
  uint16_t byte_offset = (index % 32) * 32;

  uint8_t block[BLOCK_SIZE];
  blk_read(block_num, block);

  *(struct inode *)(block + byte_offset) = *ip;

  blk_write(block_num, block);
}

/* MINIX v1: 7 direct + single indirect (512) + double indirect (512*512) */
uint16_t bmap(struct inode *ip, uint32_t logical_block, int allocate) {
  /* Direct zones 0..6 */
  if (logical_block < 7) {
    uint16_t blk = ip->i_zone[logical_block];
    if (blk == 0 && allocate) {
      blk = alloc_zone();
      if (blk == 0)
        return 0;
      ip->i_zone[logical_block] = blk;
    }
    return blk;
  }

  /* Single indirect: logical 7 .. 7+511 */
  if (logical_block < 7 + 512) {
    uint16_t ind = ip->i_zone[7];
    if (ind == 0) {
      if (!allocate)
        return 0;
      ind = alloc_zone();
      if (ind == 0)
        return 0;
      ip->i_zone[7] = ind;
      {
        uint8_t z[BLOCK_SIZE];
        for (int i = 0; i < BLOCK_SIZE; i++)
          z[i] = 0;
        blk_write(ind, z);
      }
    }
    uint8_t ibuf[BLOCK_SIZE];
    blk_read(ind, ibuf);
    uint16_t *entries = (uint16_t *)ibuf;
    uint32_t idx = logical_block - 7;
    uint16_t blk = entries[idx];
    if (blk == 0 && allocate) {
      blk = alloc_zone();
      if (blk == 0)
        return 0;
      entries[idx] = blk;
      blk_write(ind, ibuf);
    }
    return blk;
  }

  /* Double indirect: logical 7+512 .. */
  {
    uint32_t di_index = logical_block - 7 - 512;
    uint32_t outer = di_index / 512;
    uint32_t inner = di_index % 512;
    if (outer >= 512)
      return 0;

    uint16_t dind = ip->i_zone[8];
    if (dind == 0) {
      if (!allocate)
        return 0;
      dind = alloc_zone();
      if (dind == 0)
        return 0;
      ip->i_zone[8] = dind;
      {
        uint8_t z[BLOCK_SIZE];
        for (int i = 0; i < BLOCK_SIZE; i++)
          z[i] = 0;
        blk_write(dind, z);
      }
    }

    uint8_t dbuf[BLOCK_SIZE];
    blk_read(dind, dbuf);
    uint16_t *dentries = (uint16_t *)dbuf;
    uint16_t sind = dentries[outer];
    if (sind == 0) {
      if (!allocate)
        return 0;
      sind = alloc_zone();
      if (sind == 0)
        return 0;
      dentries[outer] = sind;
      blk_write(dind, dbuf);
      {
        uint8_t z[BLOCK_SIZE];
        for (int i = 0; i < BLOCK_SIZE; i++)
          z[i] = 0;
        blk_write(sind, z);
      }
    }

    uint8_t sbuf[BLOCK_SIZE];
    blk_read(sind, sbuf);
    uint16_t *sentries = (uint16_t *)sbuf;
    uint16_t blk = sentries[inner];
    if (blk == 0 && allocate) {
      blk = alloc_zone();
      if (blk == 0)
        return 0;
      sentries[inner] = blk;
      blk_write(sind, sbuf);
    }
    return blk;
  }
}
