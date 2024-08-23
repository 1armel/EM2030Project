
cmake_minimum_required(VERSION 3.15.3)

# Optional: print out extra messages to see what is going on. Comment it to have less verbose messages
set(CMAKE_VERBOSE_MAKEFILE ON)

# Path to toolchain file. This one has to be before 'project()' below
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/CMakeTools/arm-none-eabi-gcc.cmake)

# Specify the linker file path
set(LINKER_FILE "C:/STM32F429/Driver/STM32F429/Linker/STM32F429ZITx_FLASH.ld")

# Setup project, output, and linker file
# Replace the environment variable usage with a fallback option
project(PROJECT_V001 LANGUAGES C CXX ASM)

# Include additional CMake configurations
include(${CMAKE_SOURCE_DIR}/CMakeTools/STM32F429.cmake)
