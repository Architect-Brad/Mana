ENTRY(_start)

MEMORY
{
  RAM (rwx) : ORIGIN = 0x40000000, LENGTH = 256M
}

SECTIONS
{
  .text : 
  {
    *(.text*)
  } > RAM

  .data :
  {
    *(.data*)
  } > RAM

  .bss :
  {
    *(.bss*)
  } > RAM
  _heap_start = .;  
}
