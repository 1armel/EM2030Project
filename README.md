# EM2030 — STM32F429 embedded training & GPIO library

[![CI](https://github.com/1armel/EM2030Project/actions/workflows/ci.yml/badge.svg)](https://github.com/1armel/EM2030Project/actions/workflows/ci.yml)

Bare-metal firmware for **STM32F429ZI** (Cortex-M4), built with **CMake**, **Ninja**, and a small **C++ GPIO `Pin` class** over register access (STM32 LL headers).

> **Portfolio branch:** [`demo/portfolio-showcase`](https://github.com/1armel/EM2030Project/tree/demo/portfolio-showcase) — unit tests + GitHub Actions CI for freelancing demos. See [`demo/README.md`](demo/README.md).

## Highlights

- Cross-compile with `arm-none-eabi-gcc` and `CMakeTools/arm-none-eabi-gcc.cmake`
- Host-side **GoogleTest** suite for `Pin` (register mocks, no hardware)
- **GitHub Actions**: host tests + firmware cross-build
- Cursor/VS Code: CMake Tools, Cortex-Debug (`servertype: stutil`)

## Quick start

### Unit tests (host, no board)

```bash
cmake -S tests -B build-tests -G Ninja
cmake --build build-tests
ctest --test-dir build-tests --output-on-failure
```

### Firmware

```bash
bash build.sh
```

### Debug on hardware

See [`SETUP_LINUX.md`](SETUP_LINUX.md) and [`DEBUG_TROUBLESHOOTING.md`](DEBUG_TROUBLESHOOTING.md).

## Project structure

| Path | Role |
|------|------|
| `Src/` | Application (`main.cpp`, syscalls) |
| `Driver/STM32F429/` | MCU startup, linker script, `Pin` driver |
| `CMakeTools/` | Toolchain and board CMake |
| `tests/` | Host unit tests |
| `.github/workflows/` | CI pipeline |

## Author

Armel Kamdem — embedded training / portfolio work (EM2030).
