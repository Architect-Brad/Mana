#include "uart.h"


void uart_putc(char a)
{
  *UART_PTR = a;
}

void uart_puts(char* string)
{
  for(int i = 0; string[i] != '\0'; i++)
  {
    uart_putc(string[i]);
  }
}

void uart_putd(int n)
{
    char buf[20];
    int i = 0;
    
    if(n < 0)
    {
        uart_putc('-');
        n = -n;
    }
    
    if(n == 0)
    {
        uart_putc('0');
        return;
    }
    
    while(n > 0)
    {
        buf[i++] = '0' + (n % 10);
        n /= 10;
    }
    
    // print in reverse
    for(int j = i - 1; j >= 0; j--)
        uart_putc(buf[j]);
}

void uart_printf(char* string, ...)
{
  va_list args;
  va_start(args, string);
  
  for(int i = 0; string[i] != '\0'; i++)
  {
    if(string[i] == '%')
    {
      i++;
      if(string[i] == 'd')
      {
        int num_arg = va_arg(args, int);
        uart_putd(num_arg);
      }
      else if(string[i] == 's')
      {
        char* char_arg = va_arg(args, char*);
        uart_puts(char_arg);
      }
    }
    else
    {
      uart_putc(string[i]);
    }

  }

  va_end(args);
  
}

