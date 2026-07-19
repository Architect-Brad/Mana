# Contributing to Mana

First of all: you want to contribute to a bare-metal AArch64 kernel that is actively trying to run Doom with no operating system beneath it.
That either makes you very brave or very confused. Either way, welcome.

---

## Before you do anything

Read the codebase. The whole thing. It's not that big.
You are not allowed to open a PR that touches a file you haven't read.
We will know.

---

## What we want

### Useful contributions

- **Bug fixes** — if you found a bug, you are now responsible for fixing it. That's the deal.
- **Doom port progress** — see `doom/PORTING.md`. There is a checklist. Pick an item.
- **Driver work** — virtio-input (real keyboard), virtio-blk (real storage), anything that removes a stub from `i_sound.c`.
- **Memory management improvements** — the heap is first-fit. If you implement something smarter and it's measurably better, we'll take it.
- **Scheduler** — currently everything runs in kernel mode forever. If you want to fix that, you have the floor.
- **Documentation** — if you understood something that took you two hours to figure out, write it down so the next person only needs five minutes.

### Things we don't want

- **New shell commands** unless they're genuinely useful (no `cowsay`, we have a path tracer)
- **Rewrites in Rust** — not yet, maybe someday, not today
- **Anything that requires a host OS at runtime** — this is bare metal, not a compromise
- **PRs that add features by removing features** — that's called a bug

---

## Code style

There is no enforced formatter. There is, however, taste.

**C files:**
- 4-space indentation. Not tabs. Yes, we have opinions.
- `snake_case` for functions and variables. `SCREAMING_SNAKE` for constants and macros.
- Every function that does something non-obvious gets a comment explaining *why*, not *what*. The code already says what. We need the why.
- No magic numbers without a comment. `0x09000000` is not a number, it's the UART base address. Say so.

```c
/* Good — explains the decision */
/* We use first-fit rather than best-fit because coalescing amortises
 * the fragmentation cost and our allocation patterns are short-lived. */
void *kmalloc(size_t size) { ... }

/* Bad — explains nothing */
/* allocate memory */
void *kmalloc(size_t size) { ... }
```

**Assembly (`.S` files):**
- Comment every non-trivial instruction.
- Label names are descriptive. `.Lloop` is not a name. `.Lbss_clear_loop` is a name.
- The AArch64 ARM reference manual is not a suggestion.

**C++ files (path tracer):**
- We are in freestanding mode. You do not get exceptions. You do not get RTTI.
- No `new` without a matching `delete`. We have `kfree()` now. Use it.
- If you need a standard library function, either it's in `src/lib/libc.c` or you're about to add it.

**Comments in general:**
Mana comments are allowed to have personality. Sarcasm is encouraged.
What is not allowed is vagueness. "// do the thing" will be rejected.
"// ARM requires a DSB here before the cache maintenance instruction,
//  otherwise the prefetcher will eat your write before it hits RAM" will be accepted with gratitude.

---

## How to submit a PR

1. Fork [github.com/Architect-Brad/Mana](https://github.com/Architect-Brad/Mana).
2. Create a branch. Name it something meaningful. `fix/bss-clear` not `my-changes-v3-final-FINAL`.
3. Make your changes.
4. Test it in QEMU. `make run`. If it boots and doesn't immediately crash, you're probably fine.
5. Write a PR description that explains what you changed and why. One paragraph minimum. Not bullet points that say "- fixed bug". Which bug? Why was it a bug? What broke if you didn't fix it?
6. Open the PR.

We do not have CI yet. We do not have a test suite. The test suite is "does QEMU boot it." This is a known problem.

---

## Issue reporting

If you found a bug:
- What were you doing?
- What happened?
- What should have happened?
- QEMU output, if applicable.

If you have a feature idea:
- What does it enable that doesn't currently exist?
- Is it feasible on bare metal AArch64?
- Are you willing to implement it?

If you're reporting that Doom doesn't work yet: we know. It's in the goals list. We're getting there.

---

## Attribution

If your contribution is substantial, you go in the README. That's the deal.
No CLAs. No legal agreements. Just code and credit.

---

*Mana is maintained by [The Architect](https://github.com/Architect-Brad) — [github.com/Architect-Brad/Mana](https://github.com/Architect-Brad/Mana)*
*Original foundation by [Manan Bhardwaj](https://github.com/Valt445)*
*All bugs are features until proven otherwise.*
