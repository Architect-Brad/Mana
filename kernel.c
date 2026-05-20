#include "kmalloc.h"
#include "uart.h"
#include <stdint.h>
#include <stddef.h>
#include <stdarg.h>

void kmain(void)
{
   // const char* string = "hello manan this is mana";
  char* a = kmalloc(64);
  char* b = kmalloc(64);
  uart_printf("a: %d\n", a);
  uart_printf("b: %d\n", b);
  uart_printf("hi am manan and this is my kernel called %s i am %d years old", "Mana", 14);
   while(1);
}
