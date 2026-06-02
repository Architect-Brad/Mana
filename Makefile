# ─── Compilers & Linker ──────────────────────────────────
CC      = aarch64-linux-gnu-gcc
CXX     = aarch64-linux-gnu-g++
LD      = aarch64-linux-gnu-ld

# ─── Compiler Flags Configuration ────────────────────────
# Base configurations shared across all components
COMMON_FLAGS = -ffreestanding -nostdlib -nostartfiles -mcpu=cortex-a57 \
               -Wall -Wextra -g \
               -Isrc/kernel -Isrc/mm -Isrc/fs -Isrc/drivers -Isrc/lib

# C Specific Flags: Enforces general-regs-only for basic kernel/ISR code
CFLAGS   = $(COMMON_FLAGS) -O2 -mgeneral-regs-only

# C++ Specific Flags: Explicitly allow hardware FP and SIMD (NEON) vectorization
CXXFLAGS = -ffreestanding -nostdlib -nostartfiles -mcpu=cortex-a57+fp+simd \
           -Wall -Wextra -g -O3 -std=c++17 -fno-rtti -fno-exceptions -fno-threadsafe-statics \
           -Isrc/kernel -Isrc/mm -Isrc/fs -Isrc/drivers -Isrc/lib

# Assembly Specific Flags: Clear of general-regs restrictions so FPU init code is valid
ASFLAGS  = $(COMMON_FLAGS)

# ─── Source & Build Directories ─────────────────────────
SRCDIR  = src
BUILDDIR = build

C_SRCS   = $(wildcard $(SRCDIR)/*/*.c)
ASM_SRCS = $(wildcard $(SRCDIR)/*/*.S)
CXX_SRCS = $(wildcard $(SRCDIR)/*/*.cpp)

C_OBJS   = $(C_SRCS:$(SRCDIR)/%.c=$(BUILDDIR)/%.o)
ASM_OBJS = $(ASM_SRCS:$(SRCDIR)/%.S=$(BUILDDIR)/%.o)
CXX_OBJS = $(CXX_SRCS:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)

OBJS     = $(C_OBJS) $(ASM_OBJS) $(CXX_OBJS)

# ─── Targets ─────────────────────────────────────────────
all: kernel.elf

# Pattern rule for C files
$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Pattern rule for C++ files
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Pattern rule for assembly files (FIXED: Now uses ASFLAGS instead of CFLAGS)
$(BUILDDIR)/%.o: $(SRCDIR)/%.S
	@mkdir -p $(dir $@)
	$(CC) $(ASFLAGS) -c $< -o $@

kernel.elf: $(OBJS)
	$(LD) -T linker.ld $(OBJS) -o $@

run: kernel.elf
	qemu-system-aarch64 \
	  -machine virt,gic-version=2 \
	  -cpu cortex-a57 \
	  -m 256M \
	  -kernel kernel.elf \
	  -device ramfb \
	  -serial stdio 

debug: kernel.elf
	qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 256M -kernel kernel.elf -serial stdio -s -S

clean:
	rm -rf $(BUILDDIR) kernel.elf

compile_commands.json: clean
	bear -- make

.PHONY: all run debug clean
