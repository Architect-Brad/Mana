CC = aarch64-linux-gnu-gcc
LD = aarch64-linux-gnu-ld
# Added architecture specific flags and safety warnings
CFLAGS = -ffreestanding -nostdlib -nostartfiles -mcpu=cortex-a57 -mgeneral-regs-only -Wall -Wextra -g

OBJ = boot.o kernel.o uart.o kmalloc.o

all: kernel.elf

# Pattern rule: compiles any .S or .c into .o
%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
	
kernel.elf: $(OBJ)
	$(LD) -T linker.ld $(OBJ) -o kernel.elf

run: kernel.elf
	qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 256M -kernel kernel.elf -nographic

# Added debug rule to make it easier to fix hangs
debug: kernel.elf
	qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 256M -kernel kernel.elf -nographic -s -S

clean:
	rm -f *.o kernel.elf
