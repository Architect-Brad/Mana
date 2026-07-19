/* ─────────────────────────────────────────────────────────────────────────
 * i_video.c — Mana video backend for vanilla Doom
 *
 * Doom renders into a 320×200 8-bit paletted buffer (screens[0]).
 * This layer:
 *   1. Converts the 256-colour palette to XRGB8888 on SetPalette().
 *   2. On FinishUpdate(), scales 320×200 → 1080×720 using nearest-neighbour
 *      and blits into the RAMFB.
 *
 * Nearest-neighbour scale is an integer-ish 3.375× (1080/320) horizontal
 * and 3.6× (720/200) vertical.  Good enough for the authentic Doom look.
 * ───────────────────────────────────────────────────────────────────────── */

#include "mana_platform.h"
#include "libc.h"    /* memset, memcpy */
#include "uart.h"

/* Doom engine headers (from vanilla Doom source) */
#include "doomtype.h"
#include "i_video.h"
#include "v_video.h"
#include "m_argv.h"

/* Converted palette: index → XRGB8888 */
static uint32_t doom_palette[256];

/* Doom's 8-bit pixel buffer.  Doom writes to screens[0]. */
byte *I_VideoBuffer = NULL;

/* Software fallback when QEMU ramfb / fw_cfg is unavailable (-display none). */
static uint32_t *soft_fb = NULL;

static int video_initialized = 0;

static uint32_t *video_fb(void) {
    uint32_t *fb = mana_get_framebuffer();
    if (fb)
        return fb;
    if (!soft_fb) {
        soft_fb = (uint32_t *)malloc(MANA_FB_WIDTH * MANA_FB_HEIGHT * sizeof(uint32_t));
        if (soft_fb)
            memset(soft_fb, 0, MANA_FB_WIDTH * MANA_FB_HEIGHT * sizeof(uint32_t));
    }
    return soft_fb;
}

/* ── I_InitGraphics ─────────────────────────────────────────────────────── */
void I_InitGraphics(void) {
    if (video_initialized) return;

    /* Allocate Doom's pixel buffer */
    I_VideoBuffer = (byte *)malloc(DOOM_WIDTH * DOOM_HEIGHT);
    if (!I_VideoBuffer) {
        mana_doom_error("I_InitGraphics: out of memory for pixel buffer");
    }
    memset(I_VideoBuffer, 0, DOOM_WIDTH * DOOM_HEIGHT);

    /* Wire up Doom's screen pointer */
    screens[0] = I_VideoBuffer;

    /* Clear framebuffer (RAMFB or software fallback) */
    uint32_t *fb = video_fb();
    if (fb) {
        memset(fb, 0, MANA_FB_WIDTH * MANA_FB_HEIGHT * sizeof(uint32_t));
        mana_flush_framebuffer();
    }

    video_initialized = 1;
    uart_puts("[Mana/Doom] I_InitGraphics ready\n");
}

void I_ShutdownGraphics(void) {
    if (I_VideoBuffer) {
        free(I_VideoBuffer);
        I_VideoBuffer = NULL;
        screens[0]   = NULL;
    }
}

/* ── I_SetPalette ───────────────────────────────────────────────────────── */
/* palette: 768 bytes — 256 × (R, G, B) in Doom's 6-bit-per-channel format */
void I_SetPalette(byte *palette) {
    mana_set_palette(palette);
    /* Also build our local 32-bit palette for the blit */
    for (int i = 0; i < 256; i++) {
        uint8_t r = (palette[i*3 + 0] << 2) | (palette[i*3 + 0] >> 4);
        uint8_t g = (palette[i*3 + 1] << 2) | (palette[i*3 + 1] >> 4);
        uint8_t b = (palette[i*3 + 2] << 2) | (palette[i*3 + 2] >> 4);
        doom_palette[i] = (0xFFu << 24) | ((uint32_t)r << 16) |
                          ((uint32_t)g << 8) | (uint32_t)b;
    }
}

/* ── I_FinishUpdate ─────────────────────────────────────────────────────── */
/* Scale 320×200 8-bpp → 1080×720 32-bpp and push to RAMFB. */
void I_FinishUpdate(void) {
    if (!video_initialized || !I_VideoBuffer) return;

    uint32_t *fb   = video_fb();
    byte     *src  = I_VideoBuffer;
    if (!fb) return;

    /* Fixed-point scale factors (16.16) */
    uint32_t x_step = (DOOM_WIDTH  << 16) / MANA_FB_WIDTH;
    uint32_t y_step = (DOOM_HEIGHT << 16) / MANA_FB_HEIGHT;
    uint32_t fy     = 0;

    for (int y = 0; y < MANA_FB_HEIGHT; y++) {
        uint32_t fx    = 0;
        int      src_y = (int)(fy >> 16);
        byte    *row   = src + src_y * DOOM_WIDTH;
        uint32_t *dst  = fb + y * MANA_FB_WIDTH;

        for (int x = 0; x < MANA_FB_WIDTH; x++) {
            dst[x] = doom_palette[row[fx >> 16]];
            fx += x_step;
        }
        fy += y_step;
    }

    mana_flush_framebuffer();
}

/* Stubs for functions Doom calls but we don't need.
 * I_StartTic lives in i_keyboard.c; I_StartFrame lives in i_system.c. */
void I_ReadScreen(byte *scr)      { memcpy(scr, I_VideoBuffer, DOOM_WIDTH * DOOM_HEIGHT); }
void I_BeginRead(void)            {}
void I_EndRead(void)              {}
void I_UpdateNoBlit(void)         {}
void I_WaitVBL(int count)         { (void)count; }
