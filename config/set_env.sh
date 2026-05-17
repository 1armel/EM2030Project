#!/bin/bash

# ///////////////////////////////////////////////
# /// \file set_env.sh 
# /// \copyright (c) TonkaIn - All rights reserved 
# ///  unautorized copying of this file, via any medium is strictly prohibited
# ///
# /// \ author  Armel Kamdem 
# /// \ version  1.0.0 
# ///
# /// \brief   Setup the development environment (Linux version)
# /// 
# /// \b  Description
# /// This script sets up the development environment by adding 
# /// environment variables for compiler, tools and build tools.
# /// Additionally CMake and Ninja paths are set to make the build 
# /// tools accessible for command line and CI builds.
# ///
# //////////////////////////////////////////////////////////////////////////////////////

# -----------------------------------------------------------------------------------------------
# CONFIG PROJECT
# -----------------------------------------------------------------------------------------------
export NAME_PROJECT=PROJECT_V001

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
export BUILD_DIR="${PROJECT_ROOT}"

# -----------------------------------------------------------------------------------------------
# Build Tools
# ------------------------------------------------------------------------------------------------
# Find CMake and Ninja in standard Linux locations
CMAKE_PATH=$(which cmake 2>/dev/null)
NINJA_PATH=$(which ninja 2>/dev/null)

if [ -n "$CMAKE_PATH" ]; then
    CMAKE_DIR=$(dirname "$CMAKE_PATH")
    export TOOLCHAIN_CMAKE="$CMAKE_DIR"
else
    # Fallback to common installation paths
    export TOOLCHAIN_CMAKE="/usr/bin"
fi

if [ -n "$NINJA_PATH" ]; then
    NINJA_DIR=$(dirname "$NINJA_PATH")
    export TOOLCHAIN_NINJA="$NINJA_DIR"
else
    # Fallback to common installation paths
    export TOOLCHAIN_NINJA="/usr/bin"
fi

# -----------------------------------------------------------------------------------------------
# Compiler 
# -----------------------------------------------------------------------------------------------
# ARM GCC - typically installed via package manager in /usr/bin
ARM_GCC_PATH=$(which arm-none-eabi-gcc 2>/dev/null)
if [ -n "$ARM_GCC_PATH" ]; then
    ARM_TOOLCHAIN_DIR=$(dirname "$ARM_GCC_PATH")
    export ARM_TOOLCHAIN_PATH="$ARM_TOOLCHAIN_DIR"
else
    # Fallback to standard location
    export ARM_TOOLCHAIN_PATH="/usr/bin"
fi

# -----------------------------------------------------------------------------------------------
# Debug Tools
# ------------------------------------------------------------------------------------------------
# ST-Link tools (if installed)
ST_LINK_PATH=$(which st-flash 2>/dev/null || which stlink-gdb-server 2>/dev/null)
if [ -n "$ST_LINK_PATH" ]; then
    ST_LINK_DIR=$(dirname "$ST_LINK_PATH")
    export TOOLCHAIN_ST_LINK="$ST_LINK_DIR"
else
    # Common installation locations for stlink tools
    if [ -d "/usr/local/bin" ]; then
        export TOOLCHAIN_ST_LINK="/usr/local/bin"
    else
        export TOOLCHAIN_ST_LINK="/usr/bin"
    fi
fi

# STM32CubeProgrammer (if installed via package manager or manually)
if [ -d "/opt/st/stm32cubeclt" ]; then
    export STM32CUBE_PROGRAMMER="/opt/st/stm32cubeclt/bin"
elif [ -d "$HOME/STM32CubeProgrammer/bin" ]; then
    export STM32CUBE_PROGRAMMER="$HOME/STM32CubeProgrammer/bin"
else
    # Try to find in PATH
    CUBE_PROG=$(which STM32CubeProgrammer 2>/dev/null)
    if [ -n "$CUBE_PROG" ]; then
        export STM32CUBE_PROGRAMMER=$(dirname "$CUBE_PROG")
    else
        export STM32CUBE_PROGRAMMER=""
    fi
fi

# -----------------------------------------------------------------------------------------------
# VS Code
# ------------------------------------------------------------------------------------------------
# Find VS Code/Cursor in common Linux locations
if command -v code &> /dev/null; then
    CODE_PATH=$(which code)
    CODE_DIR=$(dirname "$CODE_PATH")
    export VSCODE_DIR="$CODE_DIR"
elif [ -f "/usr/bin/code" ]; then
    export VSCODE_DIR="/usr/bin"
elif [ -f "/usr/local/bin/code" ]; then
    export VSCODE_DIR="/usr/local/bin"
elif [ -d "/opt/visual-studio-code" ]; then
    export VSCODE_DIR="/opt/visual-studio-code"
else
    # Fallback - VS Code might be in user's home directory
    export VSCODE_DIR="$HOME/.local/bin"
fi

# Print configuration summary
echo "=========================================="
echo "Development Environment Configuration"
echo "=========================================="
echo "Project Name: $NAME_PROJECT"
echo "Build Directory: $BUILD_DIR"
echo "CMake: $TOOLCHAIN_CMAKE"
echo "Ninja: $TOOLCHAIN_NINJA"
echo "ARM Toolchain: $ARM_TOOLCHAIN_PATH"
echo "ST-Link: $TOOLCHAIN_ST_LINK"
echo "STM32CubeProgrammer: ${STM32CUBE_PROGRAMMER:-Not found}"
echo "VS Code: $VSCODE_DIR"
echo "=========================================="

