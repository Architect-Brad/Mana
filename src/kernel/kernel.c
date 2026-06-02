#include "aarch64.h"
#include "commands.h"
#include "exception.h"
#include "filesystem.h"
#include "gic.h"
#include "kmalloc.h"
#include "minix.h"
#include "mmu.h"
#include "ramfb.h"
#include "timer.h"
#include "uart.h"
#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>
#define BITMAP_WORDS 1024
uint64_t pmm_bitmap[BITMAP_WORDS] = {0};
struct inode root;
extern void start_raytracer(void);

void cmd_mkfs() {

  mkfs();
  uint8_t block[BLOCK_SIZE] = {0};
  blk_read(1, block);
  struct super_block *sb = (struct super_block *)block;
  if (sb->s_magic == 0x137f) {
    uart_printf("HAHA i have created a shitty filesystem from the 1980's");
  }
}

void test_inode() {
  read_inode(1, &root);
  uart_printf("Root mode: 0x%d (expected 0x41ED) \n", root.i_mode);
  uart_printf("Root size: %d (expected 0) \n", root.i_size);

  root.i_size = 128;
  write_inode(1, &root);

  struct inode check;
  read_inode(1, &check);
  if (check.i_size == 128) {
    uart_puts("THE INODE TEST PASSED I HAVE SUCCESFULLY MANAGED TO MANIPULATE "
              "A INODE \n");

  } else {
    uart_puts(
        "FAILED I HAVE SUCCESFULLY MANAGED TO WASTE MY LAST 10 BRAIN CELLS");
  }
}

void cmd_echo(char *cmd) {
  char *p = cmd + 4; // skip "echo"
  while (*p == ' ')
    p++; // skip spaces
  uart_puts(p);
  uart_putc('\n');
}

void cmd_alloc_inode() {
  uint16_t re = alloc_inode();
  if (re == 2) {
    uart_puts("IT works we allocated a inode");
  }
}
void exception_svc(void) { asm("svc #0xdead"); }

void exception_svc_test(void) {
  uart_puts("exception_svc_test... start\n");
  /* SVC instruction causes a Supervisor Call exception. */
  /* vector_table:_curr_el_spx_sync should be called */
  exception_svc();

  uart_puts("exception_svc_test... done\n");
}

void kmain(void) {
  uart_puts("--- MANA OS ---\n");

  // Add this:
  extern void vectors(void);
  raw_write_vbar_el1((uint64_t)vectors);
  uart_puts("Vector table loaded into VBAR_EL1.\n");
  // exception_svc_test();
  // timer_test();

  // After MMU and UART init:
  init_mmu(pmm_bitmap);
  ramfb_init();
  // ramfb_test_pattern();
  char cmd[256];
  while (1) {
    uart_puts("> ");
    read_line(cmd, sizeof(cmd));

    if (strncmp(cmd, "echo ", 5) == 0) {
      char *gt = strchr(cmd, '>');
      if (gt) {
        *gt = '\0';
        char *text = cmd + 5;
        while (*text == ' ')
          text++;
        char *name = gt + 1;
        while (*name == ' ')
          name++;
        cmd_echo_to_file(text, name);
      } else {
        cmd_echo(cmd);
      }
    } else if (strcmp(cmd, "ls") == 0) {
      cmd_ls();
    } else if (strncmp(cmd, "create -f ", 10) == 0) {
      cmd_create_f(cmd + 10);
    } else if (strncmp(cmd, "create -d ", 10) == 0) {
      cmd_create_d(cmd + 10);
    } else if (strncmp(cmd, "show ", 5) == 0) {
      cmd_show(cmd + 5);
    } else if (strncmp(cmd, "cd ", 3) == 0) {
      char *dir = cmd + 3;
      while (*dir == ' ')
        dir++;
      cmd_cd(dir);
    } else if (strncmp(cmd, "rm ", 3) == 0) {
      char *name = cmd + 3;
      while (*name == ' ')
        name++;
      cmd_rm(name);
    } else if (strncmp(cmd, "mv ", 3) == 0) {
      char *src, *dst;
      if (parse_two_args(cmd + 3, &src, &dst))
        cmd_mv(src, dst);
      else
        uart_puts("Usage: mv <src> <dst>\n");
    }

    else if (strcmp(cmd, "mkfs") == 0) {
      cmd_mkfs();
    } else if (strcmp(cmd, "hello") == 0) {
      uart_puts("Hello, OS!\n");
    } else if (strcmp(cmd, "render") == 0) {
      start_raytracer();
    } else if (strcmp(cmd, "alloc_inode") == 0) {
      cmd_alloc_inode();
    } else if (strcmp(cmd, "test_inode") == 0) {
      test_inode();
    }

    else if (cmd[0] != '\0') {
      uart_puts("Unknown command.\n");
    }
  }
}
