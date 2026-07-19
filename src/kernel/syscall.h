/* ─────────────────────────────────────────────────────────────────────────
 * syscall.h — Mana system call numbers and EL0 wrappers
 *
 * ABI: x8 = number, x0–x5 = args, x0 = return; SVC #0
 * ───────────────────────────────────────────────────────────────────────── */
#ifndef MANA_SYSCALL_H
#define MANA_SYSCALL_H

#include "exception.h"
#include <stdint.h>

#define SYS_WRITE    1
#define SYS_READ     2
#define SYS_EXIT     3
#define SYS_YIELD    4
#define SYS_GETPID   5
#define SYS_PUTS     6
#define SYS_SLEEP_MS 7

void syscall_dispatch(exception_frame *exc);

/*
 * Inline SVC wrappers. Clobber all caller-saved regs the kernel may touch
 * via the trapframe restore (we only guarantee x0 return + preserved x19–x28
 * if the compiler used them — list broad clobbers for safety).
 */
static inline long mana_syscall0(long n) {
    register long x8 __asm__("x8") = n;
    register long x0 __asm__("x0");
    __asm__ __volatile__(
        "svc #0"
        : "=r"(x0)
        : "r"(x8)
        : "x1", "x2", "x3", "x4", "x5", "x6", "x7",
          "x9", "x10", "x11", "x12", "x13", "x14", "x15",
          "x16", "x17", "x18", "memory", "cc");
    return x0;
}

static inline long mana_syscall1(long n, long a0) {
    register long x8 __asm__("x8") = n;
    register long x0 __asm__("x0") = a0;
    __asm__ __volatile__(
        "svc #0"
        : "+r"(x0)
        : "r"(x8)
        : "x1", "x2", "x3", "x4", "x5", "x6", "x7",
          "x9", "x10", "x11", "x12", "x13", "x14", "x15",
          "x16", "x17", "x18", "memory", "cc");
    return x0;
}

static inline long mana_syscall3(long n, long a0, long a1, long a2) {
    register long x8 __asm__("x8") = n;
    register long x0 __asm__("x0") = a0;
    register long x1 __asm__("x1") = a1;
    register long x2 __asm__("x2") = a2;
    __asm__ __volatile__(
        "svc #0"
        : "+r"(x0)
        : "r"(x8), "r"(x1), "r"(x2)
        : "x3", "x4", "x5", "x6", "x7",
          "x9", "x10", "x11", "x12", "x13", "x14", "x15",
          "x16", "x17", "x18", "memory", "cc");
    return x0;
}

#endif /* MANA_SYSCALL_H */
