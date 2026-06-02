#include "mmu.h"
#include "kmalloc.h"
#include "uart.h"
#include <stdint.h>

uint64_t *L0; // global, used by assembly
extern void enable_mmu();

void init_mmu(uint64_t *bitmap) {
  L0 = (uint64_t *)allocate_page(bitmap, 1024);
  uint64_t *L1 = (uint64_t *)allocate_page(bitmap, 1024);
  uint64_t *L2_low = (uint64_t *)allocate_page(bitmap, 1024);
  uint64_t *L2_high = (uint64_t *)allocate_page(bitmap, 1024);

  for (int i = 0; i < 512; i++) {
    L0[i] = 0;
    L1[i] = 0;
    L2_low[i] = 0;
    L2_high[i] = 0;
  }

  L0[0] = (uintptr_t)L1 | 0x3;
  L1[0] = (uintptr_t)L2_low | 0x3;
  L1[1] = (uintptr_t)L2_high | 0x3;

  for (int i = 64; i < 82; i++) {
    uintptr_t addr = i * (2 * 1024 * 1024);
    uint64_t entry = addr | 0x1 | 0x400 | 0x300;

    if (addr >= 0x08000000 && addr <= 0x0A000000) {
      entry |= (1UL << 2);
      L2_low[i] = entry;

    } else {
      entry |= (0UL << 2);
    }
  }

  L2_low[224] = 0x1c000000 | 0x1 | 0x400 | 0x300 | (1UL << 2);
  for (int i = 0; i < 128; i++) {
    uintptr_t addr = 0x40000000 + i * (2 * 1024 * 1024);
    uint64_t entry = addr | 0x1 | 0x400 | 0x300;
    entry |= (0UL << 2);
    L2_high[i] = entry;
  }

  asm volatile("DSB SY");

  enable_mmu();
}
