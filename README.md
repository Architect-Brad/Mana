<div align="center">

# MANA

*A bare-metal AArch64 microkernel that has absolutely no business working as well as it does.*

[![Architecture](https://img.shields.io/badge/arch-AArch64-blue)]()
[![Target](https://img.shields.io/badge/target-QEMU%20virt-orange)]()
[![Doom](https://img.shields.io/badge/doom-game%20loop-brightgreen)]()
[![OS beneath it](https://img.shields.io/badge/OS%20beneath%20it-none-black)]()

</div>

---

## Lineage

This project stands on a foundation built by **[Manan Bhardwaj](https://github.com/Valt445)**, who had the audacity to write a path tracer in a freestanding C++17 environment with no operating system, no standard library, and apparently no fear.
The original repository produced a real MINIX filesystem, a working GIC interrupt controller, and 128-sample path-traced renders at 1080×720 on bare metal.
That's not a tutorial project. That's legitimate systems work, and it deserved to be taken further.

**The Architect** has since taken ownership of this repository. Goals are bigger. Comments are worse. Doom is coming.

---

## What Mana is

A bare-metal kernel for the QEMU `virt` machine (Cortex-A57, 256MB RAM).
No libc. No OS. No safety net. Just you, the hardware, and your poor decisions.

```
Boot → zero BSS → set up MMU → init GIC → drive RAMFB → run Doom
```

Things it currently does, which it probably shouldn't:

- Boots on bare metal via a short assembly stub and immediately enters C
- Manages memory with a free-list heap (`kmalloc` / `kfree` / `krealloc`) and identity-mapped MMU
  (Normal WB for DRAM, Device-nGnRnE for MMIO)
- Runs a MINIX v1 filesystem; can pack a full IWAD into a preloaded RAM disk (`tools/pack_wad.py`)
- Drives a 1080×720 RAMFB via QEMU `fw_cfg` when available; falls back to a software framebuffer under `-display none`
- Handles AArch64 exceptions and prints a register dump when things go sideways
- Renders a path-traced scene at 128 samples/pixel in C++17 with no host math library
- Links **linuxdoom-1.10**, opens the WAD from the Minix FS, and runs the full init path into **`D_DoomLoop`**
- Probes **virtio-mmio** keyboard + block (modern transport)
- Has a cooperative scheduler + SVC ABI (`puts`, `getpid`, `yield`, …) with a multi-SVC shell demo

---

## Goals

### Immediate
- [x] Fix the five bugs the original codebase shipped with (you're welcome)
- [x] Replace the bump allocator with a proper `kfree()`-capable free-list heap
- [x] Write a freestanding libc shim so Doom has `malloc`, `printf`, and friends
- [x] Write the full Doom platform layer (`i_video`, `i_system`, `i_sound`, `i_keyboard`)
- [x] Wire in the vanilla Doom engine source and actually link it
- [x] Get a WAD file onto the filesystem (pack Freedoom / IWAD → Minix image → link into kernel)
- [x] Boot into Doom from the shell (`doom` command → game loop / demos)

### Medium term
- [x] Virtio-input keyboard driver (probe + IRQ path; wire into Doom events still TODO)
- [x] Virtio-blk block device (modern virtio-mmio; QEMU needs `force-legacy=false`)
- [x] Process scheduler (cooperative RR + timer tick)
- [x] System call interface (x8 ABI, multi-SVC from EL1 works)
- [ ] User mode (EL0) multi-SVC with clean return-to-shell
- [ ] Doom playable input on virtio-keyboard + visible frame on real RAMFB

### Long term  
- [ ] Run Doom at a locked 35 Hz with no frame drops on a machine that has never heard of vsync
- [ ] A second program. Any program.
- [ ] Potentially: networking. Probably not. But we said it.

---

## Building

### Prerequisites

You need the AArch64 cross-compiler toolchain and QEMU. That's it.
No CMake. No Autotools. No 47-step bootstrap process. Just `make`.

---

### Linux (Debian / Ubuntu)

```bash
sudo apt update
sudo apt install gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu qemu-system-aarch64 make

git clone https://github.com/Architect-Brad/Mana.git
cd mana
make
make run
```

---

### Linux (Arch / Manjaro)

```bash
sudo pacman -S aarch64-linux-gnu-gcc aarch64-linux-gnu-binutils qemu-system-aarch64 make

git clone https://github.com/Architect-Brad/Mana.git
cd mana
make
make run
```

---

### macOS

Homebrew does the heavy lifting. No judgment if you're developing a bare-metal kernel on macOS.
Actually, a little judgment.

```bash
# Install Homebrew if you somehow don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install aarch64-elf-gcc aarch64-elf-binutils qemu make

git clone https://github.com/Architect-Brad/Mana.git
cd mana
make
make run
```

> **Note for Apple Silicon (M1/M2/M3):** You're cross-compiling AArch64 on AArch64.
> The irony is not lost on us. It works fine.

---

### Windows (WSL2)

Do not attempt this in native Windows. Use WSL2. Ubuntu works.

```powershell
# In PowerShell (Admin)
wsl --install -d Ubuntu
```

Then follow the Linux (Debian / Ubuntu) instructions inside your WSL2 shell.
QEMU's display won't work inside WSL2 by default — add `-display none` to the QEMU flags
or set up an X server (VcXsrv or WSLg). The serial output via `-serial stdio` will work fine.

```bash
# WSL2-safe run command (serial only, no display window needed)
qemu-system-aarch64 \
  -machine virt,gic-version=2 \
  -cpu cortex-a57 \
  -m 256M \
  -kernel kernel.elf \
  -serial stdio \
  -display none
```

---

### Docker (if you enjoy containers for some reason)

```dockerfile
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y \
    gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu \
    qemu-system-aarch64 make git
WORKDIR /mana
COPY . .
RUN make
```

```bash
docker build -t mana .
docker run --rm mana qemu-system-aarch64 \
  -machine virt -cpu cortex-a57 -m 256M \
  -kernel kernel.elf -serial stdio -display none -nographic
```

---

## Make targets

```bash
make                # build kernel.elf (includes Doom when MANA_DOOM_ENABLED)
make run            # build and launch in QEMU
make clean          # delete build/ and kernel.elf
make doom-disk      # pack assets/doom1.wad into build/disk.img and rebuild
```

### WAD / disk image

Place a Freedoom or Doom IWAD at `assets/doom1.wad` (not committed; obtain separately), then:

```bash
make doom-disk
```

That packs the WAD into a Minix image and links it into the kernel for the embedded FS.

### Doom + modern virtio (QEMU)

```bash
qemu-system-aarch64 \
  -machine virt,gic-version=2 -cpu cortex-a57 -m 256M \
  -kernel kernel.elf -nographic \
  -global virtio-mmio.force-legacy=false \
  -drive if=none,id=hd0,file=build/disk.img,format=raw \
  -device virtio-blk-device,drive=hd0 \
  -device virtio-keyboard-device
```

At the shell: type `doom` to hand control to the engine.  
Other useful commands: `usertest` (multi-SVC demo), `virtio` (re-probe devices), `render` (path tracer).

---

## Shell commands

Once booted, you get a spartan shell. It does not have tab completion.
It does not have history. It does not have your feelings.

```
ls                      list current directory
cd <dir>                change directory
mkdir <dir>             create a directory
touch <file>            create an empty file
echo <text>             print text (riveting)
echo <text> > <file>    write text to a file
rm <name>               delete file or directory, no confirmation, no regrets
mv <src> <dst>          move or rename
mkfs                    format the RAM disk (destructive, obviously)
render                  run the path tracer — takes a while, outputs to display when available
doom                    start Doom (needs packed IWAD on the Minix image)
usertest                multi-SVC puts/getpid demo
virtio                  re-probe virtio-input / virtio-blk
help                    list commands
```

---

## Project layout

```
mana/
├── src/
│   ├── kernel/     Boot, exceptions, GIC, sched, syscall, user EL0 helpers
│   ├── mm/         Free-list heap + MMU (Normal DRAM / Device MMIO)
│   ├── drivers/    UART, RAMFB, timer, virtio-mmio / input / blk
│   ├── fs/         MINIX v1 filesystem
│   ├── lib/        Shell commands + freestanding libc
│   └── path_tracer C++17 path tracer, bare metal
├── doom/
│   ├── doom_src/       linuxdoom-1.10 + license
│   ├── compat/         freestanding POSIX headers + open/read for Minix
│   ├── i_*.c           Mana platform layer (video, system, sound, keyboard)
│   └── PORTING.md
├── tools/pack_wad.py   Pack IWAD into Minix disk image
├── assets/             Place doom1.wad here (gitignored)
├── linker.ld
├── Makefile
├── CONTRIBUTING.md
└── README.md
```

---

## Attribution

Original work: **[Manan Bhardwaj](https://github.com/Valt445)** — built the foundation, made the hard decisions, wrote a C++ path tracer on bare metal for apparently no reason. Respect.

Current maintainer: **[The Architect](https://github.com/Architect-Brad)** — inherited the chaos, fixed the bugs, and is now trying to run a 1993 shooter on hardware that has never heard of DirectX.

→ **Fork:** [github.com/Architect-Brad/Mana](https://github.com/Architect-Brad/Mana)

This project is open source. Use it, fork it, learn from it, or stare at it in confusion. All valid.
