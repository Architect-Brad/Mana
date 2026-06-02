#include <stddef.h>
#include <stdint.h>

extern "C" {
void *kmalloc(size_t size);

float tanf(float x) {
  float x2 = x * x;
  return x * (1.0f +
              x2 * (1.0f / 3.0f + x2 * (2.0f / 15.0f + x2 * (17.0f / 315.0f) +
                                        x2 * (62.0f / 2835.0f))));
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
void operator delete(void *) noexcept {}
void operator delete[](void *) noexcept {}
void operator delete(void *, size_t) noexcept {}
