#include "kmalloc.h"
#include "uart.h"
#include <stdint.h>
#include <stddef.h>
#include <stdarg.h>

#define BITMAP_WORDS 1024


void kmain(void)
{
   uart_printf("--- MANA OS: PMM FINAL TEST ---\n");

    // 1. Setup the Bitmap
    uint8_t* bitmap = (uint8_t*)kmalloc(8192);
    for(int i = 0; i < 8192; i++) bitmap[i] = 0xFF; // Start with everything locked
    
    // 2. Free a 1MB Playground (256 pages) for testing
    uintptr_t playground_start = (uintptr_t)bitmap + 8192;
    uintptr_t playground_end   = playground_start + (1024 * 1024);
    
    flip_bit(bitmap, playground_start, playground_end);
    uart_printf("PMM: 1MB Playground freed at 0x%x\n", playground_start);

    // --- TEST PHASE ---

    // STEP 1: First allocation
    void* p1 = allocate_page((uint64_t*)bitmap, BITMAP_WORDS);
    uart_printf("TEST 1 (Alloc): Page 1 at %p\n", p1);

    // STEP 2: Second allocation (Check for overlap)
    void* p2 = allocate_page((uint64_t*)bitmap, BITMAP_WORDS);
    uart_printf("TEST 2 (Alloc): Page 2 at %p\n", p2);

    if ((uintptr_t)p2 == (uintptr_t)p1 + 4096) {
        uart_printf("SUCCESS: Pages are contiguous and aligned.\n");
    } else {
        uart_printf("FAILURE: Unexpected page spacing.\n");
    }

    // STEP 3: The Recycling Test
    uart_printf("TEST 3 (Recycle): Freeing Page 1...\n");
    free_bit(bitmap, (uintptr_t)p1);

    void* p3 = allocate_page((uint64_t*)bitmap, BITMAP_WORDS);
    uart_printf("TEST 3 (Recycle): Page 3 at %p\n", p3);

    if (p1 == p3) {
        uart_printf("SUCCESS: Memory successfully recycled!\n");
    } else {
        uart_printf("FAILURE: Recycling failed.\n");
    }

    uart_printf("--- ALL TESTS COMPLETE ---\n");
    while(1);
}
