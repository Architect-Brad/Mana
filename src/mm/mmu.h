#pragma once
#include <stdint.h>

void init_mmu(uint64_t *bitmap);
/* Optional: set AP=EL0 RW on DRAM after MMU is on (for usertest). */
void mmu_enable_el0_ram(void);
void mmu_enable_el0_ram(void);
