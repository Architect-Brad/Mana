/* ─────────────────────────────────────────────────────────────────────────
 * task.h — Process control block and scheduler API
 * ───────────────────────────────────────────────────────────────────────── */
#ifndef MANA_TASK_H
#define MANA_TASK_H

#include "exception.h"
#include <stddef.h>
#include <stdint.h>

#define MAX_TASKS       8
#define TASK_STACK_SIZE 8192
#define TASK_NAME_LEN   16

/* Explicit integer states — avoid enum packing surprises under -O2 */
#define TASK_UNUSED  0
#define TASK_READY   1
#define TASK_RUNNING 2
#define TASK_BLOCKED 3
#define TASK_ZOMBIE  4

#define TASK_KERNEL  0
#define TASK_USER    1

struct task {
    int64_t          tid;
    int64_t          state;
    int64_t          mode;
    char             name[TASK_NAME_LEN];

    uint64_t         sp;
    uint64_t         sp_el0;
    uint64_t         elr;
    uint64_t         spsr;
    uint64_t         x[31];

    uint8_t         *kstack;
    void           (*entry)(void);
};

extern struct task  tasks[MAX_TASKS];
extern struct task *current;

void sched_init(void);
int  task_create(const char *name, void (*entry)(void));
int  task_create_user(const char *name, void (*entry)(void),
                      void *user_stack, size_t stack_sz);
void schedule(void);
void sched_tick(void);
void task_exit(int code);
int  task_self(void);
void sched_from_trap(exception_frame *exc);
void task_load_trapframe(exception_frame *exc);

#endif /* MANA_TASK_H */
