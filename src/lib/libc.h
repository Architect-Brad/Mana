/* ─────────────────────────────────────────────────────────────────────────
 * libc.h — Mana freestanding libc shim
 *
 * Provides the subset of the C standard library that Doom (and other
 * hosted programs) expect, implemented on top of the Mana kernel
 * primitives (uart, kmalloc, filesystem).
 *
 * Include this instead of <string.h>, <stdlib.h>, <stdio.h>, <ctype.h>
 * when building user-space code for Mana.
 * ───────────────────────────────────────────────────────────────────────── */

#ifndef MANA_LIBC_H
#define MANA_LIBC_H

#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* ── Memory ─────────────────────────────────────────────────────────────── */
void  *malloc(size_t size);
void   free(void *ptr);
void  *realloc(void *ptr, size_t size);
void  *calloc(size_t nmemb, size_t size);

/* memset is declared in kmalloc.h; redeclare compatible here */
void  *memcpy(void *dst, const void *src, size_t n);
void  *memmove(void *dst, const void *src, size_t n);
int    memcmp(const void *a, const void *b, size_t n);

/* ── Strings ────────────────────────────────────────────────────────────── */
size_t strlen(const char *s);
char  *strcpy(char *dst, const char *src);
char  *strncpy(char *dst, const char *src, size_t n);
char  *strcat(char *dst, const char *src);
char  *strncat(char *dst, const char *src, size_t n);
int    strcmp(const char *a, const char *b);
int    strncmp(const char *a, const char *b, size_t n);
char  *strchr(const char *s, int c);
char  *strrchr(const char *s, int c);
char  *strstr(const char *haystack, const char *needle);
char  *strdup(const char *s);

/* ── Conversion ─────────────────────────────────────────────────────────── */
int    atoi(const char *s);
long   atol(const char *s);
long   strtol(const char *s, char **end, int base);
int    abs(int n);
long   labs(long n);

/* ── Character classification ───────────────────────────────────────────── */
int    isdigit(int c);
int    isalpha(int c);
int    isalnum(int c);
int    isspace(int c);
int    isupper(int c);
int    islower(int c);
int    isprint(int c);
int    toupper(int c);
int    tolower(int c);

/* ── I/O (backed by UART) ───────────────────────────────────────────────── */
int    printf(const char *fmt, ...);
int    sprintf(char *buf, const char *fmt, ...);
int    snprintf(char *buf, size_t n, const char *fmt, ...);
int    vprintf(const char *fmt, va_list ap);
int    vsprintf(char *buf, const char *fmt, va_list ap);
int    vsnprintf(char *buf, size_t n, const char *fmt, va_list ap);
int    puts(const char *s);
int    putchar(int c);

/* ── FILE I/O (backed by Minix FS) ─────────────────────────────────────── */
/* Doom opens its WAD with fopen(), reads with fread(), seeks with fseek().
 * All of these route to the Mana Minix filesystem. No buffering — every
 * read goes straight to blk_read(). Simple and honest. */

typedef struct _mana_file {
    uint16_t     inum;       /* inode number on the Minix FS               */
    uint32_t     size;       /* file size in bytes                         */
    uint32_t     pos;        /* current read/write cursor                  */
    int          eof;        /* 1 once we've hit the end                   */
    int          error;      /* non-zero if something went wrong           */
    int          writable;   /* 1 if opened for writing                    */
    int          fd;         /* 0/1/2 for stdin/stdout/stderr, -1 for real files */
} FILE;

extern FILE *stderr;
extern FILE *stdout;
extern FILE *stdin;

FILE  *fopen(const char *path, const char *mode);
int    fclose(FILE *f);
size_t fread(void *buf, size_t size, size_t count, FILE *f);
size_t fwrite(const void *buf, size_t size, size_t count, FILE *f);
int    fseek(FILE *f, long offset, int whence);
long   ftell(FILE *f);
int    feof(FILE *f);
int    ferror(FILE *f);
void   rewind(FILE *f);
int    fgetc(FILE *f);
char  *fgets(char *buf, int n, FILE *f);
int    fprintf(FILE *f, const char *fmt, ...);
int    vfprintf(FILE *f, const char *fmt, va_list ap);
int    fputs(const char *s, FILE *f);

#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

#define EOF (-1)

/* ── System ─────────────────────────────────────────────────────────────── */
void   exit(int status)  __attribute__((noreturn));
void   abort(void)       __attribute__((noreturn));
char  *getenv(const char *name);

/* ── Math (bare-metal, no libm) ─────────────────────────────────────────── */
float  fabsf(float x);
float  sqrtf(float x);
float  floorf(float x);
float  ceilf(float x);
float  sinf(float x);
float  cosf(float x);
float  tanf(float x);
float  atan2f(float y, float x);
float  powf(float base, float exp);
double fabs(double x);
double sqrt(double x);
double floor(double x);
double ceil(double x);
double sin(double x);
double cos(double x);
double atan2(double y, double x);
double pow(double base, double exp);

#ifdef __cplusplus
}
#endif

#endif /* MANA_LIBC_H */
