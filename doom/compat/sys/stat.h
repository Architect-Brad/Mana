#ifndef MANA_COMPAT_SYS_STAT_H
#define MANA_COMPAT_SYS_STAT_H
struct stat {
    long st_size;
    int  st_mode;
};
#define S_IFDIR 0040000
#define S_IFREG 0100000
int mkdir(const char *p, int m);
int stat(const char *p, struct stat *s);
int fstat(int fd, struct stat *s);
#endif
