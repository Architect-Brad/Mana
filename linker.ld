ENTRY(_start)

MEMORY
{
  RAM (rwx) : ORIGIN = 0x40000000, LENGTH = 256M
}

SECTIONS
{
  .text :
  {
    . = ALIGN(2048);        /* Force 2 KB alignment for the vector table */
    _vectors_start = .;
    *(.vectors)             /* Put your .vectors section here */
    _vectors_end = .;

    _stext = .;
    *(.text*)               /* All other code follows */
    _etext = .;
  } > RAM

  .data :
  {
    _sdata = .;
    *(.data*)
    _edata = .;
  } > RAM

.bss :
  {
    . = ALIGN(16);
    _sbss = .;              /* Start of BSS bound */
    *(.bss*)
    *(COMMON)
    . = ALIGN(16);
    _ebss = .;              /* End of BSS bound */
  } > RAM

  /* Stack at top of RAM; grows down. Heap ends below the stack. */
  _stack_size = 0x100000; /* 1 MiB for Doom alloca + deep call chains */
  stack_top = 0x40000000 + 0x10000000;
  stack_bottom = stack_top - _stack_size;

  . = ALIGN(4096);
  _heap_start = .;
  _heap_max = stack_bottom;
}
