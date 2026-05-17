#!/bin/bash
# Fix ST-Link USB access on Arch/Manjaro when st-util reports errno=13.
# Run once: bash config/fix-stlink-permissions.sh

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Re-running with sudo..."
    exec sudo bash "$0" "$@"
fi

# plugdev is required by /usr/lib/udev/rules.d/49-stlinkv2-*.rules
if ! getent group plugdev >/dev/null; then
    groupadd -r plugdev
    echo "Created system group plugdev"
fi

if id -nG "${SUDO_USER:-$USER}" 2>/dev/null | tr ' ' '\n' | grep -qx plugdev; then
    echo "User already in plugdev"
else
    usermod -aG plugdev "${SUDO_USER:-$USER}"
    echo "Added ${SUDO_USER:-$USER} to plugdev (log out/in if debug still fails)"
fi

udevadm control --reload-rules
udevadm trigger --subsystem-match=usb

echo ""
echo "Done. Now:"
echo "  1. Unplug the Nucleo/board USB cable"
echo "  2. Wait 2 seconds, plug it back in"
echo "  3. Run: ls -la /dev/bus/usb/*/*   (find ST-Link; group should be plugdev)"
echo "  4. Run: st-util -p 50000 --no-reset"
echo "  5. Start Cortex-Debug (F5)"
