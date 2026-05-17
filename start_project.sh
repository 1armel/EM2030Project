#!/bin/bash

# ///////////////////////////////////////
# /// file start_project.sh
# /// copyright TonkaIn
# /// brief start Visual Studio Code/Cursor with the sourced development environment 

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the development environment 
source "${SCRIPT_DIR}/config/set_env.sh"
source "${SCRIPT_DIR}/config/create_config_files.sh"

# Start VS Code/Cursor with the project folder
if command -v code &> /dev/null; then
    echo "Starting VS Code..."
    code "${SCRIPT_DIR}"
elif command -v cursor &> /dev/null; then
    echo "Starting Cursor..."
    cursor "${SCRIPT_DIR}"
else
    echo "Error: Neither 'code' nor 'cursor' command found in PATH"
    echo "Please install VS Code or Cursor, or add it to your PATH"
    exit 1
fi

