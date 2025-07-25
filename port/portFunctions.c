#include <stddef.h>
void *memset(void *dest, int c, size_t count) {
    // Cast the destination pointer to an unsigned char pointer
    // This allows byte-level manipulation of the memory
    unsigned char *ptr = (unsigned char *)dest;

    // Convert the integer 'c' to an unsigned char
    // Only the low-order byte of 'c' is used
    unsigned char value = (unsigned char)c;

    // Loop through 'count' bytes
    for (size_t i = 0; i < count; i++) {
        // Assign the 'value' to each byte in the memory block
        ptr[i] = value;
    }

    // Return the original destination pointer
    return dest;
}