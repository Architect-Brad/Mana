#include "timer.h"
#include "aarch64.h"
#include "board.h"
#include "gic.h"
#include "uart.h"
#include <stdint.h>

#define TIMER_DEBUG 0
#define TIMER_WAIT 1
static uint32_t cntfrq;
void timer_handler(void) {
  uint64_t ticks, current_cnt;
  disable_cntv();
  gicd_clear_pending(TIMER_IRQ);

  ticks = TIMER_WAIT * cntfrq;
  current_cnt = raw_read_cntvct_el0();
  raw_write_cntv_cval_el0(current_cnt + ticks);
  enable_cntv();
}

void timer_test(void) {
  uint64_t ticks, current_cnt;

  gic_v3_initialize();

  disable_cntv();

  cntfrq = raw_read_cntfrq_el0();
  /* Guard: some QEMU configs report 0 until first program */
  if (cntfrq == 0)
    cntfrq = 62500000; /* typical virt timer freq */

  ticks = (uint64_t)TIMER_WAIT * (uint64_t)cntfrq;

  current_cnt = raw_read_cntvct_el0();
  raw_write_cntv_cval_el0(current_cnt + ticks);

  enable_cntv();

  /* IRQs enabled after all drivers register their lines (see kmain). */
}

void timer_enable_irq(void) {
  enable_irq();
}
