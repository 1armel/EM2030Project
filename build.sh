#!/bin/bash

# Absolute path of the build directory
BUILD_DIR="build"

# Remove the build directory if it exists
if [ -d "$BUILD_DIR" ]; then
  echo "Removing existing build directory..."
  rm -rf "$BUILD_DIR"
fi

# Recreate the build directory
mkdir "$BUILD_DIR"

# Configure the project
cmake -S . -B "$BUILD_DIR" -G Ninja

# Build the project
cmake --build "$BUILD_DIR" --config Debug
