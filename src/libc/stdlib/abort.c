/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#include <stdio.h>
#include <stdlib.h>

__attribute__((__noreturn__))
void abort(void){
    #if defined(__is_libk)
    //TODO:: Add proper kernel panic.
    printf("kernel: panic: abourt()");
    #else
    //TODO: Use SIGABRT
    printf("abort(TODO:SYSABRT);\n");
    #endif
    while(1){
        // Do nothing, never return.
    }
    __builtin_unreachable();
}