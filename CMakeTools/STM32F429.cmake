# set(EXECUTABLE ${PROJECT_NAME}.elf)

# set(LINKER_FILE_DIR ${CMAKE_SOURCE_DIR}/Driver/STM32F429/Linker)
# set(LINKER_FILE ${LINKER_FILE_DIR}/STM32F429ZITx_FLASH.ld)

# enable_language(C CXX ASM)
# set(CMAKE_C_STANDARD 99)
# set(CMAKE_C_STANDARD_REQUIRED ON)
# set(CMAKE_C_EXTENSIONS OFF)

# message("compilater is: ${CMAKE_C_COMPILER}")

# # Optional: issue a message to be sure it uses the correct toolchain file.
# message(STATUS "CMAKE_TOOLCHAIN_FILE is: ${CMAKE_TOOLCHAIN_FILE}")

# # List of source files
# file(GLOB SRC_FILES
#         "Src/*.c"
#         "Src/*.cpp"
#         Driver/STM32F429/Src/startup_stm32f429xx.s
#         "Driver/STM32F429/Src/*.c"
#         "Driver/STM32F429/Src/*.cpp"
# )

# # Build the executable based on the source files
# add_executable(${EXECUTABLE} ${SRC_FILES})

# # List of compiler defines, prefix with -D compiler option
# target_compile_definitions(${EXECUTABLE} PRIVATE
#             -DSTM32F429xx 
#             -DUSE_FULL_LL_DRIVER 
#         #     -DHSE_VALUE=8000000U
#         )

# # List of includ directories
# target_include_directories(${EXECUTABLE} PRIVATE
#         Inc 
#         Driver/CMSIS
#         Driver/STM32F429/Inc
#         )

# # Compiler options
# target_compile_options(${EXECUTABLE} PRIVATE
#         -mcpu=cortex-m4 
#         -g3 
#         -DSTM32F429xx 
#         -DUSE_FULL_LL_DRIVER 
#         -DHSE_VALUE=8000000U 
#         -Os 
#         -ffunction-sections 
#         -Wall 
#         -Wno-strict-aliasing 
#         -fstack-usage 
#         --specs=nano.specs 
#         -mfpu=fpv4-sp-d16 
#         -mfloat-abi=hard 
#         -mthumb
#         )
# set_source_files_properties(
#     Driver/STM32F429/Src/startup_stm32f429xx.s
#     PROPERTIES COMPILE_FLAGS "-mcpu=cortex-m4 -g3 -c -x assembler-with-cpp"
# )

# # Specify the MCU you are targeting (e.g., STM32F429)
# set(CMAKE_C_FLAGS "-mcpu=cortex-m4 -mthumb")
# set(CMAKE_CXX_FLAGS "-mcpu=cortex-m4 -mthumb")


# # Linker options
# target_link_options(${EXECUTABLE} PRIVATE
 
# #-Wl,-Map="NUCLEO-F413ZH.map" 


#         # -mcpu=cortex-m4 
#         # -T${LINKER_FILE} 
#         # --specs=nosys.specs 
#         # -Wl,--gc-sections 
#         # -static 
#         # --specs=nano.specs 
#         # -mfpu=fpv4-sp-d16 
#         # -mfloat-abi=hard 
#         # -mthumb 
#         # -Wl,--start-group -lc -lm -Wl,--end-group
#         -T${LINKER_FILE}  # Specify the linker script first
#         --specs=nosys.specs 
#         -Wl,--gc-sections 
#         -static 
#         --specs=nano.specs 
#         -mcpu=cortex-m4 
#         -mfpu=fpv4-sp-d16 
#         -mfloat-abi=hard 
#         -mthumb 
#         -Wl,--start-group -lc -lm -Wl,--end-group
#         )

#  #Optional: Print executable size as part of the post build process
#                 add_custom_command(TARGET ${EXECUTABLE}
#                         POST_BUILD
#                         COMMAND ${CMAKE_SIZE_UTIL} ${EXECUTABLE})

#  #Optional: Create hex, bin and S-Record files after the build
#                 add_custom_command(TARGET ${EXECUTABLE}
#                         POST_BUILD
#         #COMMAND ${CMAKE_OBJCOPY} -O srec --srec-len=64 ${EXECUTABLE} ${PROJECT_NAME}.s19
#                         COMMAND ${CMAKE_OBJCOPY} -O srec  ${EXECUTABLE} ${PROJECT_NAME}.srec
#                         COMMAND ${CMAKE_OBJCOPY} -O ihex ${EXECUTABLE} ${PROJECT_NAME}.hex
#                         COMMAND ${CMAKE_OBJCOPY} -O binary ${EXECUTABLE} ${PROJECT_NAME}.bin)






set(EXECUTABLE ${PROJECT_NAME}.elf)

set(LINKER_FILE_DIR ${CMAKE_SOURCE_DIR}/Driver/STM32F429/Linker)
set(LINKER_FILE ${LINKER_FILE_DIR}/STM32F429ZITx_FLASH.ld)

enable_language(C CXX ASM)
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

message("Compiler is: ${CMAKE_C_COMPILER}")
message(STATUS "CMAKE_TOOLCHAIN_FILE is: ${CMAKE_TOOLCHAIN_FILE}")

# List of source files
file(GLOB SRC_FILES
    "Src/*.c"
    "Src/*.cpp"
    Driver/STM32F429/Src/startup_stm32f429xx.s
    "Driver/STM32F429/Src/*.c"
    "Driver/STM32F429/Src/*.cpp"
)

# Build the executable
add_executable(${EXECUTABLE} ${SRC_FILES})

# Compiler defines
target_compile_definitions(${EXECUTABLE} PRIVATE
    -DSTM32F429xx 
    -DUSE_FULL_LL_DRIVER 
)

# Include directories
target_include_directories(${EXECUTABLE} PRIVATE
    Inc 
    Driver/CMSIS
    Driver/STM32F429/Inc
)

# Compiler options
target_compile_options(${EXECUTABLE} PRIVATE
    -mcpu=cortex-m4 
    -g3 
    -DSTM32F429xx 
    -DUSE_FULL_LL_DRIVER 
    -DHSE_VALUE=8000000U 
    -Os 
    -ffunction-sections 
    -Wall 
    -Wno-strict-aliasing 
    -fstack-usage 
    --specs=nano.specs 
    -mfpu=fpv4-sp-d16 
    -mfloat-abi=hard 
    -mthumb
)

set_source_files_properties(
    Driver/STM32F429/Src/startup_stm32f429xx.s
    PROPERTIES COMPILE_FLAGS "-mcpu=cortex-m4 -g3 -c -x assembler-with-cpp"
)

# Linker options
target_link_options(${EXECUTABLE} PRIVATE
    -T${LINKER_FILE} 
    --specs=nosys.specs 
    -Wl,--gc-sections 
    -static 
    --specs=nano.specs 
    -mcpu=cortex-m4 
    -mfpu=fpv4-sp-d16 
    -mfloat-abi=hard 
    -mthumb 
    -Wl,--start-group -lc -lm -Wl,--end-group
)

# Optional: Print executable size after the build
add_custom_command(TARGET ${EXECUTABLE}
    POST_BUILD
    COMMAND ${CMAKE_SIZE_UTIL} ${EXECUTABLE}
)

# Optional: Create hex, bin, and S-Record files after the build
add_custom_command(TARGET ${EXECUTABLE}
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O srec ${EXECUTABLE} ${PROJECT_NAME}.srec
    COMMAND ${CMAKE_OBJCOPY} -O ihex ${EXECUTABLE} ${PROJECT_NAME}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary ${EXECUTABLE} ${PROJECT_NAME}.bin
)
