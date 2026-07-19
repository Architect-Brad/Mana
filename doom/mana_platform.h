/* ─────────────────────────────────────────────────────────────────────────
 * mana_platform.h — Doom platform bridge for Mana kernel
 *
 * This header is the contract between the vanilla Doom engine and the
 * Mana hardware layer.  Include it in every Doom i_*.c file.
 *
 * Doom engine → calls i_video.c, i_system.c, i_sound.c, i_keyboard.c
 * i_*.c       → calls functions declared here (backed by kernel drivers)
 * ───────────────────────────────────────────────────────────────────────── */

#ifndef MANA_PLATFORM_H
#define MANA_PLATFORM_H

#include <stddef.h>
#include <stdint.h>

/* ── Framebuffer ────────────────────────────────────────────────────────── */
/* RAMFB is 1080×720 XRGB8888.
 * Doom's native resolution is 320×200.  The Mana video layer scales up. */

#define MANA_FB_WIDTH   1080
#define MANA_FB_HEIGHT  720
#define DOOM_WIDTH       320
#define DOOM_HEIGHT      200

uint32_t *mana_get_framebuffer(void);  /* returns raw_framebuffer pointer */
void      mana_flush_framebuffer(void);

/* ── Palette ────────────────────────────────────────────────────────────── */
/* Doom uses an 8-bit palettized renderer — 256 × RGB triplets.
 * The Mana video layer converts palette + 8-bit pixels to 32-bit XRGB. */
void mana_set_palette(const uint8_t *palette_rgb768);

/* ── Timer (35 Hz Doom tick) ────────────────────────────────────────────── */
/* Returns a monotonically increasing tick counter at 35 Hz.
 * Backed by the ARM generic timer (CNTFRQ_EL0 / CNTVCT_EL0). */
int mana_get_ticks_35hz(void);

/* ── Keyboard input ─────────────────────────────────────────────────────── */
/* Returns a Doom key event, or -1 if no key is pending.
 * Currently backed by UART; replace with virtio-input when available. */
int  mana_poll_key(void);
int  mana_key_to_doom(int raw);   /* translate platform key → Doom key code */

/* ── WAD file I/O ───────────────────────────────────────────────────────── */
/* Doom loads its WAD from the filesystem.  These wrap the Mana Minix FS.  */
void  *mana_open_wad(const char *path);   /* returns opaque handle */
int    mana_read_wad(void *handle, void *buf, size_t len, size_t offset);
size_t mana_wad_size(void *handle);
void   mana_close_wad(void *handle);

/* ── System ─────────────────────────────────────────────────────────────── */
void mana_doom_init(void);    /* call before D_DoomMain() */
void mana_doom_error(const char *msg) __attribute__((noreturn));

#endif /* MANA_PLATFORM_H */
