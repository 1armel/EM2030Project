# Portfolio demo — EM2030 embedded GPIO layer

This branch is a **freelancing showcase**: a trimmed, professional slice of the full STM32F429 training project.

## What it demonstrates

| Skill | Evidence in this repo |
|-------|------------------------|
| **Bare-metal C++** | `Pin` class wrapping STM32 GPIO registers (LL-style, no HAL) |
| **Cross-compilation** | CMake + `arm-none-eabi-gcc`, Ninja, linker script |
| **Test-driven quality** | 7 GoogleTest unit tests on host with hardware mocks |
| **Coverage** | [Codecov](https://codecov.io/gh/1armel/EM2030Project) — `lcov` on `Pin.cpp` in CI |
| **CI/CD** | GitHub Actions: host tests + firmware build on every push |
| **Developer experience** | VS Code/Cursor (CMake Tools, Cortex-Debug), Linux setup docs |

## Repository layout (demo focus)

```
Driver/STM32F429/Inc/Pin.hpp    # GPIO abstraction API
Driver/STM32F429/Src/Pin.cpp    # Register-level implementation
tests/                          # Host unit tests (no board required)
.github/workflows/ci.yml        # Automated CI
Src/main.cpp                    # Minimal firmware entry (LED on PB7)
```

## Run unit tests locally

```bash
cmake -S tests -B build-tests -G Ninja
cmake --build build-tests
ctest --test-dir build-tests --output-on-failure
```

## Coverage (local)

```bash
bash tests/run_coverage.sh
```

## Codecov setup (one-time, for CI badge)

1. Sign in at [codecov.io](https://codecov.io) with GitHub.
2. Add repository **1armel/EM2030Project**.
3. Copy the repository upload token.
4. In GitHub: **Settings → Secrets → Actions → New secret** → name `CODECOV_TOKEN`, paste token.
5. Push to `demo/portfolio-showcase` — CI uploads `build-tests/coverage.info` automatically.

## Build firmware locally

```bash
bash build.sh
# Output: build/PROJECT_V001.elf (+ .hex / .bin)
```

Requires: `arm-none-eabi-gcc`, `cmake`, `ninja` (see `SETUP_LINUX.md`).

## Full project

The complete training tree (debug setup, board bring-up, clock config) lives on other branches (`main`, `For_zitbase`, etc.). This branch highlights **reusable embedded C++ and automated quality gates** for portfolio reviewers.
