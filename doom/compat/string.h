#ifndef MANA_COMPAT_STRING_H
#define MANA_COMPAT_STRING_H
#include "libc.h"
#include "kmalloc.h"

int strcasecmp(const char *a, const char *b);
int strncasecmp(const char *a, const char *b, size_t n);
#endif
