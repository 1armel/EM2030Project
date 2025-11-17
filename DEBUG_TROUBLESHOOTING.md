# Debugging Troubleshooting Guide

## Common Issues and Solutions

### 1. Missing arm-none-eabi-gdb

**Error**: `arm-none-eabi-gdb: command not found`

**Solution**:
```bash
sudo pacman -S arm-none-eabi-gdb
```

Verify installation:
```bash
arm-none-eabi-gdb --version
```

### 2. USB Permissions for ST-Link

**Error**: `Error: unable to open stlink device` or permission denied

**Solution**: Add your user to the `uucp` group (for Arch/Manjaro):
```bash
sudo usermod -a -G uucp $USER
```

Then log out and log back in (or restart) for the changes to take effect.

Verify your ST-Link device is detected:
```bash
lsusb | grep -i stm
# Should show: Bus XXX Device XXX: ID 0483:374b STMicroelectronics ST-LINK/V2.1
```

### 3. ST-Link Server Not Starting

**Error**: `st-util: command not found` or connection timeout

**Solution**: Install stlink tools:
```bash
sudo pacman -S stlink
```

Test st-util manually:
```bash
st-util
# Should show: st-util 1.x.x
# Listening at *:4242...
```

Press Ctrl+C to stop it.

### 4. VS Code Cortex-Debug Extension

**Error**: Debug configuration not working

**Solution**: Install the Cortex-Debug extension in VS Code/Cursor:
1. Open Extensions (Ctrl+Shift+X)
2. Search for "Cortex-Debug"
3. Install "Cortex-Debug" by marus25

### 5. Executable Not Found

**Error**: `executable: ${workspaceFolder}/build/PROJECT_V001.elf not found`

**Solution**: Build the project first:
```bash
./build.sh
# or
cd build && cmake .. -G Ninja && ninja
```

Verify the .elf file exists:
```bash
ls -lh build/PROJECT_V001.elf
```

### 6. Device Not Responding

**Error**: `Error: unable to find stlink device` or timeout

**Troubleshooting steps**:
1. Check USB connection - try a different USB port
2. Verify device is powered on
3. Check if another process is using the ST-Link:
   ```bash
   # Check if st-util is already running
   ps aux | grep st-util
   # Kill it if needed
   pkill st-util
   ```
4. Try resetting the ST-Link by unplugging and replugging

### 7. GDB Connection Issues

**Error**: GDB cannot connect to target

**Solution**: 
1. Make sure `st-util` is not running manually (Cortex-Debug will start it)
2. Check that the device is in the correct mode (SWD, not JTAG)
3. Verify the interface setting in launch.json is `"interface": "swd"`

### 8. SVD File Not Found

**Error**: SVD file warnings (non-critical, but register view won't work)

**Solution**: The SVD file should be at:
```
${workspaceFolder}/Driver/STM32F429/STM32F429.svd
```

Verify it exists:
```bash
ls -lh Driver/STM32F429/STM32F429.svd
```

## Quick Debug Checklist

Before debugging, verify:

- [ ] `arm-none-eabi-gdb` is installed and in PATH
- [ ] `stlink` package is installed
- [ ] User is in `uucp` group (check with `groups`)
- [ ] ST-Link device is detected (`lsusb | grep STM`)
- [ ] Project is built (`build/PROJECT_V001.elf` exists)
- [ ] Cortex-Debug extension is installed in VS Code/Cursor
- [ ] No other `st-util` process is running

## Testing ST-Link Connection Manually

To test if ST-Link works outside of VS Code:

```bash
# Start st-util in one terminal
st-util

# In another terminal, connect with GDB
arm-none-eabi-gdb build/PROJECT_V001.elf
(gdb) target extended-remote :4242
(gdb) monitor reset halt
(gdb) load
(gdb) continue
```

If this works, the issue is likely with VS Code configuration.
If this doesn't work, the issue is with hardware/USB permissions.

## Getting Help

If you're still having issues:

1. Check the VS Code Debug Console for detailed error messages
2. Check the Output panel → "Cortex-Debug" for logs
3. Try running `st-util` manually to see if it can connect
4. Verify all prerequisites are installed (see SETUP_LINUX.md)


