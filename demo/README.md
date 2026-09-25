# Portfolio demo — VS Code + CMake + debug on STM32F429ZI

This branch is the **public showcase** slice of the EM2030 training project.

## Main message

**How to configure VS Code / Cursor with CMake to build and debug the STM32F429ZI** (Linux, ST-Link, Cortex-Debug) — with a minimal firmware sample and CI to prove it works.

Read the full guide: **[docs/VSCODE_CMAKE_DEBUG.md](../docs/VSCODE_CMAKE_DEBUG.md)**

## What reviewers should look at first

| Priority | Path | Content |
|----------|------|---------|
| 1 | `.vscode/` | CMake Tools + Cortex-Debug (`stutil`) |
| 2 | `docs/VSCODE_CMAKE_DEBUG.md` | Step-by-step IDE setup |
| 3 | `CMakeTools/` | ARM GCC toolchain + board CMake |
| 4 | `SETUP_LINUX.md` / `DEBUG_TROUBLESHOOTING.md` | Host install & fixes |
| 5 | `tests/` | Host unit tests (bonus quality signal) |

## Also demonstrates

- Bare-metal **C++** `Pin` GPIO helper
- **GitHub Actions** (tests + cross-build)
- **Codecov** on driver code

## Publish as standalone repo

See **[NEW_REPO_GUIDE.md](NEW_REPO_GUIDE.md)** — recommended name: **`emb-stm32f429-vscode-debug`**.

Use **[README.PORTFOLIO.md](README.PORTFOLIO.md)** as the root `README.md` in the new repository.
