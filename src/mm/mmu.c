#include "mmu.h"
#include "kmalloc.h"
#include "uart.h"
#include <stdint.h>

uint64_t *L0;
extern void enable_mmu(void);
static uint64_t *g_l2_high;

void mmu_enable_el0_ram(void) {
  int i;
  if (!g_l2_high)
    return;
  for (i = 0; i < 128; i++)
    g_l2_high[i] |= (1UL << 6);
  asm volatile("dsb ish; tlbi vmalle1is; dsb ish; isb" ::: "memory");
  uart_puts("[mmu] EL0 RW granted on DRAM\n");
}

void init_mmu(uint64_t *bitmap) {
  uint64_t *L1, *L2_low, *L2_high;
  int i;

  L0 = (uint64_t *)allocate_page(bitmap, 1024);
  L1 = (uint64_t *)allocate_page(bitmap, 1024);
  L2_low = (uint64_t *)allocate_page(bitmap, 1024);
  L2_high = (uint64_t *)allocate_page(bitmap, 1024);
  g_l2_high = L2_high;

  L0[0] = (uintptr_t)L1 | 0x3;
  L1[0] = (uintptr_t)L2_low | 0x3;
  L1[1] = (uintptr_t)L2_high | 0x3;

  /*
   * MAIR_EL1 (mmu_init.S): Attr0=0x00 Device-nGnRnE, Attr1=0xFF Normal WB.
   * Block descriptor: bit0=1 block, bits[4:2]=AttrIndx, bits[9:8]=SH,
   * bit10=AF. AP stays EL1-only until mmu_enable_el0_ram().
   *
   * QEMU virt MMIO lives in low PA (GIC/UART/virtio ~0x0800_0000–0x0c00_0000)
   * → Device (AttrIndx 0). DRAM at 0x4000_0000 → Normal (AttrIndx 1).
   */
  for (i = 64; i < 96; i++) {
    uintptr_t addr = (uintptr_t)i * (2UL * 1024 * 1024);
    /* Device-nGnRnE, outer-shareable, AF */
    L2_low[i] = addr | 0x1 | 0x400 | 0x300;
  }
  /* Extra Device window (legacy / peripherals) */
  L2_low[224] = 0x1c000000UL | 0x1 | 0x400 | 0x300;

  for (i = 0; i < 128; i++) {
    uintptr_t addr = 0x40000000UL + (uintptr_t)i * (2UL * 1024 * 1024);
    /* Normal WB (AttrIndx=1), outer-shareable, AF — required for heap/stack */
    L2_high[i] = addr | 0x1 | 0x400 | 0x300 | (1UL << 2);
  }

  asm volatile("dsb sy" ::: "memory");
  enable_mmu();
  uart_puts("[mmu] ready\n");
}
