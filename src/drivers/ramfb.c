/* ─────────────────────────────────────────────────────────────────────────
 * ramfb.c — QEMU RAMFB driver via fw_cfg DMA
 *
 * RAMFB is a QEMU paravirtual framebuffer. Instead of emulating a GPU
 * (which would require a PCI bus, a driver model, and our last shred of
 * sanity), QEMU lets you negotiate a display surface by writing a DMA
 * descriptor into its fw_cfg interface.
 *
 * The protocol:
 *   1. Tell QEMU: "here is a buffer in RAM, please show it on screen"
 *   2. Write pixels into that buffer
 *   3. QEMU renders them, no GPU required
 *
 * This driver handles step 1. The rest of the kernel handles step 2.
 * QEMU handles step 3 without complaining, which is more than we can
 * say for actual GPU drivers.
 *
 * Resolution: 1080×720, format: XRGB8888 (32bpp)
 * The X in XRGB means the alpha byte is ignored. QEMU doesn't do
 * transparency. Neither does this kernel.
 * ───────────────────────────────────────────────────────────────────────── */

#include <stdint.h>

extern void uart_puts(const char *s);
extern void uart_printf(const char *fmt, ...);

/* QEMU fw_cfg MMIO base — hardcoded for the AArch64 virt machine.
 * If you're running on real hardware, this address is wrong and
 * you have bigger problems than the framebuffer. */
#define FW_CFG_BASE 0x09020000
#define FW_CFG_REG_DATA (FW_CFG_BASE + 0) // 8-bit / string data access
#define FW_CFG_REG_SEL (FW_CFG_BASE + 8)  // 16-bit selector write
#define FW_CFG_REG_DMA (FW_CFG_BASE + 16) // 64-bit DMA address write

#define FW_CFG_FILE_DIR 0x0019

// --- fw_cfg DMA Control Flags ---
#define FW_CFG_DMA_CTL_ERROR 0x01
#define FW_CFG_DMA_CTL_READ 0x02
#define FW_CFG_DMA_CTL_SKIP 0x04
#define FW_CFG_DMA_CTL_SELECT 0x08
#define FW_CFG_DMA_CTL_WRITE 0x10

struct __attribute__((packed)) FWCfgFile {
  uint32_t size;
  uint16_t select;
  uint16_t reserved;
  char name[56];
};

struct __attribute__((packed)) FWCfgDmaAccess {
  uint32_t control;
  uint32_t length;
  uint64_t address;
};

typedef struct __attribute__((packed)) {
  uint64_t addr;
  uint32_t fourcc;
  uint32_t flags;
  uint32_t width;
  uint32_t height;
  uint32_t stride;
} ramfb_config_t;

#define FB_WIDTH 1080
#define FB_HEIGHT 720

static uint32_t fb_width = 0, fb_height = 0, fb_stride = 0;
static uint64_t fb_base = 0;

static uint32_t raw_framebuffer[FB_WIDTH * FB_HEIGHT]
    __attribute__((aligned(4096)));
static ramfb_config_t global_config;

static void fw_cfg_select(uint16_t key) {
  *(volatile uint16_t *)FW_CFG_REG_SEL = __builtin_bswap16(key);
}

static void fw_cfg_read_buf(void *buf, uint32_t len) {
  uint8_t *p = (uint8_t *)buf;
  for (uint32_t i = 0; i < len; i++) {
    p[i] = *(volatile uint8_t *)FW_CFG_REG_DATA;
  }
}

static int fw_cfg_dma_transfer(uint32_t control_flags, uint16_t select_key,
                               void *address, uint32_t length) {
  static volatile struct FWCfgDmaAccess dma_desc __attribute__((aligned(16)));

  uint32_t control = control_flags;
  if (control_flags & FW_CFG_DMA_CTL_SELECT) {
    control |= ((uint32_t)select_key << 16);
  }

  dma_desc.control = __builtin_bswap32(control);
  dma_desc.length = __builtin_bswap32(length);
  dma_desc.address = __builtin_bswap64((uint64_t)address);

  asm volatile("dsb sy");

  uint64_t desc_phys = (uint64_t)&dma_desc;
  uint32_t cmd_hi = (uint32_t)(desc_phys >> 32);
  uint32_t cmd_lo = (uint32_t)(desc_phys & 0xFFFFFFFF);

  *(volatile uint32_t *)(FW_CFG_REG_DMA) = __builtin_bswap32(cmd_hi);
  *(volatile uint32_t *)(FW_CFG_REG_DMA + 4) = __builtin_bswap32(cmd_lo);

  while (__builtin_bswap32(dma_desc.control) & ~FW_CFG_DMA_CTL_ERROR) {
    asm volatile("yield");
  }

  if (__builtin_bswap32(dma_desc.control) & FW_CFG_DMA_CTL_ERROR) {
    return 0;
  }
  return 1;
}

static int find_ramfb_selector(uint16_t *out_sel) {
  fw_cfg_select(FW_CFG_FILE_DIR);

  uint32_t count_be = 0;
  fw_cfg_read_buf(&count_be, 4);
  uint32_t count = __builtin_bswap32(count_be);

  struct FWCfgFile file;
  for (uint32_t i = 0; i < count; i++) {
    fw_cfg_read_buf(&file, sizeof(struct FWCfgFile));

    char *s1 = file.name;
    char *s2 = "etc/ramfb";
    while (*s1 && (*s1 == *s2)) {
      s1++;
      s2++;
    }
    if (*s1 == '\0' && *s2 == '\0') {
      *out_sel = __builtin_bswap16(file.select);
      return 1;
    }
  }
  return 0;
}

void ramfb_init(void) {
  uart_puts("ramfb: Initializing...\n");

  uint16_t ramfb_selector = 0;
  if (!find_ramfb_selector(&ramfb_selector)) {
    uart_puts("ramfb: Failed to locate etc/ramfb configuration inside QEMU "
              "fw_cfg!\n");
    return;
  }

  fb_width = FB_WIDTH;
  fb_height = FB_HEIGHT;
  fb_stride = FB_WIDTH * 4;
  fb_base = (uint64_t)raw_framebuffer;

  for (uint32_t i = 0; i < FB_WIDTH * FB_HEIGHT; i++) {
    raw_framebuffer[i] = 0;
  }

  global_config.addr = __builtin_bswap64(fb_base);
  global_config.fourcc =
      __builtin_bswap32(0x34325258); // DRM_FORMAT_XRGB8888 ("XR24")
  global_config.flags = 0;
  global_config.width = __builtin_bswap32(fb_width);
  global_config.height = __builtin_bswap32(fb_height);
  global_config.stride = __builtin_bswap32(fb_stride);

  if (!fw_cfg_dma_transfer(FW_CFG_DMA_CTL_SELECT | FW_CFG_DMA_CTL_WRITE,
                           ramfb_selector, &global_config,
                           sizeof(ramfb_config_t))) {
    uart_puts(
        "ramfb: DMA handshake transaction rejected by QEMU host device!\n");
    fb_base = 0;
    return;
  }

  uart_printf("ramfb: Success! Display configured at 0x%x (%dx%d)\n", fb_base,
              fb_width, fb_height);
}

void ramfb_clear(uint32_t color) {
  if (fb_base == 0)
    return;

  uint32_t *fb = (uint32_t *)fb_base;
  for (uint32_t i = 0; i < fb_width * fb_height; i++) {
    fb[i] = color;
  }
  asm volatile("dsb sy");
}

void ramfb_test_pattern(void) {
  if (fb_base == 0)
    return;

  uint32_t *fb = (uint32_t *)fb_base;
  uint32_t pitch = fb_stride / 4;

  for (uint32_t y = 0; y < fb_height; y++) {
    for (uint32_t x = 0; x < fb_width; x++) {
      uint32_t color = 0;

      if (y < fb_height / 3) {
        color = 0x00FF0000; // Red
      } else if (y < 2 * fb_height / 3) {
        color = 0x0000FF00; // Green
      } else {
        color = 0x000000FF; // Blue
      }

      fb[y * pitch + x] = color;
    }
  }

  asm volatile("dsb sy");
  uart_puts("ramfb: Test pattern drawn and synchronized!\n");
}

uint32_t *ramfb_get_buffer(void) { return raw_framebuffer; }
