#include <sys/stat.h>
#include <sys/types.h>
#include <errno.h>

// Redirect standard output to a UART or other interface if needed
int _write(int file, char *ptr, int len) {
    // Example: Send data to UART (replace with your hardware-specific code)
    // for (int i = 0; i < len; i++) {
    //     UART_SendChar(ptr[i]);
    // }
    return len; // Return the number of bytes written
}

int _read(int file, char *ptr, int len) {
    // Example: Read data from UART (replace with your hardware-specific code)
    // for (int i = 0; i < len; i++) {
    //     ptr[i] = UART_ReceiveChar();
    // }
    return 0; // Return the number of bytes read
}

int _close(int file) {
    return -1; // Not implemented
}

int _lseek(int file, int ptr, int dir) {
    return -1; // Not implemented
}

int _fstat(int file, struct stat *st) {
    st->st_mode = S_IFCHR; // Indicate that this is a character device
    return 0;
}

int _isatty(int file) {
    return 1; // Indicate that the file descriptor is a terminal
}

int _getpid(void) {
    return 1; // Return a dummy process ID
}

int _kill(int pid, int sig) {
    errno = EINVAL; // Indicate an invalid operation
    return -1;
}