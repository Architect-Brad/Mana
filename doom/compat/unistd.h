#ifndef MANA_COMPAT_UNISTD_H
#define MANA_COMPAT_UNISTD_H
#include <stddef.h>
typedef long off_t;
typedef int pid_t;

int access(const char *p, int m);
int close(int fd);
long read(int fd, void *b, unsigned long n);
long write(int fd, const void *b, unsigned long n);
long lseek(int fd, long offset, int whence);
int unlink(const char *p);
char *getcwd(char *b, size_t n);

#define R_OK 4
#define W_OK 2
#define X_OK 1
#define F_OK 0
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2
#endif
