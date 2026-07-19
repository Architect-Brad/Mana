# Porting Doom to Mana — Field Manual

## What we have

The `doom/` directory contains the **Mana platform layer**: the four
`i_*.c` files that vanilla Doom calls into for video, audio, input, and
system services.  These are fully written and bridge Doom to the Mana kernel.

```
doom/
├── mana_platform.h   — contract between Doom engine and Mana hardware
├── i_video.c         — 320×200 → 1080×720 scaler, RAMFB blit
├── i_system.c        — 35 Hz timer (ARM generic timer), error, memory
├── i_sound.c         — audio stubs (silent — no driver yet)
└── i_keyboard.c      — UART keyboard + WAD I/O via Minix FS
```

## Current status (engine linked)

The vanilla engine is wired. Build with:

```bash
# doom/doom_src already cloned from id-Software/DOOM; platform files removed
make doom          # kernel + platform + engine → kernel.elf
make run           # QEMU virt + RAMFB
```

Shell command `doom` calls `D_DoomMain()` when built with `make doom`.

### Still needed for playable Doom

1. **WAD on the filesystem**
   ```bash
   python3 tools/pack_wad.py doom1.wad   # shareware IWAD
   make doom-disk                        # or pack then make doom
   ```
2. **RAMFB in QEMU** — use `make run` (includes `-device ramfb`), not headless-only
3. **Virtio keyboard** (optional) — shell command `virtio`, or `make run-virtio`

### Compat layer

`doom/compat/` provides freestanding shims (`stdio`, `unistd`, `fcntl`, …)
and `doom/compat/posix_io.c` implements `open`/`read`/`lseek` on Minix FS
so `w_wad.c` can load the IWAD.

## Architecture summary

```
D_DoomMain() [Doom engine]
    │
    ├─ I_InitGraphics()  → i_video.c  → RAMFB (1080×720)
    ├─ I_Init()          → i_system.c → ARM timer
    ├─ I_InitSound()     → i_sound.c  → (stub)
    ├─ I_StartTic()      → i_keyboard.c → UART poll → D_PostEvent()
    ├─ I_GetTime()       → i_system.c → CNTVCT_EL0 / CNTFRQ_EL0
    ├─ I_FinishUpdate()  → i_video.c  → palette convert + nearest-neighbour scale
    └─ W_InitFiles()     → w_wad.c    → fopen() → mana_open_wad() → Minix FS
```

## Known gaps

| Gap | Solution |
|-----|----------|
| No `fopen/fclose/fread` in libc | Implement in `src/lib/libc.c` routing to Minix FS |
| No keyboard up events from UART | Replace with virtio-input driver for real key-up |
| No sound | OPL2 via QEMU sound card, or accept silence |
| WAD not in FS yet | Build a tool to pack the Minix image offline |
| `myargc`/`myargv` not wired | Add 3 lines to `kmain()` |
