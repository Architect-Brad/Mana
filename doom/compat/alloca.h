#ifndef MANA_COMPAT_ALLOCA_H
#define MANA_COMPAT_ALLOCA_H
/* Prefer compiler builtin; provide symbol fallback in posix_io.c */
#define alloca(size) __builtin_alloca(size)
#endif
