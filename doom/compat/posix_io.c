/* ─────────────────────────────────────────────────────────────────────────
 * posix_io.c — POSIX fd / string helpers for Doom on Mana
 *
 * open/read/lseek/close/fstat map onto Minix FS so W_InitMultipleFiles works.
 * ───────────────────────────────────────────────────────────────────────── */
#include "filesystem.h"
#include "commands.h"
#include "kmalloc.h"
#include "libc.h"
#include "uart.h"

#include <stddef.h>
#include <stdint.h>

/* ── open file table ───────────────────────────────────────────────────── */
#define MAX_FDS 16

struct mana_fd {
    int          used;
    uint16_t     inum;
    uint32_t     size;
    uint32_t     pos;
};

static struct mana_fd g_fds[MAX_FDS];

static int fd_alloc(void) {
    int i;
    for (i = 3; i < MAX_FDS; i++) { /* 0-2 reserved */
        if (!g_fds[i].used)
            return i;
    }
    return -1;
}

int open(const char *path, int flags, ...) {
    const char *orig = path;
    (void)flags;
    if (!path)
        return -1;
    if (path[0] == '.' && path[1] == '/')
        path += 2;

    uint16_t inum = namei(path);
    if (inum == 0) {
        uart_puts("[open] namei fail: ");
        uart_puts((char *)orig);
        uart_puts("\n");
        return -1;
    }

    int fd = fd_alloc();
    if (fd < 0) {
        uart_puts("[open] fd_alloc fail\n");
        return -1;
    }

    struct inode ip;
    read_inode(inum, &ip);

    g_fds[fd].used = 1;
    g_fds[fd].inum = inum;
    g_fds[fd].size = ip.i_size;
    g_fds[fd].pos  = 0;
    return fd;
}

int close(int fd) {
    if (fd < 0 || fd >= MAX_FDS || !g_fds[fd].used)
        return -1;
    g_fds[fd].used = 0;
    return 0;
}

long read(int fd, void *buf, unsigned long n) {
    if (fd < 0 || fd >= MAX_FDS || !g_fds[fd].used || !buf) {
        uart_printf("[read] bad fd=%d used=%d buf=%x\n", fd,
                    (fd >= 0 && fd < MAX_FDS) ? g_fds[fd].used : -1,
                    (unsigned)(uintptr_t)buf);
        return -1;
    }

    struct mana_fd *f = &g_fds[fd];
    uint8_t *dst = (uint8_t *)buf;
    uint32_t remaining = (f->size > f->pos) ? (f->size - f->pos) : 0;
    if (n > remaining)
        n = remaining;
    unsigned long to_read = n;
    unsigned long total = n;

    struct inode ip;
    read_inode(f->inum, &ip);

    while (to_read > 0) {
        uint32_t blk_idx = f->pos / BLOCK_SIZE;
        uint32_t blk_off = f->pos % BLOCK_SIZE;
        uint32_t chunk   = BLOCK_SIZE - blk_off;
        if (chunk > to_read)
            chunk = (uint32_t)to_read;

        uint16_t blkno = bmap(&ip, blk_idx, 0);
        if (blkno == 0)
            break;

        uint8_t blk_buf[BLOCK_SIZE];
        blk_read(blkno, blk_buf);
        memcpy(dst, blk_buf + blk_off, chunk);

        dst     += chunk;
        f->pos  += chunk;
        to_read -= chunk;
    }
    return (long)(n - to_read);
}

long write(int fd, const void *buf, unsigned long n) {
    if (fd == 1 || fd == 2) {
        const char *p = (const char *)buf;
        unsigned long i;
        for (i = 0; i < n; i++)
            uart_putc(p[i]);
        return (long)n;
    }
    (void)buf;
    return -1;
}

long lseek(int fd, long offset, int whence) {
    if (fd < 0 || fd >= MAX_FDS || !g_fds[fd].used)
        return -1;
    struct mana_fd *f = &g_fds[fd];
    long new_pos;
    switch (whence) {
    case 0: /* SEEK_SET */ new_pos = offset; break;
    case 1: /* SEEK_CUR */ new_pos = (long)f->pos + offset; break;
    case 2: /* SEEK_END */ new_pos = (long)f->size + offset; break;
    default: return -1;
    }
    if (new_pos < 0)
        return -1;
    f->pos = (uint32_t)new_pos;
    return new_pos;
}

int access(const char *path, int mode) {
    (void)mode;
    if (!path)
        return -1;
    if (path[0] == '.' && path[1] == '/')
        path += 2;
    return namei(path) != 0 ? 0 : -1;
}

struct stat {
    long st_size;
    int  st_mode;
};

int fstat(int fd, struct stat *st) {
    if (fd < 0 || fd >= MAX_FDS || !g_fds[fd].used || !st)
        return -1;
    st->st_size = (long)g_fds[fd].size;
    st->st_mode = 0100000; /* regular */
    return 0;
}

int stat(const char *path, struct stat *st) {
    if (!path || !st)
        return -1;
    if (path[0] == '.' && path[1] == '/')
        path += 2;
    uint16_t inum = namei(path);
    if (inum == 0)
        return -1;
    struct inode ip;
    read_inode(inum, &ip);
    st->st_size = (long)ip.i_size;
    st->st_mode = 0100000;
    return 0;
}

int mkdir(const char *p, int m) {
    (void)p;
    (void)m;
    return -1;
}

int unlink(const char *p) {
    (void)p;
    return -1;
}

char *getcwd(char *b, size_t n) {
    if (b && n) {
        b[0] = '/';
        if (n > 1)
            b[1] = 0;
    }
    return b;
}

int fscanf(void *f, const char *fmt, ...) {
    (void)f;
    (void)fmt;
    return 0;
}

int sscanf(const char *s, const char *fmt, ...) {
    (void)s;
    (void)fmt;
    return 0;
}

/* ── stdio helpers ─────────────────────────────────────────────────────── */
int getchar(void) {
    return (int)(unsigned char)uart_getchar();
}

void setbuf(void *f, char *b) {
    (void)f;
    (void)b;
}

int fflush(void *f) {
    (void)f;
    return 0;
}

/* ── case-insensitive strings ──────────────────────────────────────────── */
int strcasecmp(const char *a, const char *b) {
    while (*a && *b) {
        unsigned char ca = (unsigned char)*a;
        unsigned char cb = (unsigned char)*b;
        if (ca >= 'A' && ca <= 'Z') ca = (unsigned char)(ca + 32);
        if (cb >= 'A' && cb <= 'Z') cb = (unsigned char)(cb + 32);
        if (ca != cb)
            return (int)ca - (int)cb;
        a++;
        b++;
    }
    return (unsigned char)*a - (unsigned char)*b;
}

int strncasecmp(const char *a, const char *b, size_t n) {
    while (n && *a && *b) {
        unsigned char ca = (unsigned char)*a;
        unsigned char cb = (unsigned char)*b;
        if (ca >= 'A' && ca <= 'Z') ca = (unsigned char)(ca + 32);
        if (cb >= 'A' && cb <= 'Z') cb = (unsigned char)(cb + 32);
        if (ca != cb)
            return (int)ca - (int)cb;
        a++;
        b++;
        n--;
    }
    if (!n)
        return 0;
    return (unsigned char)*a - (unsigned char)*b;
}

/* Fallback if anything still emits a call to alloca */
void *alloca(size_t size) {
    /* Not freeable — only for short-lived Doom paths that previously used stack.
     * Prefer __builtin_alloca via alloca.h; this is a last resort. */
    return kmalloc(size);
}
