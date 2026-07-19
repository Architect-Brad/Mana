/* ─────────────────────────────────────────────────────────────────────────
 * kernel.c — Mana kernel main + shell
 *
 * kmain() is the C entry point. Boot.S sets up the stack, zeroes BSS,
 * then jumps here. From this point on, we're responsible for everything.
 *
 * The shell is intentionally minimal. It's not bash. It's not meant to be.
 * It exists to let you poke the kernel and launch Doom.
 * ───────────────────────────────────────────────────────────────────────── */

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
#include "task.h"
#include "virtio_input.h"
#include "virtio_blk.h"
#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>

#define BITMAP_WORDS 1024
uint64_t pmm_bitmap[BITMAP_WORDS] = {0};

/* cwd inode is tracked globally so the shell and filesystem share it */
struct inode root;

extern void start_raytracer(void);

/* ── cmd_mkfs ────────────────────────────────────────────────────────────
 * Formats the in-memory disk as a fresh MINIX v1 filesystem.
 * Destructive. No "are you sure?" prompt. You typed it, you meant it. */
void cmd_mkfs(void) {
    mkfs();
    uint8_t block[BLOCK_SIZE] = {0};
    blk_read(1, block);
    struct super_block *sb = (struct super_block *)block;
    if (sb->s_magic == 0x137f) {
        uart_printf("Filesystem created (MINIX v1, magic 0x%x).\n", sb->s_magic);
    } else {
        uart_puts("mkfs: something went wrong. Magic not found.\n");
    }
}

/* ── cmd_echo ────────────────────────────────────────────────────────────
 * Prints text to UART. Supports redirection to file via '>'.
 * Yes, a kernel shell with echo redirection. We're not sorry. */
void cmd_echo(char *cmd) {
    char *p = cmd + 4;   /* skip "echo" */
    while (*p == ' ') p++;
    uart_puts(p);
    uart_putc('\n');
}

/* ── cmd_mkdir / cmd_touch ───────────────────────────────────────────────
 * Thin wrappers so the shell can use 'mkdir' and 'touch' instead of
 * the more cryptic 'create -d' / 'create -f'. */
void cmd_mkdir(char *name) { cmd_create_d(name); }
void cmd_touch(char *name) { cmd_create_f(name); }

/* ── cmd_doom ────────────────────────────────────────────────────────────
 * Launch Doom. This is why we're here.
 *
 * Requires doom1.wad to be present in the root directory of the filesystem.
 * Run 'mkfs' first if you haven't already, then load the WAD.
 * See doom/PORTING.md for the full setup instructions.
 *
 * The Doom engine never returns. Once you call D_DoomMain(), the kernel
 * shell is gone and Doom owns the machine. That's fine. That's the point. */
#ifdef MANA_DOOM_ENABLED
void cmd_doom(void) {
    extern void D_DoomMain(void);
    extern int  myargc;
    extern char **myargv;
    extern void enable_fpu(void);

    /* Doom / freestanding C may touch FP regs; untrap CPACR. */
    enable_fpu();

    /* Doom needs at least argv[0] = program name, then -iwad <path>.
     * Additional flags can be added here. -nomusic spares us the silence. */
    static char *doom_argv[] = {
        "doom",
        "-iwad", "doom1.wad",
        "-nomusic",
        "-nosound",
        NULL
    };
    myargc = 5;
    myargv = doom_argv;

    uart_puts("[Mana] Handing control to Doom. Goodbye, shell.\n");
    D_DoomMain();   /* does not return */
}
#else
void cmd_doom(void) {
    uart_puts("Doom is not linked into this build.\n");
    uart_puts("See doom/PORTING.md to complete the port.\n");
    uart_puts("Steps remaining: get vanilla Doom source, link, load doom1.wad.\n");
}
#endif

/* ── kmain ───────────────────────────────────────────────────────────────
 * Kernel entry point. Initialises hardware, then drops into the shell.
 * Order matters here — don't rearrange without understanding why. */
void kmain(void) {
    uart_puts("\n");
    uart_puts(" ███╗   ███╗ █████╗ ███╗   ██╗ █████╗ \n");
    uart_puts(" ████╗ ████║██╔══██╗████╗  ██║██╔══██╗\n");
    uart_puts(" ██╔████╔██║███████║██╔██╗ ██║███████║\n");
    uart_puts(" ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║\n");
    uart_puts(" ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║\n");
    uart_puts(" ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝\n");
    uart_puts("   AArch64 bare-metal kernel\n\n");

    /* Load the exception vector table into VBAR_EL1.
     * If this doesn't happen before anything that could fault, we're dead. */
    extern void vectors(void);
    raw_write_vbar_el1((uint64_t)vectors);

    /* MMU: identity-map the entire address space.
     * After this, virtual == physical, which is all we need for now. */
    init_mmu(pmm_bitmap);

    /* RAMFB: negotiate the display surface with QEMU via fw_cfg DMA.
     * After this, writes to the framebuffer appear on screen. */
    ramfb_init();

    gic_v3_initialize();
    uart_puts("[boot] GIC ready\n");

    /* Scheduler (task 0 = shell, task 1 = idle) */
    sched_init();

    /* Virtio: safe once MMIO is Device-mapped. Absent devices just log. */
    virtio_input_init();
    virtio_blk_init();

    uart_puts("Type 'help' for available commands.\n\n");

    /* ── Shell loop ────────────────────────────────────────────────────── */
    char cmd[256];
    while (1) {
        uart_puts("> ");
        read_line(cmd, sizeof(cmd));

        if (cmd[0] == '\0') {
            /* empty line — do nothing, don't print an error */
            continue;
        }

        /* ── File system commands ─────────────────────────────────────── */
        if (strcmp(cmd, "ls") == 0) {
            cmd_ls();

        } else if (strncmp(cmd, "cd ", 3) == 0) {
            char *dir = cmd + 3;
            while (*dir == ' ') dir++;
            cmd_cd(dir);

        } else if (strncmp(cmd, "mkdir ", 6) == 0) {
            cmd_mkdir(cmd + 6);

        } else if (strncmp(cmd, "touch ", 6) == 0) {
            cmd_touch(cmd + 6);

        } else if (strncmp(cmd, "rm ", 3) == 0) {
            char *name = cmd + 3;
            while (*name == ' ') name++;
            cmd_rm(name);

        } else if (strncmp(cmd, "mv ", 3) == 0) {
            char *src, *dst;
            if (parse_two_args(cmd + 3, &src, &dst))
                cmd_mv(src, dst);
            else
                uart_puts("Usage: mv <src> <dst>\n");

        } else if (strncmp(cmd, "show ", 5) == 0) {
            cmd_show(cmd + 5);

        } else if (strcmp(cmd, "mkfs") == 0) {
            cmd_mkfs();

        /* ── Echo (with optional file redirect) ───────────────────────── */
        } else if (strncmp(cmd, "echo ", 5) == 0) {
            char *gt = strchr(cmd, '>');
            if (gt) {
                *gt = '\0';
                char *text = cmd + 5;
                while (*text == ' ') text++;
                /* trim trailing space before the '>' */
                char *end = gt - 1;
                while (end > text && *end == ' ') *end-- = '\0';
                char *name = gt + 1;
                while (*name == ' ') name++;
                cmd_echo_to_file(text, name);
            } else {
                cmd_echo(cmd);
            }

        /* ── Legacy aliases (kept for muscle memory) ──────────────────── */
        } else if (strncmp(cmd, "create -f ", 10) == 0) {
            cmd_create_f(cmd + 10);
        } else if (strncmp(cmd, "create -d ", 10) == 0) {
            cmd_create_d(cmd + 10);

        /* ── Graphics ─────────────────────────────────────────────────── */
        } else if (strcmp(cmd, "render") == 0) {
            start_raytracer();

        /* ── Doom ─────────────────────────────────────────────────────── */
        } else if (strcmp(cmd, "doom") == 0) {
            cmd_doom();

        /* ── User mode / scheduler demo ──────────────────────────────── */
        } else if (strcmp(cmd, "usertest") == 0) {
            cmd_run_test();

        } else if (strcmp(cmd, "yield") == 0) {
            schedule();

        } else if (strcmp(cmd, "virtio") == 0) {
            uart_puts("Probing virtio devices...\n");
            virtio_input_init();
            virtio_blk_init();

        /* ── Help ─────────────────────────────────────────────────────── */
        } else if (strcmp(cmd, "help") == 0) {
            uart_puts("Commands:\n");
            uart_puts("  ls                    list directory\n");
            uart_puts("  cd <dir>              change directory\n");
            uart_puts("  mkdir <dir>           create directory\n");
            uart_puts("  touch <file>          create file\n");
            uart_puts("  rm <name>             delete file or directory\n");
            uart_puts("  mv <src> <dst>        move / rename\n");
            uart_puts("  show <file>           print file contents\n");
            uart_puts("  echo <text>           print text\n");
            uart_puts("  echo <text> > <file>  write text to file\n");
            uart_puts("  mkfs                  format disk (destructive)\n");
            uart_puts("  render                run path tracer\n");
            uart_puts("  doom                  launch Doom\n");
            uart_puts("  usertest              drop to EL0 + SVC demo\n");
            uart_puts("  yield                 cooperative schedule()\n");
            uart_puts("  virtio                probe virtio-input / virtio-blk\n");

        } else {
            uart_printf("Unknown command: '%s' (try 'help')\n", cmd);
        }
    }
}
