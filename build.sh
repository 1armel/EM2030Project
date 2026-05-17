#!/bin/bash
# Build from the terminal. Default: incremental build (keeps CMake Tools cache).
# Use: ./build.sh --clean   to wipe build/ and reconfigure from scratch.

set -e
BUILD_DIR="build"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [ "${1:-}" = "--clean" ]; then
  echo "Removing existing build directory..."
  rm -rf "$BUILD_DIR"
fi

mkdir -p "$BUILD_DIR"

# CMake Tools expects this File API query (same as vscode-cmake-tools extension)
QUERY_DIR="$BUILD_DIR/.cmake/api/v1/query/client-vscode"
mkdir -p "$QUERY_DIR"
cat > "$QUERY_DIR/query.json" << 'EOF'
{
  "requests": [
    { "kind": "cache", "version": 2 },
    { "kind": "codemodel", "version": 2 },
    { "kind": "toolchains", "version": 1 },
    { "kind": "cmakeFiles", "version": 1 }
  ]
}
EOF

cmake -S . -B "$BUILD_DIR" -G Ninja
cmake --build "$BUILD_DIR" --config Debug
