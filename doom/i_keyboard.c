/* ─────────────────────────────────────────────────────────────────────────
 * i_keyboard.c — Mana keyboard backend for vanilla Doom
 *
 * Prefers virtio-input when present (real key up/down). Falls back to UART.
 * ───────────────────────────────────────────────────────────────────────── */

#include "mana_platform.h"
#include "libc.h"
#include "uart.h"
#include "virtio_input.h"

#include "doomtype.h"
#include "doomdef.h"
#include "d_event.h"
#include "d_main.h"
#include "i_video.h"

#define UART_BASE 0x09000000
#define UART_FR   (*(volatile uint32_t *)(UART_BASE + 0x18))
#define UART_DR   (*(volatile uint32_t *)(UART_BASE + 0x00))
#define UART_FR_RXFE (1 << 4)

static int uart_poll(void) {
    if (UART_FR & UART_FR_RXFE) return -1;
    return (int)(UART_DR & 0xFF);
}

/* Map Linux EV_KEY → Doom key codes (doomdef.h) */
static int linux_to_doom(uint16_t code) {
    switch (code) {
    case LINKEY_ESC:       return KEY_ESCAPE;
    case LINKEY_ENTER:     return KEY_ENTER;
    case LINKEY_SPACE:     return ' ';           /* use */
    case LINKEY_LEFTCTRL:  return KEY_RCTRL;     /* fire */
    case LINKEY_LEFTSHIFT: return KEY_RSHIFT;
    case LINKEY_TAB:       return KEY_TAB;
    case LINKEY_BACKSPACE: return KEY_BACKSPACE;
    case LINKEY_UP:        return KEY_UPARROW;
    case LINKEY_DOWN:      return KEY_DOWNARROW;
    case LINKEY_LEFT:      return KEY_LEFTARROW;
    case LINKEY_RIGHT:     return KEY_RIGHTARROW;
    case LINKEY_W:         return KEY_UPARROW;
    case LINKEY_S:         return KEY_DOWNARROW;
    case LINKEY_A:         return KEY_LEFTARROW;
    case LINKEY_D:         return KEY_RIGHTARROW;
    case LINKEY_R:         return KEY_RSHIFT;
    default:
        /* digit keys 1-7 are linux codes 2-8 */
        if (code >= LINKEY_1 && code <= LINKEY_1 + 6)
            return '1' + (int)(code - LINKEY_1);
        return 0;
    }
}

static int translate_uart(int raw) {
    switch (raw) {
    case 'w': case 'W': return KEY_UPARROW;
    case 's': case 'S': return KEY_DOWNARROW;
    case 'a': case 'A': return KEY_LEFTARROW;
    case 'd': case 'D': return KEY_RIGHTARROW;
    case ' ':            return KEY_RCTRL;  /* fire */
    case '\r': case '\n':return ' ';        /* use */
    case 0x1b:           return KEY_ESCAPE;
    case 0x08: case 0x7f:return KEY_BACKSPACE;
    case 'r': case 'R':  return KEY_RSHIFT;
    case '1': case '2': case '3': case '4':
    case '5': case '6': case '7': return raw;
    case '\t': return KEY_TAB;
    default: return raw;
    }
}

int mana_poll_key(void) {
    struct mana_key_event ev;
    if (virtio_input_present() && virtio_input_poll(&ev))
        return (int)ev.code;
    return uart_poll();
}

int mana_key_to_doom(int raw) { return translate_uart(raw); }

void I_StartTic(void) {
    if (virtio_input_present()) {
        struct mana_key_event ev;
        while (virtio_input_poll(&ev)) {
            int doomkey = linux_to_doom(ev.code);
            if (!doomkey)
                continue;
            event_t e;
            e.type  = (ev.value == 0) ? ev_keyup : ev_keydown;
            e.data1 = doomkey;
            e.data2 = 0;
            e.data3 = 0;
            D_PostEvent(&e);
        }
        return;
    }

    int raw;
    while ((raw = uart_poll()) != -1) {
        int doomkey = translate_uart(raw);
        event_t press   = { .type = ev_keydown, .data1 = doomkey };
        event_t release = { .type = ev_keyup,   .data1 = doomkey };
        D_PostEvent(&press);
        if (doomkey != KEY_UPARROW  && doomkey != KEY_DOWNARROW &&
            doomkey != KEY_LEFTARROW && doomkey != KEY_RIGHTARROW) {
            D_PostEvent(&release);
        }
    }
}

#include "filesystem.h"
#include "kmalloc.h"

typedef struct {
    struct inode inode;
    uint16_t     inum;
    size_t       size;
} wad_handle_t;

void *mana_open_wad(const char *path) {
    extern uint16_t namei(const char *name);
    uint16_t inum = namei(path);
    if (inum == 0) return NULL;

    wad_handle_t *h = (wad_handle_t *)kmalloc(sizeof(wad_handle_t));
    if (!h) return NULL;

    read_inode(inum, &h->inode);
    h->inum = inum;
    h->size = h->inode.i_size;
    return h;
}

int mana_read_wad(void *handle, void *buf, size_t len, size_t offset) {
    wad_handle_t *h   = (wad_handle_t *)handle;
    uint8_t      *dst = (uint8_t *)buf;
    size_t        nread = 0;

    while (len > 0) {
        size_t blk_idx  = offset / BLOCK_SIZE;
        size_t blk_off  = offset % BLOCK_SIZE;
        size_t to_read  = BLOCK_SIZE - blk_off;
        if (to_read > len) to_read = len;

        uint16_t blkno = bmap(&h->inode, (uint32_t)blk_idx, 0);
        if (blkno == 0) break;

        uint8_t blk_buf[BLOCK_SIZE];
        blk_read(blkno, blk_buf);
        memcpy(dst, blk_buf + blk_off, to_read);

        dst    += to_read;
        offset += to_read;
        len    -= to_read;
        nread  += to_read;
    }
    return (int)nread;
}

size_t mana_wad_size(void *handle) {
    return ((wad_handle_t *)handle)->size;
}

void mana_close_wad(void *handle) {
    kfree(handle);
}
