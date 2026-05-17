cmake_minimum_required(VERSION 3.15)
project(em2030_pin_tests LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(ENABLE_COVERAGE "Instrument tests for gcov/lcov coverage reports" OFF)

if(ENABLE_COVERAGE)
    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        add_compile_options(--coverage -O0 -g)
        add_link_options(--coverage)
    else()
        message(WARNING "ENABLE_COVERAGE is not supported for ${CMAKE_CXX_COMPILER_ID}")
    endif()
endif()

include(FetchContent)
FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG v1.15.2
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

enable_testing()

add_executable(pin_tests
    test_pin.cpp
    mocks/stm32_gpio_mock.cpp
    ${CMAKE_SOURCE_DIR}/../Driver/STM32F429/Src/Pin.cpp
)

target_include_directories(pin_tests PRIVATE
    ${CMAKE_SOURCE_DIR}/include
    ${CMAKE_SOURCE_DIR}/mocks
    ${CMAKE_SOURCE_DIR}/../Driver/STM32F429/Inc
)

target_compile_definitions(pin_tests PRIVATE HOST_UNIT_TEST)

target_link_libraries(pin_tests PRIVATE GTest::gtest GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(pin_tests)
