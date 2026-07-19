#ifndef KMALLOC_H
#define KMALLOC_H
#include <stddef.h>
#include <stdint.h>

extern char _heap_max;
extern char _heap_start;

/* Heap allocator */
void *kmalloc(size_t size);
void  kfree(void *ptr);
void *krealloc(void *ptr, size_t new_size);
void *kcalloc(size_t nmemb, size_t size);

/* Page allocator (MMU use only) */
void *allocate_page(uint64_t *bitmap, size_t total_words);
void  free_bit(uint8_t *bitmap, uintptr_t addr);
void  flip_bit(uint8_t *bitmap, uintptr_t free_start, uintptr_t free_end);

/* Utility */
void *memset(void *s, int c, size_t n);
void  clean_cache_provider(void *address, size_t size);

#endif /* KMALLOC_H */
