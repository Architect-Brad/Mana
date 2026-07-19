/* ─────────────────────────────────────────────────────────────────────────
 * syscall.c — System call implementations
 * ───────────────────────────────────────────────────────────────────────── */
#include "syscall.h"
#include "task.h"
#include "uart.h"
#include "aarch64.h"
#include <stddef.h>

/* tasks[] is defined in sched.c */
extern struct task tasks[MAX_TASKS];

static long sys_write(long fd, const char *buf, long len) {
    if (!buf || len < 0)
        return -1;
    if (fd != 1 && fd != 2)
        return -1;
    for (long i = 0; i < len; i++)
        uart_putc(buf[i]);
    return len;
}

static long sys_read(long fd, char *buf, long len) {
    if (!buf || len <= 0)
        return -1;
    if (fd != 0)
        return -1;
    for (long i = 0; i < len; i++)
        buf[i] = uart_getchar();
    return len;
}

static long sys_puts(const char *s) {
    if (!s)
        return -1;
    uart_puts((char *)s);
    return 0;
}

static long sys_sleep_ms(long ms) {
    if (ms <= 0)
        return 0;
    uint64_t freq = raw_read_cntfrq_el0();
    if (freq == 0)
        freq = 62500000;
    uint64_t start = raw_read_cntvct_el0();
    uint64_t ticks = (freq / 1000) * (uint64_t)ms;
    while (raw_read_cntvct_el0() - start < ticks)
        ;
    return 0;
}

void syscall_dispatch(exception_frame *exc) {
    long num = (long)exc->x8;
    long a0  = (long)exc->x0;
    long a1  = (long)exc->x1;
    long a2  = (long)exc->x2;
    long ret = -1;

    /* Always skip the SVC instruction on return (unless we never return). */
    switch (num) {
    case SYS_WRITE:
        ret = sys_write(a0, (const char *)a1, a2);
        break;
    case SYS_READ:
        ret = sys_read(a0, (char *)a1, a2);
        break;
    case SYS_EXIT:
        exc->exc_elr += 4;
        exc->x0 = 0;
        task_exit((int)a0);
        return;
    case SYS_YIELD: {
        /* Cooperative yield: switch only if another non-idle READY task exists */
        int other = 0;
        for (int i = 0; i < MAX_TASKS; i++) {
            if (&tasks[i] != current && tasks[i].state == TASK_READY &&
                tasks[i].tid > 1) { /* skip idle (tid 1) */
                other = 1;
                break;
            }
        }
        exc->exc_elr += 4;
        exc->x0 = 0;
        if (other)
            sched_from_trap(exc);
        return;
    }
    case SYS_GETPID:
        ret = task_self();
        break;
    case SYS_PUTS:
        ret = sys_puts((const char *)a0);
        break;
    case SYS_SLEEP_MS:
        ret = sys_sleep_ms(a0);
        break;
    default:
        uart_printf("[syscall] unknown #%d\n", (int)num);
        ret = -1;
        break;
    }

    exc->x0 = (uint64_t)ret;
    exc->exc_elr += 4;
}
