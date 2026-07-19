/* ─────────────────────────────────────────────────────────────────────────
 * i_system.c — Mana system backend for vanilla Doom
 *
 * Doom uses I_GetTime() for its 35 Hz game tick.  We drive that from
 * the ARM generic virtual timer (CNTVCT_EL0 / CNTFRQ_EL0).
 *
 * Error handling routes to uart_puts + infinite halt.
 * ───────────────────────────────────────────────────────────────────────── */

#include "mana_platform.h"
#include "libc.h"
#include "kmalloc.h"   /* memset */
#include "uart.h"
#include "aarch64.h"   /* raw_read_cntvct_el0, raw_read_cntfrq_el0 */

#include "doomtype.h"
#include "i_system.h"
#include "d_ticcmd.h"
#include "m_argv.h"

/* ── Timer ──────────────────────────────────────────────────────────────── */
/* Returns tick count at exactly 35 Hz.
 * tick = (CNTVCT_EL0 * 35) / CNTFRQ_EL0                                  */
int I_GetTime(void) {
    uint64_t cnt  = raw_read_cntvct_el0();
    uint64_t freq = (uint64_t)raw_read_cntfrq_el0();
    return (int)((cnt * 35ULL) / freq);
}

/* Same but in milliseconds — used by some Doom code paths */
int I_GetTimeMS(void) {
    uint64_t cnt  = raw_read_cntvct_el0();
    uint64_t freq = (uint64_t)raw_read_cntfrq_el0();
    return (int)((cnt * 1000ULL) / freq);
}

/* ── I_Init ─────────────────────────────────────────────────────────────── */
void I_Init(void) {
    uart_puts("[Mana/Doom] I_Init: system layer ready.\n");
}

/* Zone memory base — Doom asks for a big contiguous block */
byte *I_ZoneBase(int *size) {
    /* Freedoom / full IWAD needs more than classic shareware's ~6MB */
    const int zone = 16 * 1024 * 1024;
    byte *p = (byte *)malloc((size_t)zone);
    if (!p) {
        uart_puts("[Mana/Doom] I_ZoneBase: out of memory\n");
        *size = 0;
        return 0;
    }
    *size = zone;
    return p;
}

void I_StartFrame(void) {}

static ticcmd_t emptycmd;
ticcmd_t *I_BaseTiccmd(void) { return &emptycmd; }

void I_Tactile(int on, int off, int total) {
    (void)on; (void)off; (void)total;
}

/* ── I_Error ────────────────────────────────────────────────────────────── */
void I_Error(char *error, ...) {
    va_list ap;
    char    buf[256];

    va_start(ap, error);
    vsnprintf(buf, sizeof(buf), error, ap);
    va_end(ap);

    uart_puts("\n[Doom ERROR] ");
    uart_puts(buf);
    uart_puts("\n");

    while (1) asm volatile("wfi");
}

/* ── I_Quit ─────────────────────────────────────────────────────────────── */
void I_Quit(void) {
    uart_puts("[Mana/Doom] I_Quit called — returning to Mana shell.\n");
    /* In a real implementation we'd longjmp back to kmain's shell loop.
     * For now, halt cleanly. */
    while (1) asm volatile("wfi");
}

/* ── Memory ─────────────────────────────────────────────────────────────── */
/* Doom's I_AllocLow() allocates from the low memory pool.
 * On Mana there is no concept of "low" vs "high" memory; we just malloc. */
byte *I_AllocLow(int length) {
    byte *p = (byte *)malloc((size_t)length);
    if (!p) I_Error("I_AllocLow: out of memory (%d bytes)", length);
    memset(p, 0, (size_t)length);
    return p;
}

/* ── mana_platform.h helpers ────────────────────────────────────────────── */
int mana_get_ticks_35hz(void) { return I_GetTime(); }

void mana_doom_init(void) {
    uart_puts("[Mana] Preparing Doom platform layer...\n");
}

void mana_doom_error(const char *msg) {
    uart_puts("\n[Mana FATAL] ");
    uart_puts((char *)msg);
    uart_puts("\n");
    while (1) asm volatile("wfi");
}

/* RAMFB bridge */
uint32_t *mana_get_framebuffer(void) {
    extern uint32_t *ramfb_get_buffer(void);
    return ramfb_get_buffer();
}

void mana_flush_framebuffer(void) {
    /* RAMFB is memory-mapped; a DSB ensures the CPU has flushed writes. */
    asm volatile("dsb sy");
}

void mana_set_palette(const uint8_t *palette_rgb768) {
    /* Stored and used in i_video.c; nothing extra needed here. */
    (void)palette_rgb768;
}
