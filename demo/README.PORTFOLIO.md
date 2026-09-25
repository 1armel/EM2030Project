<p align="center">
  <img src="https://img.shields.io/badge/STM32F429ZI-Cortex--M4-03234B?style=for-the-badge&logo=stmicroelectronics&logoColor=white" alt="STM32F429ZI"/>
  <img src="https://img.shields.io/badge/VS%20Code-CMake%20%2B%20Debug-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white" alt="VS Code"/>
  <img src="https://img.shields.io/badge/arm--none--eabi-GCC-A8B9CC?style=for-the-badge&logo=gnu&logoColor=black" alt="ARM GCC"/>
</p>

<p align="center">
  <a href="https://github.com/YOUR_GITHUB_ORG/emb-stm32f429-vscode-debug/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/YOUR_GITHUB_ORG/emb-stm32f429-vscode-debug/ci.yml?branch=main&label=CI&logo=githubactions&logoColor=white" alt="CI"/></a>
  <a href="https://codecov.io/gh/YOUR_GITHUB_ORG/emb-stm32f429-vscode-debug"><img src="https://img.shields.io/codecov/c/github/YOUR_GITHUB_ORG/emb-stm32f429-vscode-debug?logo=codecov&logoColor=white" alt="Codecov"/></a>
  <img src="https://img.shields.io/badge/C%2B%2B-17-00599C?logo=cplusplus&logoColor=white" alt="C++17"/>
  <img src="https://img.shields.io/badge/CMake-3.15%2B-064F8C?logo=cmake&logoColor=white" alt="CMake"/>
  <img src="https://img.shields.io/badge/Ninja-build-black?logo=ninja&logoColor=white" alt="Ninja"/>
  <img src="https://img.shields.io/badge/GoogleTest-host%20tests-00A98F?logo=google&logoColor=white" alt="GoogleTest"/>
  <img src="https://img.shields.io/badge/License-Proprietary-red.svg" alt="License"/>
</p>

# STM32F429ZI — Build & Debug with VS Code and CMake

Cross-compile and debug bare-metal firmware for the **STM32F429ZI** (Nucleo-F429ZI) from **VS Code** or **Cursor** on Linux — using **CMake Tools**, **Cortex-Debug**, and **ST-Link** (`st-util`). No STM32CubeIDE required.

This repository provides a complete workspace: toolchain files, `.vscode` configuration, sample firmware, host unit tests, and CI.

---

## Features

| | |
|--|--|
| **IDE-ready** | Preconfigured [`.vscode/`](.vscode/) for CMake Tools and Cortex-Debug |
| **Cross-build** | `arm-none-eabi-gcc` via [`CMakeTools/`](CMakeTools/) |
| **On-chip debug** | SWD + ST-Link + GDB (`F5` → *Debug STM32F429*) |
| **Sample app** | Minimal C++ firmware and GPIO `Pin` helper |
| **Host tests** | GoogleTest suite (no board required) |
| **CI** | GitHub Actions: unit tests, coverage, firmware build |

---

## Requirements

| Component | Notes |
|-----------|--------|
| **Board** | Nucleo-F429ZI (or compatible STM32F429ZI + ST-Link) |
| **OS** | Linux (Arch / Manjaro / Ubuntu / Debian) |
| **IDE** | [VS Code](https://code.visualstudio.com/) or [Cursor](https://cursor.com/) |
| **Extensions** | [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools), [Cortex-Debug](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug) |

### Host packages

```bash
# Arch / Manjaro
sudo pacman -S cmake ninja arm-none-eabi-gcc arm-none-eabi-binutils \
  arm-none-eabi-gdb stlink

# Ubuntu / Debian
sudo apt install cmake ninja-build gcc-arm-none-eabi binutils-arm-none-eabi \
  gdb-multiarch stlink-tools
```

Verify:

```bash
arm-none-eabi-gcc --version
arm-none-eabi-gdb --version
st-util --version
```

### ST-Link USB access

```bash
sudo groupadd plugdev 2>/dev/null || true
sudo usermod -aG plugdev "$USER"
sudo udevadm control --reload-rules && sudo udevadm trigger
```

Log out and back in, then reconnect the board. Confirm with `st-util` (you should see `Listening at *:4242...`).

---

## Getting started

### 1. Open the project

```bash
git clone https://github.com/YOUR_GITHUB_ORG/emb-stm32f429-vscode-debug.git
cd emb-stm32f429-vscode-debug
code .   # or: cursor .
```

### 2. Configure and build (IDE)

1. Select kit **GCC Arm Embedded** (from [`.vscode/cmake-kits.json`](.vscode/cmake-kits.json)).
2. **CMake: Configure** → **CMake: Build**.
3. Output: `build/PROJECT_V001.elf`.

### 3. Build (CLI)

```bash
cmake -S . -B build -G Ninja
cmake --build build
# or: bash build.sh
```

### 4. Debug on hardware

1. Connect the Nucleo board over USB.
2. Press **F5** or run configuration **Debug STM32F429**.
3. Set breakpoints in [`Src/main.cpp`](Src/main.cpp).

> **Linux:** `launch.json` must use `"servertype": "stutil"` (not `"stlink"`).

Full walkthrough: **[docs/VSCODE_CMAKE_DEBUG.md](docs/VSCODE_CMAKE_DEBUG.md)**

---

## Testing

### Host unit tests (no board)

```bash
cmake -S tests -B build-tests -G Ninja
cmake --build build-tests
ctest --test-dir build-tests --output-on-failure
```

Coverage (optional; requires `lcov`):

```bash
bash tests/run_coverage.sh
```

### Firmware smoke check

```bash
cmake -S . -B build -G Ninja && cmake --build build
arm-none-eabi-size build/PROJECT_V001.elf
ls -lh build/PROJECT_V001.{elf,hex,bin}
```

### CI

Every push runs:

- Host GoogleTest suite + Codecov upload  
- ARM cross-compile of `PROJECT_V001.elf`

See [`.github/workflows/ci.yml`](.github/workflows/ci.yml).

---

## Project layout

```
.
├── .vscode/                 # CMake Tools + Cortex-Debug
├── CMakeTools/              # ARM GCC toolchain & board CMake
├── Driver/STM32F429/        # Startup, linker, SVD, Pin driver
├── Src/                     # Application (main.cpp)
├── tests/                   # Host unit tests
├── docs/                    # IDE setup guide
└── .github/workflows/       # CI
```

| Path | Role |
|------|------|
| [`.vscode/settings.json`](.vscode/settings.json) | Ninja, build dir, configure on open |
| [`.vscode/cmake-kits.json`](.vscode/cmake-kits.json) | Kit → `arm-none-eabi-gcc.cmake` |
| [`.vscode/launch.json`](.vscode/launch.json) | Debug: `st-util`, SWD, SVD |
| [`CMakeTools/arm-none-eabi-gcc.cmake`](CMakeTools/arm-none-eabi-gcc.cmake) | Cross-compiler |
| [`docs/VSCODE_CMAKE_DEBUG.md`](docs/VSCODE_CMAKE_DEBUG.md) | Detailed setup & troubleshooting |

---

## Documentation

- [VS Code / CMake / Debug guide](docs/VSCODE_CMAKE_DEBUG.md)
- [Linux setup](SETUP_LINUX.md)
- [Debug troubleshooting](DEBUG_TROUBLESHOOTING.md)

---

## License

**Proprietary — All Rights Reserved.** See [LICENSE](LICENSE).

You may view this repository for evaluation only. You may **not** use, copy, modify, distribute, or commercialize the Owner’s original work without prior written permission.

STM32 CMSIS / ST header files remain under their respective STMicroelectronics license terms.
