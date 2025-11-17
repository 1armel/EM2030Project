#!/bin/bash
# Wrapper script for st-util that filters out Windows-specific -cp flag
# Cortex-Debug adds -cp flag for STM32CubeProgrammer which doesn't exist on Linux
# This script removes that flag so st-util works properly

# Filter out -cp and its argument
FILTERED_ARGS=()
SKIP_NEXT=false

for arg in "$@"; do
    if [ "$SKIP_NEXT" = true ]; then
        SKIP_NEXT=false
        continue
    fi
    
    if [ "$arg" = "-cp" ]; then
        SKIP_NEXT=true
        continue
    fi
    
    FILTERED_ARGS+=("$arg")
done

# Call the real st-util with filtered arguments
exec /usr/bin/st-util "${FILTERED_ARGS[@]}"

