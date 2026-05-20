#ifndef UART_H
#define UART_H

#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>

#define UART_BASE 0x09000000
#define UART_PTR ((volatile unsigned char *)UART_BASE)

void uart_putc(char a);
void uart_puts(char *string);
void uart_putd(int n);
void uart_printf(char *string, ...);

#endif
