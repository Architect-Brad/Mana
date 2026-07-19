# ─── Compilers & Linker ──────────────────────────────────────────────────
CC      = aarch64-linux-gnu-gcc
CXX     = aarch64-linux-gnu-g++
LD      = aarch64-linux-gnu-ld

# ─── Compiler Flags ──────────────────────────────────────────────────────
COMMON_FLAGS = -ffreestanding -nostdlib -nostartfiles -mcpu=cortex-a57 \
               -Wall -Wextra -g \
               -Isrc/kernel -Isrc/mm -Isrc/fs -Isrc/drivers -Isrc/lib

CFLAGS   = $(COMMON_FLAGS) -O2 -mgeneral-regs-only

# C++ allows FP/SIMD (path tracer uses NEON)
CXXFLAGS = -ffreestanding -nostdlib -nostartfiles -mcpu=cortex-a57+fp+simd \
            -Wall -Wextra -g -O3 -std=c++17 -fno-rtti -fno-exceptions \
            -fno-threadsafe-statics \
            -Isrc/kernel -Isrc/mm -Isrc/fs -Isrc/drivers -Isrc/lib

ASFLAGS  = $(COMMON_FLAGS)

# ─── Source & Build Directories ──────────────────────────────────────────
SRCDIR   = src
BUILDDIR = build

C_SRCS   = $(wildcard $(SRCDIR)/*/*.c)
ASM_SRCS = $(wildcard $(SRCDIR)/*/*.S)
CXX_SRCS = $(wildcard $(SRCDIR)/*/*.cpp)

C_OBJS   = $(C_SRCS:$(SRCDIR)/%.c=$(BUILDDIR)/%.o)
ASM_OBJS = $(ASM_SRCS:$(SRCDIR)/%.S=$(BUILDDIR)/%.o)
CXX_OBJS = $(CXX_SRCS:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)

OBJS     = $(C_OBJS) $(ASM_OBJS) $(CXX_OBJS)

# ─── Doom ────────────────────────────────────────────────────────────────
DOOM_ENGINE_DIR = doom/doom_src/linuxdoom-1.10
DOOM_PLATFORM   = doom

DOOM_ENGINE_SRCS = $(filter-out \
	$(DOOM_ENGINE_DIR)/i_video.c \
	$(DOOM_ENGINE_DIR)/i_sound.c \
	$(DOOM_ENGINE_DIR)/i_system.c \
	$(DOOM_ENGINE_DIR)/i_main.c \
	$(DOOM_ENGINE_DIR)/i_net.c \
	,$(wildcard $(DOOM_ENGINE_DIR)/*.c))

DOOM_PLATFORM_SRCS = \
	$(DOOM_PLATFORM)/i_video.c \
	$(DOOM_PLATFORM)/i_system.c \
	$(DOOM_PLATFORM)/i_sound.c \
	$(DOOM_PLATFORM)/i_keyboard.c \
	$(DOOM_PLATFORM)/i_net_stub.c \
	$(DOOM_PLATFORM)/compat/posix_io.c

DOOM_ENGINE_OBJS   = $(DOOM_ENGINE_SRCS:$(DOOM_ENGINE_DIR)/%.c=$(BUILDDIR)/doom/engine/%.o)
DOOM_PLATFORM_OBJS = $(DOOM_PLATFORM_SRCS:$(DOOM_PLATFORM)/%.c=$(BUILDDIR)/doom/%.o)
DOOM_OBJS          = $(DOOM_PLATFORM_OBJS) $(DOOM_ENGINE_OBJS)

# Engine: gnu89 (vanilla Doom). Platform: gnu11 (Mana i_*.c uses C99 loops).
DOOM_ENGINE_CFLAGS = $(COMMON_FLAGS) -O2 -std=gnu89 -fno-strict-aliasing \
	-Wno-unused -Wno-implicit-int -Wno-return-type \
	-Idoom -Idoom/compat -I$(DOOM_ENGINE_DIR) \
	-Isrc/kernel -Isrc/mm -Isrc/fs -Isrc/drivers -Isrc/lib \
	-DMANA_DOOM_ENABLED -DNORMALUNIX
DOOM_PLATFORM_CFLAGS = $(COMMON_FLAGS) -O2 -std=gnu11 -fno-strict-aliasing \
	-Wno-unused \
	-Idoom -Idoom/compat -I$(DOOM_ENGINE_DIR) \
	-Isrc/kernel -Isrc/mm -Isrc/fs -Isrc/drivers -Isrc/lib \
	-DMANA_DOOM_ENABLED -DNORMALUNIX

# range_t conflicts with system headers sometimes — rename if needed via -D

# ─── Pre-packed WAD disk (optional) ─────────────────────────────────────
DISK_IMG  = $(BUILDDIR)/disk.img
DISK_OBJ  = $(BUILDDIR)/fs/disk_image.o
WAD_FILE ?= assets/doom1.wad

# ─── Targets ─────────────────────────────────────────────────────────────
all: kernel.elf

# libc has soft-float math helpers — cannot use -mgeneral-regs-only
$(BUILDDIR)/lib/libc.o: $(SRCDIR)/lib/libc.c
	@mkdir -p $(dir $@)
	$(CC) $(COMMON_FLAGS) -O2 -c $< -o $@

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: $(SRCDIR)/%.S
	@mkdir -p $(dir $@)
	$(CC) $(ASFLAGS) -c $< -o $@

$(BUILDDIR)/doom/%.o: $(DOOM_PLATFORM)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(DOOM_PLATFORM_CFLAGS) -c $< -o $@

$(BUILDDIR)/doom/compat/%.o: $(DOOM_PLATFORM)/compat/%.c
	@mkdir -p $(dir $@)
	$(CC) $(DOOM_PLATFORM_CFLAGS) -c $< -o $@

$(BUILDDIR)/doom/engine/%.o: $(DOOM_ENGINE_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(DOOM_ENGINE_CFLAGS) -c $< -o $@

kernel.elf: $(OBJS)
	$(LD) -T linker.ld $(OBJS) -o $@

# Full Doom link (kernel + platform + engine)
# Recompile kernel.o with MANA_DOOM_ENABLED so cmd_doom() calls D_DoomMain.
doom: $(OBJS) $(DOOM_OBJS)
	$(CC) $(CFLAGS) -DMANA_DOOM_ENABLED -c src/kernel/kernel.c -o $(BUILDDIR)/kernel/kernel.o
	$(LD) -T linker.ld $(OBJS) $(DOOM_OBJS) -o kernel.elf
	@echo "Built kernel.elf with Doom engine."

# Platform objects only
doom-objects: $(OBJS) $(DOOM_PLATFORM_OBJS)
	@echo "Doom platform layer built."

# ── Build with pre-packed WAD disk ───────────────────────────────────────
$(DISK_IMG): $(WAD_FILE)
	python3 tools/pack_wad.py $(WAD_FILE)

$(DISK_OBJ): $(DISK_IMG)
	@mkdir -p $(dir $@)
	cd $(BUILDDIR) && aarch64-linux-gnu-objcopy -I binary -O elf64-littleaarch64 \
	    -B aarch64 disk.img fs/disk_image.o

doom-disk: $(OBJS) $(DOOM_OBJS) $(DISK_OBJ)
	@mkdir -p $(BUILDDIR)/fs
	$(CC) $(CFLAGS) -DMANA_PRELOADED_DISK -c src/fs/filesystem.c \
	    -o $(BUILDDIR)/fs/filesystem.o
	$(CC) $(CFLAGS) -DMANA_DOOM_ENABLED -c src/kernel/kernel.c \
	    -o $(BUILDDIR)/kernel/kernel.o
	$(LD) -T linker.ld \
	    $(filter-out $(BUILDDIR)/fs/filesystem.o,$(OBJS)) \
	    $(BUILDDIR)/fs/filesystem.o $(DISK_OBJ) $(DOOM_OBJS) \
	    -o kernel.elf
	@echo "Built kernel.elf with Doom + preloaded WAD disk."

# ── QEMU run targets ─────────────────────────────────────────────────────
run: kernel.elf
	qemu-system-aarch64 \
	  -machine virt,gic-version=2 \
	  -cpu cortex-a57 \
	  -m 256M \
	  -kernel kernel.elf \
	  -device ramfb \
	  -serial stdio

# Full virtio + keyboard + optional block (modern virtio-mmio)
run-virtio: kernel.elf
	qemu-system-aarch64 \
	  -machine virt,gic-version=2 \
	  -cpu cortex-a57 \
	  -m 256M \
	  -kernel kernel.elf \
	  -global virtio-mmio.force-legacy=false \
	  -device ramfb \
	  -device virtio-keyboard-device \
	  -drive if=none,id=vd0,file=$(DISK_IMG),format=raw \
	  -device virtio-blk-device,drive=vd0 \
	  -serial stdio

run-serial: kernel.elf
	qemu-system-aarch64 \
	  -machine virt,gic-version=2 \
	  -cpu cortex-a57 \
	  -m 256M \
	  -kernel kernel.elf \
	  -display none -nographic

debug: kernel.elf
	qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 256M \
	  -kernel kernel.elf -serial stdio -s -S

clean:
	rm -rf $(BUILDDIR) kernel.elf

.PHONY: all run run-serial run-virtio debug clean doom doom-objects doom-disk
