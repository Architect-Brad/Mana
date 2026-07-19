#include <stddef.h>
#include <stdint.h>

extern "C" {
void *kmalloc(size_t size);
void  kfree(void *ptr);

/* tanf provided by libc.c */

void enable_fpu(void) {
  /* CPACR_EL1: enable FP/ASIMD at EL0/EL1 (bits 21:20 = 0b11) */
  uint64_t cpacr;
  __asm__ __volatile__("mrs %0, cpacr_el1" : "=r"(cpacr));
  cpacr |= (3ULL << 20);
  __asm__ __volatile__("msr cpacr_el1, %0; isb" ::"r"(cpacr) : "memory");
}

void *__dso_handle = nullptr;
int __cxa_atexit(void (*)(void *), void *, void *) { return 0; }
void __cxa_pure_virtual() {
  while (1)
    ;
}

void clean_cache_provider(void *address, uint32_t size);
}

void *operator new(size_t size) { return kmalloc(size); }
void *operator new[](size_t size) { return kmalloc(size); }
void operator delete(void *ptr) noexcept { kfree(ptr); }
void operator delete[](void *ptr) noexcept { kfree(ptr); }
void operator delete(void *ptr, size_t) noexcept { kfree(ptr); }
void operator delete[](void *ptr, size_t) noexcept { kfree(ptr); }
