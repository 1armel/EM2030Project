set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

# Try to find ARM toolchain in PATH first (Linux package manager installation)
find_program(ARM_GCC arm-none-eabi-gcc)
if(ARM_GCC)
    # Toolchain found in PATH, extract directory
    get_filename_component(ARM_TOOLCHAIN_DIR ${ARM_GCC} DIRECTORY)
    set(BINUTILS_PATH ${ARM_TOOLCHAIN_DIR})
    set(TOOLCHAIN_PREFIX "arm-none-eabi-")
else()
    # Fallback: try common Linux installation paths
    set(ARM_TOOLCHAIN_DIR "/usr/bin")
    set(BINUTILS_PATH ${ARM_TOOLCHAIN_DIR})
    set(TOOLCHAIN_PREFIX "${ARM_TOOLCHAIN_DIR}/arm-none-eabi-")
endif()

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Set compilers (no .exe extension on Linux)
if(ARM_GCC)
    set(CMAKE_C_COMPILER "arm-none-eabi-gcc")
    set(CMAKE_ASM_COMPILER "arm-none-eabi-gcc")
    set(CMAKE_CXX_COMPILER "arm-none-eabi-g++")
else()
    set(CMAKE_C_COMPILER "${TOOLCHAIN_PREFIX}gcc")
    set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
    set(CMAKE_CXX_COMPILER "${TOOLCHAIN_PREFIX}g++")
endif()

# Set utilities
if(ARM_GCC)
    set(CMAKE_OBJCOPY "arm-none-eabi-objcopy" CACHE INTERNAL "objcopy tool")
    set(CMAKE_SIZE_UTIL "arm-none-eabi-size" CACHE INTERNAL "size tool")
else()
    set(CMAKE_OBJCOPY "${TOOLCHAIN_PREFIX}objcopy" CACHE INTERNAL "objcopy tool")
    set(CMAKE_SIZE_UTIL "${TOOLCHAIN_PREFIX}size" CACHE INTERNAL "size tool")
endif()

# Define linker flags and specify the linker script (adjust if needed)
# set(CMAKE_EXE_LINKER_FLAGS "-T${CMAKE_SOURCE_DIR}/Driver/STM32F429/Linker/STM32F429.ld")
# "C:/STM32F429/Driver/STM32F429/Linker/STM32F429ZITx_FLASH.ld"

set(CMAKE_FIND_ROOT_PATH ${BINUTILS_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)




# Set the target system
# set(CMAKE_SYSTEM_NAME Generic)
# set(CMAKE_SYSTEM_PROCESSOR ARM)

# # Set the path to the ARM GCC toolchain
# set(ARM_TOOLCHAIN_DIR "C:/Program Files (x86)/GNU Arm Embedded Toolchain/10 2021.10/bin")
# set(BINUTILS_PATH ${ARM_TOOLCHAIN_DIR})

# # Define the toolchain prefix for convenience
# set(TOOLCHAIN_PREFIX ${ARM_TOOLCHAIN_DIR}/arm-none-eabi-)

# # Specify the compiler
# set(CMAKE_C_COMPILER "${TOOLCHAIN_PREFIX}gcc.exe")
# set(CMAKE_CXX_COMPILER "${TOOLCHAIN_PREFIX}g++.exe")
# set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})

# # Set utilities for binary manipulation
# set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy CACHE INTERNAL "objcopy tool")
# set(CMAKE_SIZE_UTIL ${TOOLCHAIN_PREFIX}size CACHE INTERNAL "size tool")

# # Ensure that CMake tries to compile using a static library
# set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# # Define linker flags and specify the linker script (adjust the path if needed)
# set(CMAKE_EXE_LINKER_FLAGS "-T${CMAKE_SOURCE_DIR}/STM32F429.ld")

# # Tell CMake where to look for libraries and includes
# set(CMAKE_FIND_ROOT_PATH ${BINUTILS_PATH})
# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
