.section .text
.global _start
_start:
    ldr x0, =stack_top
    mov sp, x0

    bl kmain

hang:
    b hang

.global enable_fpu
.type enable_fpu, %function
enable_fpu:
    mov x0, #(3 << 20)
    msr cpacr_el1, x0
    isb
    ret

.section .bss
.align 16
stack_bottom:
    .space 65536
stack_top:
