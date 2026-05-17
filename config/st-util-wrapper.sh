#!/bin/bash
# Fallback wrapper if launch.json uses servertype "stlink" (Windows GDB server).
# Prefer servertype "stutil" in launch.json so Cortex-Debug talks to st-util directly.
# st-util does not accept: -cp, --swd, --halt (those are for STM32CubeProgrammer).

FILTERED_ARGS=()
SKIP_NEXT=false

for arg in "$@"; do
    if [ "$SKIP_NEXT" = true ]; then
        SKIP_NEXT=false
        continue
    fi
    case "$arg" in
        -cp|--swd|--halt)
            [ "$arg" = "-cp" ] && SKIP_NEXT=true
            continue
            ;;
    esac
    FILTERED_ARGS+=("$arg")
done

exec /usr/bin/st-util "${FILTERED_ARGS[@]}"

