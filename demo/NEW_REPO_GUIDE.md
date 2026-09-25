# Publishing this demo as a standalone portfolio repo

Use this guide when you copy the **`demo/portfolio-showcase`** branch into a new public repository under your **zitbase** naming scheme.

---

## Recommended repository name

| Field | Value |
|-------|--------|
| **GitHub repo name** | **`emb-stm32f429-vscode-debug`** |
| **Pattern** | `emb-[board]-[project]` |
| **Board** | `stm32f429` (STM32F429ZI / Nucleo-F429ZI) |
| **Project** | `vscode-debug` (CMake Tools + Cortex-Debug workflow) |
| **Visibility** | **Public** (portfolio — `zitbase-community` series) |
| **Display title** | **STM32F429ZI — VS Code / CMake build & debug** |

**What this repo showcases first:** configuring **VS Code or Cursor** to **build** (CMake + Ninja + `arm-none-eabi-gcc`) and **debug** (`Cortex-Debug` + `st-util`) the STM32F429ZI. The GPIO `Pin` sample and unit tests support that story.

### Alternatives (if the name is taken)

| Name | When to use |
|------|-------------|
| `emb-stm32f429-cmake-debug` | Emphasizes CMake over editor brand |
| `emb-stm32f429-devkit` | Generic “dev environment” slug |
| `emb-stm32f429-gpio` | If you prefer to lead with the sample driver name |

**Avoid** `EM2030Project` on the public portfolio repo — reads as coursework; `emb-*` matches your studio taxonomy.

---

## Where it fits in your taxonomy

| Bucket | Repo | This project |
|--------|------|----------------|
| Portfolio umbrella | `zitbase-community` (org or meta) | Link to `emb-stm32f429-gpio` from org profile / pinned repos |
| Client / private | `zitbase-studio` | Do **not** copy training repos here |
| Embedded | `emb-[board]-[project]` | **`emb-stm32f429-vscode-debug`** ← this demo |
| CI templates | `.github` (shared workflows) | Optional: later extract reusable workflow to template repo |

---

## Copy checklist (new repo from this branch)

### 1. Create the empty repo on GitHub

- Organization or user: e.g. `1armel` or `zitbase-community`
- Name: **`emb-stm32f429-vscode-debug`**
- Public, no README/license (you will push content)

### 2. Export only the showcase tree

From your machine (on branch `demo/portfolio-showcase`):

```bash
cd /path/to/EM2030Project
git checkout demo/portfolio-showcase

# Option A — new repo from branch tip
mkdir ../emb-stm32f429-vscode-debug && cd ../emb-stm32f429-vscode-debug
git init
git remote add origin git@github.com:YOUR_ORG/emb-stm32f429-vscode-debug.git

# Copy tracked files (respects .gitignore)
git archive demo/portfolio-showcase | tar -x -C .

# Option B — clone and orphan main
# git clone --branch demo/portfolio-showcase . ../emb-stm32f429-gpio
# cd ../emb-stm32f429-gpio && git checkout --orphan main
```

### 3. Replace README

```bash
cp demo/README.PORTFOLIO.md README.md
# Edit README.md: replace YOUR_GITHUB_ORG and badge URLs (see top of file)
```

### 4. Update Codecov & badges

In `README.md` and `.github/workflows/ci.yml`:

- `1armel/EM2030Project` → `YOUR_ORG/emb-stm32f429-vscode-debug`
- Codecov: add new repo at codecov.io, set secret **`CODECOV_TOKEN`** on the **new** repo

### 5. Trim optional files (smaller portfolio repo)

**Keep:** `Driver/STM32F429/` (Pin + startup + linker), `Src/`, `CMakeTools/`, `tests/`, `.github/`, `build.sh`, `codecov.yml`, `SETUP_LINUX.md`, `DEBUG_TROUBLESHOOTING.md`

**Optional remove** for minimal demo:

- `config/create_config_files.*`, `start_project.*` (Windows-centric)
- `demo/` folder itself after copying README
- Full training history — single clean `main` branch only

### 6. First push

```bash
git add .
git commit -m "Initial import: STM32F429 GPIO driver with host tests and CI."
git branch -M main
git push -u origin main
```

### 7. Pin on profile

- Pin **`emb-stm32f429-vscode-debug`** on GitHub
- One-line bio link: *STM32F429ZI · VS Code + CMake build & debug · bare-metal*

---

## Suggested GitHub repo description & topics

**Description**

> VS Code / Cursor + CMake + Cortex-Debug: build and debug STM32F429ZI on Linux (ST-Link). Includes sample firmware, tests, and CI.

**Topics**

`stm32`, `stm32f4`, `vscode`, `cmake`, `cortex-debug`, `embedded`, `bare-metal`, `stlink`, `arm-none-eabi-gcc`, `nucleo-f429zi`

---

## Relationship to `EM2030Project`

| Repo | Role |
|------|------|
| `EM2030Project` (private or training) | Full course tree, experiments, debug notes |
| `emb-stm32f429-vscode-debug` (public) | Polished slice: IDE + CMake + debug for freelancing |

Keep training messy; keep portfolio clean.
