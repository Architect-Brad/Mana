/* ─────────────────────────────────────────────────────────────────────────
 * libc.c — Mana freestanding libc shim
 *
 * Implementation of hosted C library functions on Mana kernel primitives.
 * All I/O routes to uart_putc / uart_printf.
 * All heap operations route to kmalloc / kfree.
 * All file operations route to the Minix FS.
 * ───────────────────────────────────────────────────────────────────────── */

#include "libc.h"
#include "kmalloc.h"
#include "uart.h"

/* ── Memory ─────────────────────────────────────────────────────────────── */

void *malloc(size_t size)            { return kmalloc(size); }
void  free(void *ptr)                { kfree(ptr); }
void *realloc(void *ptr, size_t sz)  { return krealloc(ptr, sz); }
void *calloc(size_t n, size_t size)  { return kcalloc(n, size); }

void *memcpy(void *dst, const void *src, size_t n) {
    uint8_t       *d = dst;
    const uint8_t *s = src;
    while (n--) *d++ = *s++;
    return dst;
}

void *memmove(void *dst, const void *src, size_t n) {
    uint8_t       *d = dst;
    const uint8_t *s = src;
    if (d < s) {
        while (n--) *d++ = *s++;
    } else {
        d += n; s += n;
        while (n--) *--d = *--s;
    }
    return dst;
}

int memcmp(const void *a, const void *b, size_t n) {
    const uint8_t *p = a, *q = b;
    while (n--) {
        if (*p != *q) return (int)*p - (int)*q;
        p++; q++;
    }
    return 0;
}

/* ── Strings ────────────────────────────────────────────────────────────── */

size_t strlen(const char *s) {
    const char *p = s;
    while (*p) p++;
    return (size_t)(p - s);
}

char *strcpy(char *dst, const char *src) {
    char *d = dst;
    while ((*d++ = *src++) != '\0');
    return dst;
}

char *strncpy(char *dst, const char *src, size_t n) {
    /* Must never write more than n bytes. The common
     *   while (n && (*d++ = *src++) != '\0') n--;
     * form is wrong: on an early NUL it still writes the NUL, does not
     * decrement n, then the pad loop writes n more NULs — one past the
     * limit. That zeroed lumpinfo_t.handle right after name[8] in Doom. */
    char *d = dst;
    while (n > 0 && *src != '\0') {
        *d++ = *src++;
        n--;
    }
    while (n > 0) {
        *d++ = '\0';
        n--;
    }
    return dst;
}

char *strcat(char *dst, const char *src) {
    char *d = dst + strlen(dst);
    while ((*d++ = *src++) != '\0');
    return dst;
}

char *strncat(char *dst, const char *src, size_t n) {
    char *d = dst + strlen(dst);
    while (n-- && *src) *d++ = *src++;
    *d = '\0';
    return dst;
}

int strcmp(const char *a, const char *b) {
    while (*a && *a == *b) { a++; b++; }
    return (unsigned char)*a - (unsigned char)*b;
}

int strncmp(const char *a, const char *b, size_t n) {
    /* Do not post-decrement n in the while condition: when n hits 0,
     * size_t underflow to SIZE_MAX would keep the loop going. */
    while (n > 0 && *a && *a == *b) {
        a++;
        b++;
        n--;
    }
    if (n == 0)
        return 0;
    return (unsigned char)*a - (unsigned char)*b;
}

char *strchr(const char *s, int c) {
    for (; *s; s++) if (*s == (char)c) return (char *)s;
    return (c == '\0') ? (char *)s : NULL;
}

char *strrchr(const char *s, int c) {
    const char *last = NULL;
    for (; *s; s++) if (*s == (char)c) last = s;
    return (char *)last;
}

char *strstr(const char *hay, const char *needle) {
    if (!*needle) return (char *)hay;
    size_t nlen = strlen(needle);
    for (; *hay; hay++) {
        if (*hay == *needle && strncmp(hay, needle, nlen) == 0)
            return (char *)hay;
    }
    return NULL;
}

char *strdup(const char *s) {
    size_t n = strlen(s) + 1;
    char  *p = malloc(n);
    if (p) memcpy(p, s, n);
    return p;
}

/* ── Conversion ─────────────────────────────────────────────────────────── */

int atoi(const char *s) { return (int)strtol(s, NULL, 10); }

long atol(const char *s) { return strtol(s, NULL, 10); }

long strtol(const char *s, char **end, int base) {
    while (isspace((unsigned char)*s)) s++;
    int neg = 0;
    if (*s == '-') { neg = 1; s++; }
    else if (*s == '+') s++;

    if (base == 0) {
        if (*s == '0' && (s[1] == 'x' || s[1] == 'X')) { base = 16; s += 2; }
        else if (*s == '0') { base = 8; s++; }
        else base = 10;
    } else if (base == 16 && *s == '0' && (s[1] == 'x' || s[1] == 'X')) {
        s += 2;
    }

    long val = 0;
    while (*s) {
        int d;
        if (*s >= '0' && *s <= '9')      d = *s - '0';
        else if (*s >= 'a' && *s <= 'z') d = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z') d = *s - 'A' + 10;
        else break;
        if (d >= base) break;
        val = val * base + d;
        s++;
    }
    if (end) *end = (char *)s;
    return neg ? -val : val;
}

int  abs(int n)   { return n < 0 ? -n : n; }
long labs(long n) { return n < 0 ? -n : n; }

/* ── Character classification ───────────────────────────────────────────── */

int isdigit(int c) { return c >= '0' && c <= '9'; }
int isalpha(int c) { return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'); }
int isalnum(int c) { return isalpha(c) || isdigit(c); }
int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\r' || c == '\f' || c == '\v'; }
int isupper(int c) { return c >= 'A' && c <= 'Z'; }
int islower(int c) { return c >= 'a' && c <= 'z'; }
int isprint(int c) { return c >= 0x20 && c < 0x7f; }
int toupper(int c) { return islower(c) ? c - 32 : c; }
int tolower(int c) { return isupper(c) ? c + 32 : c; }

/* ── vsnprintf ──────────────────────────────────────────────────────────── */
/* Core formatter — all other printf variants delegate here. */

static void _emit(char **buf, size_t *rem, char c) {
    if (*rem > 1) { **buf = c; (*buf)++; (*rem)--; }
}

static void _emit_str(char **buf, size_t *rem, const char *s,
                       int width, int left, int zero) {
    int len = 0;
    const char *p = s;
    while (*p++) len++;

    int pad = (width > len) ? width - len : 0;
    char pad_c = (zero && !left) ? '0' : ' ';

    if (!left) while (pad-- > 0) _emit(buf, rem, pad_c);
    while (*s) _emit(buf, rem, *s++);
    if (left) while (pad-- > 0) _emit(buf, rem, ' ');
}

int vsnprintf(char *buf, size_t n, const char *fmt, va_list ap) {
    char  *out  = buf;
    size_t rem  = n;

    while (*fmt) {
        if (*fmt != '%') { _emit(&out, &rem, *fmt++); continue; }
        fmt++;  /* skip '%' */

        /* flags */
        int left = 0, zero = 0;
        while (*fmt == '-' || *fmt == '0') {
            if (*fmt == '-') left = 1;
            if (*fmt == '0') zero = 1;
            fmt++;
        }

        /* width */
        int width = 0;
        while (*fmt >= '0' && *fmt <= '9') width = width * 10 + (*fmt++ - '0');

        /* precision (%.3d, %.2f, etc.) — for integers: min digits */
        int prec = -1;
        if (*fmt == '.') {
            fmt++;
            prec = 0;
            if (*fmt == '*') {
                prec = va_arg(ap, int);
                fmt++;
            } else {
                while (*fmt >= '0' && *fmt <= '9')
                    prec = prec * 10 + (*fmt++ - '0');
            }
            if (prec < 0) prec = 0;
            /* precision implies zero-pad for integers */
            zero = 1;
            if (prec > width) width = prec;
        }

        /* length modifier */
        int is_long = 0;
        if (*fmt == 'l') { is_long = 1; fmt++; }
        if (*fmt == 'l') { fmt++; } /* ll — treat same as l for now */

        char tmp[32];
        int  neg;
        long lval;
        unsigned long uval;

        switch (*fmt++) {
        case 'c':
            tmp[0] = (char)va_arg(ap, int);
            tmp[1] = '\0';
            _emit_str(&out, &rem, tmp, width, left, 0);
            break;

        case 's': {
            const char *s = va_arg(ap, const char *);
            int len, pad;
            if (!s) s = "(null)";
            len = 0;
            while (s[len] && (prec < 0 || len < prec)) len++;
            pad = (width > len) ? width - len : 0;
            if (!left) while (pad-- > 0) _emit(&out, &rem, ' ');
            {
                int i;
                for (i = 0; i < len; i++) _emit(&out, &rem, s[i]);
            }
            if (left) while (pad-- > 0) _emit(&out, &rem, ' ');
            break;
        }

        case 'd': case 'i':
            lval = is_long ? va_arg(ap, long) : (long)va_arg(ap, int);
            neg  = (lval < 0);
            uval = (unsigned long)(neg ? -lval : lval);
            {
                char *p = tmp + 31; *p = '\0';
                do { *--p = '0' + (int)(uval % 10); uval /= 10; } while (uval);
                /* pad digits to precision before optional sign */
                if (prec > 0) {
                    int digs = (int)((tmp + 31) - p);
                    while (digs < prec) { *--p = '0'; digs++; }
                    /* width already includes pad; avoid double zero-pad */
                    zero = 0;
                    if (width < digs + neg) width = digs + neg;
                }
                if (neg) *--p = '-';
                _emit_str(&out, &rem, p, width, left, zero);
            }
            break;

        case 'u':
            uval = is_long ? va_arg(ap, unsigned long) : (unsigned long)va_arg(ap, unsigned int);
            { char *p = tmp + 31; *p = '\0';
              do { *--p = '0' + (int)(uval % 10); uval /= 10; } while (uval);
              if (prec > 0) {
                  int digs = (int)((tmp + 31) - p);
                  while (digs < prec) { *--p = '0'; digs++; }
                  zero = 0;
                  if (width < digs) width = digs;
              }
              _emit_str(&out, &rem, p, width, left, zero); }
            break;

        case 'x': case 'X': {
            int upper = (fmt[-1] == 'X');
            uval = is_long ? va_arg(ap, unsigned long) : (unsigned long)va_arg(ap, unsigned int);
            char *p = tmp + 31; *p = '\0';
            do {
                int d = (int)(uval & 0xf);
                *--p = d < 10 ? '0' + d : (upper ? 'A' : 'a') + d - 10;
                uval >>= 4;
            } while (uval);
            if (prec > 0) {
                int digs = (int)((tmp + 31) - p);
                while (digs < prec) { *--p = '0'; digs++; }
                zero = 0;
                if (width < digs) width = digs;
            }
            _emit_str(&out, &rem, p, width, left, zero);
            break;
        }

        case 'p': {
            uval = (unsigned long)va_arg(ap, void *);
            char *p = tmp + 31; *p = '\0';
            do {
                int d = (int)(uval & 0xf);
                *--p = d < 10 ? '0' + d : 'a' + d - 10;
                uval >>= 4;
            } while (uval);
            *--p = 'x'; *--p = '0';
            _emit_str(&out, &rem, p, width, left, zero);
            break;
        }

        case '%':
            _emit(&out, &rem, '%');
            break;

        default:
            _emit(&out, &rem, '?');
            break;
        }
    }

    if (rem > 0) *out = '\0';
    return (int)(out - buf);
}

/* ── Other printf variants ──────────────────────────────────────────────── */

int vsprintf(char *buf, const char *fmt, va_list ap) {
    return vsnprintf(buf, (size_t)-1, fmt, ap);
}

int snprintf(char *buf, size_t n, const char *fmt, ...) {
    va_list ap; va_start(ap, fmt);
    int r = vsnprintf(buf, n, fmt, ap);
    va_end(ap);
    return r;
}

int sprintf(char *buf, const char *fmt, ...) {
    va_list ap; va_start(ap, fmt);
    int r = vsprintf(buf, fmt, ap);
    va_end(ap);
    return r;
}

int vprintf(const char *fmt, va_list ap) {
    char buf[512];
    int r = vsnprintf(buf, sizeof(buf), fmt, ap);
    uart_puts(buf);
    return r;
}

int printf(const char *fmt, ...) {
    va_list ap; va_start(ap, fmt);
    int r = vprintf(fmt, ap);
    va_end(ap);
    return r;
}

int puts(const char *s) {
    uart_puts((char *)s);
    uart_putc('\n');
    return 0;
}

int putchar(int c) {
    uart_putc((char)c);
    return c;
}

/* ── FILE I/O — backed by the Mana Minix filesystem ────────────────────────
 *
 * Doom calls fopen("doom1.wad", "rb"), then fread()s the entire thing.
 * We route those calls to the Minix FS. No buffering. No seeking
 * optimisation. No mercy. It works, and that's enough.
 *
 * stdin/stdout/stderr are special-cased (fd 0/1/2) and route to UART.
 * Everything else is a real file on the Minix FS.
 * ────────────────────────────────────────────────────────────────────────── */

#include "filesystem.h"
#include "commands.h"    /* namei() */

/* Pre-allocated pool of FILE handles. Doom opens at most a handful of files
 * simultaneously. 16 slots is generous. Dynamic allocation would be cleaner
 * but this avoids a malloc dependency in the allocator bootstrap path. */
#define MAX_OPEN_FILES 16

static FILE _file_pool[MAX_OPEN_FILES];
static int  _file_pool_used[MAX_OPEN_FILES];

/* The three standard streams. They don't touch the filesystem. */
static FILE _stderr_inst = { .fd = 2 };
static FILE _stdout_inst = { .fd = 1 };
static FILE _stdin_inst  = { .fd = 0 };
FILE *stderr = &_stderr_inst;
FILE *stdout = &_stdout_inst;
FILE *stdin  = &_stdin_inst;

static FILE *_alloc_file(void) {
    for (int i = 0; i < MAX_OPEN_FILES; i++) {
        if (!_file_pool_used[i]) {
            _file_pool_used[i] = 1;
            memset(&_file_pool[i], 0, sizeof(FILE));
            _file_pool[i].fd = -1;
            return &_file_pool[i];
        }
    }
    return NULL;   /* too many open files — Doom shouldn't hit this */
}

static void _free_file(FILE *f) {
    for (int i = 0; i < MAX_OPEN_FILES; i++) {
        if (&_file_pool[i] == f) {
            _file_pool_used[i] = 0;
            return;
        }
    }
}

/* fopen — look up by name in the current directory, return a FILE handle.
 * Mode "rb" / "r" → read-only. Mode "wb" / "w" → write.
 * Mode "r+b" → read-write (we treat this the same as "rb" for now). */
FILE *fopen(const char *path, const char *mode) {
    /* stdin/stdout/stderr by name — unlikely but let's be safe */
    if (strcmp(path, "/dev/stdin")  == 0 || strcmp(path, "stdin")  == 0) return stdin;
    if (strcmp(path, "/dev/stdout") == 0 || strcmp(path, "stdout") == 0) return stdout;
    if (strcmp(path, "/dev/stderr") == 0 || strcmp(path, "stderr") == 0) return stderr;

    /* Strip leading "./" that Doom sometimes prepends */
    if (path[0] == '.' && path[1] == '/') path += 2;

    uint16_t inum = namei(path);
    if (inum == 0) return NULL;   /* file not found */

    FILE *f = _alloc_file();
    if (!f) return NULL;

    struct inode ip;
    read_inode(inum, &ip);

    f->inum     = inum;
    f->size     = ip.i_size;
    f->pos      = 0;
    f->eof      = 0;
    f->error    = 0;
    f->writable = (mode[0] == 'w');
    f->fd       = -1;

    return f;
}

int fclose(FILE *f) {
    if (!f || f == stdin || f == stdout || f == stderr) return 0;
    _free_file(f);
    return 0;
}

/* fread — read count*size bytes from the file at the current cursor.
 * Returns the number of *elements* (not bytes) successfully read.
 * Doom counts on this being exact for WAD header reads. */
size_t fread(void *buf, size_t elem_size, size_t count, FILE *f) {
    if (!f || f->eof || f->error) return 0;

    /* stdin reads from UART */
    if (f->fd == 0) {
        char *p = (char *)buf;
        for (size_t i = 0; i < elem_size * count; i++) {
            *p++ = uart_getchar();
        }
        return count;
    }

    uint8_t  *dst       = (uint8_t *)buf;
    size_t    total     = elem_size * count;
    size_t    remaining = (f->size > f->pos) ? (f->size - f->pos) : 0;
    if (total > remaining) total = remaining;
    size_t    to_read   = total;

    struct inode ip;
    read_inode(f->inum, &ip);

    while (to_read > 0) {
        uint32_t blk_idx = f->pos / BLOCK_SIZE;
        uint32_t blk_off = f->pos % BLOCK_SIZE;
        uint32_t chunk   = BLOCK_SIZE - blk_off;
        if (chunk > to_read) chunk = (uint32_t)to_read;

        uint16_t blkno = bmap(&ip, blk_idx, 0);
        if (blkno == 0) { f->error = 1; break; }

        uint8_t blk_buf[BLOCK_SIZE];
        blk_read(blkno, blk_buf);
        memcpy(dst, blk_buf + blk_off, chunk);

        dst     += chunk;
        f->pos  += chunk;
        to_read -= chunk;
    }

    if (f->pos >= f->size) f->eof = 1;
    return (elem_size > 0) ? (total - to_read) / elem_size : 0;
}

/* fwrite — write to a file. Used by Doom for save games.
 * Currently we only support writing to stdout/stderr (UART). */
size_t fwrite(const void *buf, size_t elem_size, size_t count, FILE *f) {
    if (!f) return 0;

    /* stdout and stderr go to UART */
    if (f->fd == 1 || f->fd == 2) {
        const char *p = (const char *)buf;
        for (size_t i = 0; i < elem_size * count; i++) uart_putc(*p++);
        return count;
    }

    /* TODO: implement write-back to Minix FS for save games */
    (void)buf;
    return 0;
}

/* fseek — reposition the cursor.
 * SEEK_SET: absolute. SEEK_CUR: relative. SEEK_END: from end.
 * Doom uses all three. */
int fseek(FILE *f, long offset, int whence) {
    if (!f || f->fd >= 0) return -1;

    long new_pos;
    switch (whence) {
    case SEEK_SET: new_pos = offset;                    break;
    case SEEK_CUR: new_pos = (long)f->pos + offset;    break;
    case SEEK_END: new_pos = (long)f->size + offset;   break;
    default: return -1;
    }

    if (new_pos < 0) return -1;
    f->pos = (uint32_t)new_pos;
    f->eof = (f->pos >= f->size);
    return 0;
}

long ftell(FILE *f) {
    if (!f || f->fd >= 0) return -1;
    return (long)f->pos;
}

int feof(FILE *f)   { return (!f || f->eof)   ? 1 : 0; }
int ferror(FILE *f) { return (!f || f->error) ? 1 : 0; }

void rewind(FILE *f) {
    if (f && f->fd < 0) { f->pos = 0; f->eof = 0; f->error = 0; }
}

int fgetc(FILE *f) {
    unsigned char c;
    if (fread(&c, 1, 1, f) != 1) return EOF;
    return (int)c;
}

char *fgets(char *buf, int n, FILE *f) {
    if (!buf || n <= 0) return NULL;
    int i = 0;
    while (i < n - 1) {
        int c = fgetc(f);
        if (c == EOF) { if (i == 0) return NULL; break; }
        buf[i++] = (char)c;
        if (c == '\n') break;
    }
    buf[i] = '\0';
    return buf;
}

int fputs(const char *s, FILE *f) {
    if (!f || !s) return EOF;
    if (f->fd == 1 || f->fd == 2) { uart_puts((char *)s); return 0; }
    return fwrite(s, 1, strlen(s), f) > 0 ? 0 : EOF;
}

int vfprintf(FILE *f, const char *fmt, va_list ap) {
    char buf[512];
    int r = vsnprintf(buf, sizeof(buf), fmt, ap);
    fputs(buf, f);
    return r;
}

int fprintf(FILE *f, const char *fmt, ...) {
    va_list ap; va_start(ap, fmt);
    int r = vfprintf(f, fmt, ap);
    va_end(ap);
    return r;
}

/* ── System ─────────────────────────────────────────────────────────────── */

void exit(int status) {
    (void)status;
    uart_puts("\n[Mana] exit() called — system halted.\n");
    while (1) asm volatile("wfi");
}

void abort(void) {
    uart_puts("\n[Mana] abort() — system halted.\n");
    while (1) asm volatile("wfi");
}

char *getenv(const char *name) {
    if (!name)
        return NULL;
    /* Doom wants HOME for default.cfg path; give it the FS root. */
    if (name[0] == 'H' && name[1] == 'O' && name[2] == 'M' &&
        name[3] == 'E' && name[4] == '\0')
        return "/";
    return NULL;
}

/* ── Math (polynomial approximations — no libm needed) ─────────────────── */

float fabsf(float x) { return x < 0.0f ? -x : x; }
double fabs(double x) { return x < 0.0 ? -x : x; }

float sqrtf(float x) {
    if (x <= 0.0f) return 0.0f;
    /* Newton-Raphson — 4 iterations, accurate to float precision */
    float r = x * 0.5f;
    float y = x;
    long  i = *(long *)&y;
    i = 0x5f3759df - (i >> 1);
    y = *(float *)&i;
    y = y * (1.5f - (r * y * y));
    y = y * (1.5f - (r * y * y));
    y = y * (1.5f - (r * y * y));
    y = y * (1.5f - (r * y * y));
    return x * y;
}

double sqrt(double x) { return (double)sqrtf((float)x); }

float floorf(float x) { return (float)(int)x - (((float)(int)x > x) ? 1.0f : 0.0f); }
double floor(double x) { return (double)floorf((float)x); }

float ceilf(float x) { return (float)(int)x + (((float)(int)x < x) ? 1.0f : 0.0f); }
double ceil(double x) { return (double)ceilf((float)x); }

/* sin/cos via Bhaskara I approximation — error < 0.2% over [0, π] */
static float _sinf_core(float x) {
    /* reduce to [0, π] */
    const float pi  = 3.14159265358979f;
    const float pi2 = 6.28318530717959f;
    while (x < 0.0f)  x += pi2;
    while (x > pi2)   x -= pi2;
    int neg = 0;
    if (x > pi) { x -= pi; neg = 1; }
    float s = (16.0f * x * (pi - x)) / (5.0f * pi * pi - 4.0f * x * (pi - x));
    return neg ? -s : s;
}

float sinf(float x) { return _sinf_core(x); }
double sin(double x) { return (double)sinf((float)x); }

float cosf(float x) {
    const float pi_2 = 1.57079632679490f;
    return _sinf_core(x + pi_2);
}
double cos(double x) { return (double)cosf((float)x); }

float tanf(float x) {
    float s = sinf(x), c = cosf(x);
    return (c != 0.0f) ? s / c : 1e30f;
}

float atan2f(float y, float x) {
    const float pi = 3.14159265358979f;
    if (x == 0.0f) return (y > 0.0f) ? pi / 2.0f : -pi / 2.0f;
    float r = y / x;
    float a = r / (1.0f + 0.28f * r * r);   /* Euler approximation */
    if (x < 0.0f) a += (y >= 0.0f) ? pi : -pi;
    return a;
}
double atan2(double y, double x) { return (double)atan2f((float)y, (float)x); }

float powf(float b, float e) {
    /* integer exponent fast path */
    if (e == 0.0f) return 1.0f;
    if (e == 1.0f) return b;
    if (e == 2.0f) return b * b;
    /* general: e^(ln b * e) via exp/log approximation — good enough for Doom */
    /* For now fall back to repeated multiply for small integer exponents */
    int n = (int)e;
    float r = 1.0f;
    for (int i = 0; i < n; i++) r *= b;
    return r;
}
double pow(double b, double e) { return (double)powf((float)b, (float)e); }
