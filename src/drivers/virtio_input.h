/* ─────────────────────────────────────────────────────────────────────────
 * virtio_input.h — Virtio input (keyboard) for Doom / shell
 * ───────────────────────────────────────────────────────────────────────── */
#ifndef MANA_VIRTIO_INPUT_H
#define MANA_VIRTIO_INPUT_H

#include <stdint.h>

/* Linux input event types */
#define EV_SYN 0x00
#define EV_KEY 0x01

/* Linux KEY_* codes (avoid clashing with Doom KEY_* in doomdef.h) */
#define LINKEY_ESC        1
#define LINKEY_1          2
#define LINKEY_ENTER      28
#define LINKEY_LEFTCTRL   29
#define LINKEY_LEFTSHIFT  42
#define LINKEY_SPACE      57
#define LINKEY_UP         103
#define LINKEY_LEFT       105
#define LINKEY_RIGHT      106
#define LINKEY_DOWN       108
#define LINKEY_TAB        15
#define LINKEY_Q          16
#define LINKEY_W          17
#define LINKEY_A          30
#define LINKEY_S          31
#define LINKEY_D          32
#define LINKEY_R          19
#define LINKEY_BACKSPACE  14

struct mana_key_event {
    uint16_t code;   /* linux keycode */
    uint8_t  value;  /* 0=release, 1=press, 2=repeat */
    uint8_t  _pad;
};

int  virtio_input_init(void);
int  virtio_input_poll(struct mana_key_event *ev);
void virtio_input_irq(void);
int  virtio_input_irq_num(void);
int  virtio_input_present(void);

#endif /* MANA_VIRTIO_INPUT_H */
