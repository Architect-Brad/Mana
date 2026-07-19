#ifndef MANA_COMPAT_FCNTL_H
#define MANA_COMPAT_FCNTL_H
#define O_RDONLY 0
#define O_WRONLY 1
#define O_RDWR   2
#define O_CREAT  0x40
#define O_TRUNC  0x200
#define O_BINARY 0
int open(const char *p, int f, ...);
#endif
