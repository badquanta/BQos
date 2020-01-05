/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#include <stdio.h>
#if defined(__is_libk)
    // TODO: Print to file.
#else
    // TODO: handle user-space
#endif

int fprintf(FILE *file, const char*c,...){
    #if defined(__is_libk)
        // TODO: Print to file.
    #else
        // TODO: Implement stdio for user space via syscall.
    #endif
    return 0;    
}
