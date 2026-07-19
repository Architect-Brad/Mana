/* ─────────────────────────────────────────────────────────────────────────
 * kmalloc.c — Free-list heap + page bitmap for MMU tables
 * ───────────────────────────────────────────────────────────────────────── */
#include "kmalloc.h"
#include <stdint.h>

#define ALIGN8(n)   (((n) + 7UL) & ~7UL)
#define HDR_SIZE    ALIGN8(sizeof(struct block_header))
#define MIN_PAYLOAD 16
#define PAGE_SIZE   4096UL

struct block_header {
    uint64_t             size;
    uint64_t             free;
    struct block_header *next;
};

static struct block_header *heap_head = NULL;

static void init_heap(void) {
    uintptr_t start = ALIGN8((uintptr_t)&_heap_start);
    uintptr_t end   = (uintptr_t)&_heap_max;

    if (start + HDR_SIZE >= end)
        return;

    heap_head        = (struct block_header *)start;
    heap_head->size  = end - start - HDR_SIZE;
    heap_head->free  = 1;
    heap_head->next  = NULL;
}

void *kmalloc(size_t size) {
    if (size == 0)
        return NULL;
    if (!heap_head)
        init_heap();
    if (!heap_head)
        return NULL;

    size_t need = ALIGN8(size);
    struct block_header *blk = heap_head;

    while (blk) {
        if (blk->free && blk->size >= need) {
            if (blk->size >= need + HDR_SIZE + MIN_PAYLOAD) {
                struct block_header *split =
                    (struct block_header *)((uint8_t *)blk + HDR_SIZE + need);
                split->size = blk->size - need - HDR_SIZE;
                split->free = 1;
                split->next = blk->next;
                blk->size   = need;
                blk->next   = split;
            }
            blk->free = 0;
            return (uint8_t *)blk + HDR_SIZE;
        }
        blk = blk->next;
    }
    return NULL;
}

void kfree(void *ptr) {
    if (!ptr)
        return;

    struct block_header *blk =
        (struct block_header *)((uint8_t *)ptr - HDR_SIZE);
    blk->free = 1;

    int merged = 1;
    while (merged) {
        merged = 0;
        struct block_header *b = heap_head;
        while (b && b->next) {
            if (b->free && b->next->free) {
                uint8_t *end = (uint8_t *)b + HDR_SIZE + b->size;
                if (end == (uint8_t *)b->next) {
                    b->size += HDR_SIZE + b->next->size;
                    b->next  = b->next->next;
                    merged   = 1;
                    continue;
                }
            }
            b = b->next;
        }
    }
}

void *krealloc(void *ptr, size_t new_size) {
    if (!ptr)
        return kmalloc(new_size);
    if (new_size == 0) {
        kfree(ptr);
        return NULL;
    }

    struct block_header *blk =
        (struct block_header *)((uint8_t *)ptr - HDR_SIZE);
    if (blk->size >= new_size)
        return ptr;

    void *n = kmalloc(new_size);
    if (!n)
        return NULL;
    uint8_t *d = n;
    uint8_t *s = ptr;
    size_t i;
    for (i = 0; i < blk->size && i < new_size; i++)
        d[i] = s[i];
    kfree(ptr);
    return n;
}

void *kcalloc(size_t nmemb, size_t size) {
    size_t total = nmemb * size;
    void *p = kmalloc(total);
    if (p)
        memset(p, 0, total);
    return p;
}

/*
 * Early page allocator for MMU tables.
 * Use .data (not .bss) so the tables sit BEFORE the 48MB disk image in the
 * ELF and are covered by the loaded FileSiz region — safer on large images.
 */
static uint8_t mm_pages[4][PAGE_SIZE]
    __attribute__((aligned(PAGE_SIZE), section(".data.mmpages")));
static int mm_page_n;

void *allocate_page(uint64_t *bitmap, size_t total_words) {
    (void)bitmap;
    (void)total_words;
    uint8_t *p;
    size_t n;
    if (mm_page_n >= 4)
        return NULL;
    p = mm_pages[mm_page_n++];
    for (n = 0; n < PAGE_SIZE; n++)
        p[n] = 0;
    return p;
}

void free_bit(uint8_t *bitmap, uintptr_t addr) {
    (void)bitmap;
    (void)addr;
}

void flip_bit(uint8_t *bitmap, uintptr_t free_start, uintptr_t free_end) {
    (void)bitmap;
    (void)free_start;
    (void)free_end;
}

void *memset(void *s, int c, size_t n) {
    uint8_t *p = s;
    while (n--)
        *p++ = (uint8_t)c;
    return s;
}

void clean_cache_provider(void *address, size_t size) {
    (void)address;
    (void)size;
    asm volatile("dsb sy" ::: "memory");
}
