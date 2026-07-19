/* ─────────────────────────────────────────────────────────────────────────
 * boot.S — Mana kernel entry point
 *
 * This is the very first code that runs when QEMU hands us control.
 * No OS. No runtime. No safety net. Just us and the bare silicon.
 *
 * Responsibilities:
 *   1. Set the stack pointer (otherwise literally nothing works)
 *   2. Zero the BSS segment (the C standard requires it; QEMU fakes it;
 *      we don't rely on QEMU being polite)
 *   3. Call kmain() and never come back
 *
 * If kmain() ever returns, we spin forever. This is not a crash.
 * This is a philosophical position.
 * ───────────────────────────────────────────────────────────────────────── */

.section .text
.global _start
_start:
    /* Step 1: Stack. Without this, the very first function call corrupts
     * memory at address 0x0. AArch64 is unforgiving about this. */
    ldr x0, =stack_top
    mov sp, x0

    /* Step 2: Zero BSS.
     * The C standard guarantees zero-initialised globals are zero.
     * We guarantee it ourselves rather than hoping QEMU is in a good mood.
     * _sbss and _ebss are defined in linker.ld. */
    ldr x1, =_sbss
    ldr x2, =_ebss
.Lbss_clear_loop:
    cmp x1, x2
    b.ge .Lbss_clear_done
    str xzr, [x1], #8       /* write 8 zero bytes, advance pointer */
    b .Lbss_clear_loop
.Lbss_clear_done:

    /* Step 3: Enter C. Everything from here is kmain()'s problem. */
    bl kmain

    /* kmain() should never return. If it does, something has gone
     * very wrong. Spin here rather than executing whatever garbage
     * happens to be at the next address. */
.Lhalt:
    wfi
    b .Lhalt

/* stack_top provided by linker.ld (top of RAM, grows down toward heap) */
