# VS Code / Cursor — CMake build & debug (STM32F429ZI)

This repository is a **ready-to-clone dev environment**: open the folder, build with CMake Tools, and debug over ST-Link with one keypress.

Target: **STM32F429ZI** (e.g. Nucleo-F429ZI), **SWD**, onboard **ST-Link V2.1**.

---

## 1. Extensions (VS Code or Cursor)

| Extension | ID / name | Role |
|-----------|-----------|------|
| **CMake Tools** | `ms-vscode.cmake-tools` | Configure, build, kit/toolchain |
| **Cortex-Debug** | `marus25.cortex-debug` | GDB + ST-Link (`st-util`) |
| **C/C++** | `ms-vscode.cpptools` | IntelliSense (optional but useful) |

---

## 2. Host tools (Linux)

```bash
# Arch / Manjaro
sudo pacman -S cmake ninja arm-none-eabi-gcc arm-none-eabi-binutils arm-none-eabi-gdb stlink

# Debian / Ubuntu
sudo apt install cmake ninja-build gcc-arm-none-eabi binutils-arm-none-eabi \
  gdb-multiarch stlink-tools
# (use arm-none-eabi-gdb package if available instead of gdb-multiarch)
```

Verify:

```bash
arm-none-eabi-gcc --version
arm-none-eabi-gdb --version
st-util --version
```

### USB permissions (ST-Link)

On Arch/Manjaro, create `plugdev` if missing, add your user, reload udev, replug the board:

```bash
sudo groupadd plugdev 2>/dev/null || true
sudo usermod -aG plugdev $USER
sudo udevadm control --reload-rules && sudo udevadm trigger
```

Log out and back in. Test: `st-util` → `Listening at *:4242...` (Ctrl+C to stop).

See [DEBUG_TROUBLESHOOTING.md](../DEBUG_TROUBLESHOOTING.md) for more.

---

## 3. How CMake is wired

| File | Purpose |
|------|---------|
| [`CMakeLists.txt`](../CMakeLists.txt) | Root project; points to ARM toolchain file |
| [`CMakeTools/arm-none-eabi-gcc.cmake`](../CMakeTools/arm-none-eabi-gcc.cmake) | Cross-compiler (`arm-none-eabi-gcc`) |
| [`CMakeTools/STM32F429.cmake`](../CMakeTools/STM32F429.cmake) | Sources, flags, linker script |
| [`Driver/STM32F429/Linker/STM32F429ZITx_FLASH.ld`](../Driver/STM32F429/Linker/STM32F429ZITx_FLASH.ld) | Memory layout |

Flow:

1. CMake Tools reads [`.vscode/cmake-kits.json`](../.vscode/cmake-kits.json) → kit **GCC Arm Embedded** → `CMAKE_TOOLCHAIN_FILE`.
2. [`.vscode/settings.json`](../.vscode/settings.json) sets generator **Ninja**, build dir **`build/`**, configure on open.
3. Status bar: **Configure** → **Build** → produces `build/PROJECT_V001.elf`.

CLI equivalent:

```bash
cmake -S . -B build -G Ninja
cmake --build build
```

Or: `bash build.sh` (incremental; `bash build.sh --clean` for full wipe).

---

## 4. VS Code workspace files

### `.vscode/settings.json`

- `cmake.configureOnOpen`: auto-configure when folder opens  
- `cmake.buildDirectory`: `${workspaceFolder}/build`  
- `cmake.generator`: `Ninja`  
- `cmake.cmakePath` / `CMAKE_MAKE_PROGRAM`: adjust if tools are not in `/usr/bin`

### `.vscode/cmake-kits.json`

Defines one kit:

```json
{
  "name": "GCC Arm Embedded",
  "toolchainFile": "${workspaceFolder}/CMakeTools/arm-none-eabi-gcc.cmake"
}
```

Select this kit in the status bar if CMake asks.

### `.vscode/launch.json` (Cortex-Debug)

Important for **Linux**:

| Setting | Value | Why |
|---------|--------|-----|
| `type` | `cortex-debug` | ARM debug extension |
| `servertype` | **`stutil`** | Linux `st-util` (not Windows `stlink`) |
| `serverpath` | `st-util` | GDB server in PATH |
| `gdbPath` | `arm-none-eabi-gdb` | Target GDB |
| `device` | `STM32F429ZI` | MCU profile |
| `interface` | `swd` | Nucleo default |
| `executable` | `build/PROJECT_V001.elf` | Must exist after build |
| `svdPath` | `Driver/STM32F429/STM32F429.svd` | Peripheral registers view |
| `runToEntryPoint` | `main` | Stop at `main` |

**Do not** use `"servertype": "stlink"` on Linux — that passes Windows-only flags (`--swd`, `--halt`, `-cp`) and `st-util` will exit immediately.

---

## 5. Day-to-day workflow in the IDE

```text
1. Open folder in VS Code / Cursor
2. CMake: Configure (kit = GCC Arm Embedded)
3. CMake: Build          → build/PROJECT_V001.elf
4. Connect Nucleo via USB
5. F5 → "Debug STM32F429"
6. Set breakpoints in Src/main.cpp or Driver/.../Pin.cpp
```

If CMake Tools reports missing `toolchains-v1-*.json`:

- **CMake: Delete Cache and Reconfigure**
- Avoid deleting `build/` from the terminal without reconfiguring the IDE afterward

---

## 6. Sample application

[`Src/main.cpp`](../Src/main.cpp) toggles **PB7** via the [`Pin`](../Driver/STM32F429/Inc/Pin.hpp) helper — enough to verify build and debug on real hardware.

---

## 7. Optional: host unit tests

Logic tests run on the PC (no board): see [tests/](../tests/) and root README. CI runs these plus the firmware cross-build.

---

## 8. Quick troubleshooting

| Symptom | Fix |
|---------|-----|
| `st-util: unrecognized option '--swd'` | Use `"servertype": "stutil"` in `launch.json` |
| `errno=13` / no ST-Link | `plugdev` group + udev reload + replug |
| `ENOENT` … `toolchains-v1-….json` | Delete CMake cache & reconfigure |
| `PROJECT_V001.elf` not found | Build first (CMake: Build) |

Full list: [DEBUG_TROUBLESHOOTING.md](../DEBUG_TROUBLESHOOTING.md).
