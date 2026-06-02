
<img width="1070" height="785" alt="image" src="https://github.com/user-attachments/assets/38283f08-ec9a-40f5-beac-d1a912b65e05" />
Path traced image at 128 samples built in my own kernel with no extra dependencies 

# Mana Kernel
A bare-metal, unhosted microkernel architected for the ARMv8-A (AArch64) platform.

---

### Core System Architecture
*   **AArch64 Native Implementation**: Built specifically for the 64-bit ARM architecture to leverage modern hardware features.
*   **Memory Management Unit (MMU)**: Features static and dynamic identity mapping to manage hardware address spaces and ensure memory protection.
*   **Exception Handling**: Includes a custom-built interrupt and exception vector table to manage system calls, hardware faults, and execution level transitions.
*   **Precision Timer**: Native integration with the ARM generic timer for hardware-level task scheduling and execution profiling.
*   **UART Serial I/O**: Direct serial communication implementation used for low-level system telemetry and interactive console communication.

---

### Filesystem and Storage
*   **MINIX Filesystem Support**: Implementation of the MINIX filesystem layout, providing a robust structure for persistent storage and directory management.
*   **File Operations**: Full support for standard filesystem interactions within the kernel environment.

---

### Graphics and Rendering Pipeline
*   **In-House Path Tracer**: A custom-integrated rendering engine capable of performing real-time light transport simulation directly within the bare-metal environment.
*   **RAMFB Display**: Memory-mapped RAM Framebuffer for high-speed, direct pixel output to display peripherals, bypassing traditional driver overhead.

---

### Interactive Shell and Utilities
The Mana kernel features a functional interactive console environment. Supported system utilities include:
*   `ls`: Enumerate contents of the current or specified directory.
*   `cd`: Change the current working directory across the MINIX filesystem.
*   `mkdir`: Create new directory structures.
*   `touch`: Initialize new, empty file nodes.
*   `echo`: Output text streams to the system console.
*   `echo >`: Support for output redirection to create or overwrite file contents.
*   `rm`: Remove file or directory objects from storage.
*   `mv`: Relocate or rename files and directory structures.

---

### Compilation and Development
*   **Cross-Compilation**: The project requires the `aarch64-none-elf` GCC or Clang toolchain.
*   **Build System**: Utilizes CMake for cross-platform build automation.
*   **Deployment Scripts**: Includes `build_kernel.bat` (Windows) and `build_kernel.sh` (Linux/macOS) for automated image generation.

---

**Lead Developer**: Manan Bhardwaj
