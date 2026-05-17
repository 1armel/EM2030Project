#!/bin/bash

# -----------------------------------------------------------------------------------------------
# creation of cmake-variants.json and settings.json files. NO EDIT THIS SECTION
# ------------------------------------------------------------------------------------------------

# Source the environment variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/set_env.sh"

# Ensure .vscode directory exists
mkdir -p "${BUILD_DIR}/.vscode"

# Create cmake-variants.json
cat > "${BUILD_DIR}/.vscode/cmake-variants.json" << EOF
{
  "NAME_PROJECT": {
    "default": "${NAME_PROJECT}",
    "choices": {
      "${NAME_PROJECT}": {
        "short": "${NAME_PROJECT}",
        "long": "${NAME_PROJECT}",
        "settings": {
          "NAME_PROJECT": "${NAME_PROJECT}"
        }
      }
    }
  },
  "buildType": {
    "default": "Debug",
    "choices": {
      "Release": {
        "short": "Release",
        "long": "Release",
        "buildType": "Release"
      },
      "Debug": {
        "short": "Debug",
        "long": "Debug",
        "buildType": "Debug"
      }
    }
  }
}
EOF

# Create settings.json
cat > "${BUILD_DIR}/.vscode/settings.json" << EOF
{
  "files.autoGuessEncoding": true,
  "cmake.configureOnOpen": true,
  "cmake.buildDirectory": "\${workspaceFolder}/build",
  "cmake.generator": "Ninja",
  "cmake.cmakePath": "${TOOLCHAIN_CMAKE}/cmake",
  "cmake.configureSettings": {
    "CMAKE_MAKE_PROGRAM": "${TOOLCHAIN_NINJA}/ninja"
  },
  "cmake.preferredGenerators": [
    "Ninja"
  ]
}
EOF

echo "VS Code configuration files created successfully!"
echo "  - .vscode/cmake-variants.json"
echo "  - .vscode/settings.json"

