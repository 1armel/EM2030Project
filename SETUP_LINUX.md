# Linux Setup Guide for EM2030Project

This project’s **main goal** is a working **VS Code / Cursor + CMake + Cortex-Debug** flow for **STM32F429ZI**. For the full IDE walkthrough (extensions, `.vscode/`, kits, launch, workflow), see **[docs/VSCODE_CMAKE_DEBUG.md](docs/VSCODE_CMAKE_DEBUG.md)**.

Below: host tool installation (Arch/Manjaro).

## Prerequisites Installation

### 1. Install ARM GCC Embedded Toolchain

On Manjaro/Arch Linux, install the ARM GCC toolchain using:

```bash
sudo pacman -S arm-none-eabi-gcc arm-none-eabi-binutils arm-none-eabi-gdb
```

This will install:
- `arm-none-eabi-gcc` - C/C++ compiler
- `arm-none-eabi-g++` - C++ compiler  
- `arm-none-eabi-objcopy` - Binary conversion tool
- `arm-none-eabi-size` - Size analysis tool
- `arm-none-eabi-gdb` - GDB debugger (required for debugging)
- Other ARM embedded tools

### 2. Install ST-Link Tools (for debugging/flashing)

For debugging and flashing STM32 devices:

```bash
sudo pacman -S stlink
```

This installs:
- `st-util` - ST-Link GDB server (used by VS Code Cortex-Debug extension)
- `st-flash` - Command-line flashing tool
- Other ST-Link utilities

### 3. Verify Installation

After installation, verify the tools are available:

```bash
arm-none-eabi-gcc --version
arm-none-eabi-g++ --version
arm-none-eabi-gdb --version
st-util --version
```

## Build Instructions

### Using the build script:

```bash
./build.sh
```

### Manual build:

```bash
mkdir -p build
cd build
cmake .. -G Ninja
ninja
```

## Configuration Changes Made

1. **CMakeLists.txt**: Updated linker file path from Windows absolute path to relative path
2. **arm-none-eabi-gcc.cmake**: Updated to detect ARM toolchain in Linux PATH (no .exe extensions)
3. **Inc directory**: Created if missing
4. **launch.json**: Updated debug configuration for Linux:
   - Changed `gdbPath` from Windows path to `arm-none-eabi-gdb` (uses PATH)
   - Changed `serverpath` from Windows ST-Link server to `st-util` (Linux ST-Link GDB server)
   - Updated workspace variables to use `${workspaceFolder}` instead of `${workspaceRoot}`

## VS Code Configuration

### Automatic Configuration

You can automatically generate VS Code configuration files using the provided scripts:

```bash
# Generate VS Code configuration files
./config/create_config_files.sh

# Or use the complete setup script that also opens VS Code/Cursor
./start_project.sh
```

The `start_project.sh` script will:
1. Source the environment variables (`set_env.sh`)
2. Generate VS Code configuration files (`create_config_files.sh`)
3. Open the project in VS Code or Cursor

### Manual Configuration

The `.vscode/cmake-kits.json` file is already configured to use the toolchain file. VS Code should automatically detect the ARM GCC toolchain once installed.

### Environment Setup Scripts

- **`config/set_env.sh`**: Sets up environment variables for the development environment
  - Automatically detects CMake, Ninja, ARM GCC toolchain, and other tools
  - Can be sourced manually: `source config/set_env.sh`
  
- **`config/create_config_files.sh`**: Generates VS Code configuration files
  - Creates `.vscode/cmake-variants.json`
  - Creates `.vscode/settings.json`
  
- **`start_project.sh`**: Complete project setup and launch script

## Troubleshooting

If CMake cannot find the ARM toolchain:
1. Verify installation: `which arm-none-eabi-gcc`
2. Check if tools are in PATH: `echo $PATH | grep arm-none-eabi`
3. If installed but not in PATH, you may need to add `/usr/bin` to PATH (though it should be there by default)

