#ifndef MANA_COMPAT_STDIO_H
#define MANA_COMPAT_STDIO_H
#include "libc.h"

int getchar(void);
void setbuf(void *f, char *b);
int fflush(void *f);
int fscanf(void *f, const char *fmt, ...);
int sscanf(const char *s, const char *fmt, ...);
#endif
