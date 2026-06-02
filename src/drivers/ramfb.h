#pragma once
#include <stdint.h>

typedef struct {
  uint64_t address;
  uint32_t fourcc; // 0x34325258 = 'XR24'
  uint32_t flags;
  uint32_t width;
  uint32_t height;
  uint32_t stride;
} ramfb_config_t;

void ramfb_init(void);
void ramfb_clear(uint32_t color);
void ramfb_test_pattern(void);
void ramfb_draw_pixel(uint32_t x, uint32_t y, uint32_t color);
uint32_t *ramfb_get_buffer(void);
