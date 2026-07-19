# Game assets (not in git)

Place an IWAD here as **`doom1.wad`**, then pack it into the kernel:

```bash
# Example: Freedoom Phase 1 (free / open content)
# Download freedoom1.wad from https://freedoom.github.io/
# and copy/rename to assets/doom1.wad

make doom-disk
```

## Why WADs are not committed

- Size (~28MB+); Git is for source, not game data
- Commercial Doom WADs must **not** be redistributed
- Freedoom *may* be redistributed under its license, but clones stay smaller if you fetch it yourself

## Prebuilt kernels

GitHub **Releases** ship a `kernel.elf` already packed with a free IWAD when available.
See the latest release notes for run instructions.
