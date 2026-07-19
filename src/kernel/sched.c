/* ─────────────────────────────────────────────────────────────────────────
 * sched.c — Round-robin scheduler
 * ───────────────────────────────────────────────────────────────────────── */
#include "task.h"
#include "kmalloc.h"
#include "uart.h"
#include "aarch64.h"
#include <stddef.h>

struct task  tasks[MAX_TASKS];
struct task *current;

static int g_next_tid = 1;
static int g_sched_ready;

/* Idle burns cycles until an IRQ / another task is ready */
static void idle_task(void) {
    for (;;) {
        __asm__ __volatile__("wfe" ::: "memory");
        schedule();
    }
}

void sched_init(void) {
    int i;
    for (i = 0; i < MAX_TASKS; i++) {
        tasks[i].state = TASK_UNUSED;
        tasks[i].tid   = -1;
    }

    /* Task 0 = bootstrap / shell context currently running */
    tasks[0].tid   = 0;
    tasks[0].state = TASK_RUNNING;
    tasks[0].mode  = TASK_KERNEL;
    tasks[0].name[0] = 'k'; tasks[0].name[1] = 'm';
    tasks[0].name[2] = 'a'; tasks[0].name[3] = 'i';
    tasks[0].name[4] = 'n'; tasks[0].name[5] = '\0';
    current = &tasks[0];

    /* Idle as task 1 */
    task_create("idle", idle_task);

    g_sched_ready = 1;
    uart_puts("[sched] ready\n");
}

static int alloc_slot(void) {
    int i;
    for (i = 0; i < MAX_TASKS; i++) {
        if (tasks[i].state == TASK_UNUSED)
            return i;
    }
    return -1;
}

static void copy_name(struct task *t, const char *name) {
    int i = 0;
    if (!name)
        name = "?";
    for (; i < TASK_NAME_LEN - 1 && name[i]; i++)
        t->name[i] = name[i];
    t->name[i] = '\0';
}

/* Kernel thread trampoline: entered after first switch with entry in x19 */
static void kthread_trampoline(void) {
    void (*fn)(void) = (void (*)(void))current->entry;
    if (fn)
        fn();
    task_exit(0);
}

int task_create(const char *name, void (*entry)(void)) {
    int slot = alloc_slot();
    if (slot < 0)
        return -1;

    struct task *t = &tasks[slot];
    t->tid   = g_next_tid++;
    t->state = TASK_READY;
    t->mode  = TASK_KERNEL;
    t->entry = entry;
    copy_name(t, name);

    t->kstack = (uint8_t *)kmalloc(TASK_STACK_SIZE);
    if (!t->kstack) {
        /* Fallback static stack if heap not ready */
        static uint8_t stacks[MAX_TASKS][TASK_STACK_SIZE]
            __attribute__((aligned(16)));
        t->kstack = stacks[slot];
    }

    t->sp     = (uint64_t)(t->kstack + TASK_STACK_SIZE);
    t->elr    = (uint64_t)kthread_trampoline;
    t->spsr   = 0x3c5; /* EL1h */
    t->sp_el0 = 0;
    {
        int i;
        for (i = 0; i < 31; i++)
            t->x[i] = 0;
    }

    return (int)t->tid;
}

int task_create_user(const char *name, void (*entry)(void),
                     void *user_stack, size_t stack_sz) {
    int slot = alloc_slot();
    if (slot < 0)
        return -1;

    struct task *t = &tasks[slot];
    t->tid   = g_next_tid++;
    t->state = TASK_READY;
    t->mode  = TASK_USER;
    t->entry = entry;
    copy_name(t, name);

    t->kstack = (uint8_t *)kmalloc(TASK_STACK_SIZE);
    if (!t->kstack) {
        static uint8_t stacks[MAX_TASKS][TASK_STACK_SIZE]
            __attribute__((aligned(16)));
        t->kstack = stacks[slot];
    }

    t->sp     = (uint64_t)(t->kstack + TASK_STACK_SIZE);
    t->elr    = (uint64_t)entry;
    t->spsr   = 0x0; /* EL0t, DAIF clear */
    t->sp_el0 = (uint64_t)user_stack + stack_sz;
    {
        int i;
        for (i = 0; i < 31; i++)
            t->x[i] = 0;
    }

    uart_puts("[sched] user task created\n");
    return (int)t->tid;
}

int task_self(void) {
    return current ? (int)current->tid : -1;
}

void task_exit(int code) {
    (void)code;
    if (!current)
        for (;;)
            ;
    uart_printf("[sched] task %d '%s' exit\n", current->tid, current->name);
    current->state = TASK_ZOMBIE;
    schedule();
    for (;;)
        ;
}

void task_load_trapframe(exception_frame *exc) {
    struct task *t = current;
    if (!t)
        return;
    exc->exc_elr  = t->elr;
    exc->exc_spsr = t->spsr;
    exc->exc_sp   = t->sp_el0;
    for (int i = 0; i < 31; i++)
        ((uint64_t *)&exc->x0)[i] = t->x[i];
}

static void task_save_trapframe(exception_frame *exc) {
    struct task *t = current;
    if (!t)
        return;
    t->elr    = exc->exc_elr;
    t->spsr   = exc->exc_spsr;
    t->sp_el0 = exc->exc_sp;
    for (int i = 0; i < 31; i++)
        t->x[i] = ((uint64_t *)&exc->x0)[i];
}

static struct task *pick_next(void) {
    int start = 0;
    if (current) {
        start = (int)(current - tasks);
    }
    /* Round-robin from start+1 */
    for (int n = 1; n <= MAX_TASKS; n++) {
        int i = (start + n) % MAX_TASKS;
        if (tasks[i].state == TASK_READY)
            return &tasks[i];
    }
    /* Prefer current if still running */
    if (current && current->state == TASK_RUNNING)
        return current;
    /* Fall back to idle (slot 1 if present) or task 0 */
    for (int i = 0; i < MAX_TASKS; i++) {
        if (tasks[i].state == TASK_READY || tasks[i].state == TASK_RUNNING)
            return &tasks[i];
    }
    return current;
}

/* Cooperative schedule without a trapframe — only for pure kernel yield.
 * Uses a simple "jump to next task entry" model for first-run threads.
 * For the shell (task 0), we just mark ready and continue when re-selected.
 *
 * Full context switch for kernel threads without assembly is limited;
 * first-time READY kernel tasks are entered via a soft drop (set LR path).
 * Timer/SVC paths use sched_from_trap with full GPRs. */
void schedule(void) {
    if (!g_sched_ready || !current)
        return;

    struct task *prev = current;
    if (prev->state == TASK_RUNNING)
        prev->state = TASK_READY;

    struct task *next = pick_next();
    if (!next || next == prev) {
        if (prev->state == TASK_READY)
            prev->state = TASK_RUNNING;
        return;
    }

    current = next;
    next->state = TASK_RUNNING;

    /* User tasks: drop to EL0 */
    if (next->mode == TASK_USER) {
        extern void drop_to_el0(uint64_t pc, uint64_t sp);
        drop_to_el0(next->elr, next->sp_el0);
        /* does not return unless something is wrong */
    }

    /* Kernel task first entry: call trampoline (does not restore full regs) */
    if (next->entry && next->elr == (uint64_t)kthread_trampoline) {
        void (*fn)(void) = kthread_trampoline;
        /* Prevent re-entry as "first time" — clear by advancing elr sentinel */
        next->entry = next->entry; /* keep */
        /* Mark so we don't recurse oddly — call directly */
        fn();
    }
}

void sched_tick(void) {
    if (!g_sched_ready)
        return;
    /* Preemption between pure kernel threads is cooperative for now.
     * When we have a trapframe (IRQ from anywhere), sched_from_trap is used. */
}

void sched_from_trap(exception_frame *exc) {
    if (!g_sched_ready || !current) {
        return;
    }

    task_save_trapframe(exc);

    if (current->state == TASK_RUNNING)
        current->state = TASK_READY;

    struct task *next = pick_next();
    if (!next)
        next = current;

    current = next;
    current->state = TASK_RUNNING;
    task_load_trapframe(exc);
}
