#pragma once

#include "minix.h"
#include <stddef.h>
#include <stdint.h>

#define BLOCK_SIZE 1024
/* 48MB in-memory disk — enough for Freedoom / large IWADs */
#define DISK_SIZE_BYTES (48UL * 1024UL * 1024UL)
#define BLOCK_NUM       (DISK_SIZE_BYTES / BLOCK_SIZE) /* 49152 */

extern uint8_t disk[DISK_SIZE_BYTES];

void blk_read(size_t block_num, uint8_t buffer[BLOCK_SIZE]);
void blk_write(size_t block_num, uint8_t buffer[BLOCK_SIZE]);
uint16_t alloc_inode(void);
uint16_t alloc_zone(void);
void free_inode(uint16_t inum);
void free_zone(uint16_t block_number);
void read_inode(uint16_t inum, struct inode *ip);
void write_inode(uint16_t inum, struct inode *ip);
void mkfs(void);
/* logical_block is zone index within the file (0..) */
uint16_t bmap(struct inode *ip, uint32_t logical_block, int allocate);
