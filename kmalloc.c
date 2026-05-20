#include "kmalloc.h"

void* heap = (void*)&_heap_start;
 
void* kmalloc(size_t size)
{
  void* ptr = heap;
  heap += size;
  return ptr;
}
