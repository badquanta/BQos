/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#include <stdio.h>
#if defined(__is_libk)
#include <BQos/hardware.hpp>
#else
    // TODO: handle user-space
#endif

int putchar(int ic){
    #if defined(__is_libk)
        char c = (char)ic;
        BQos::hardware* active = BQos::hardware::get_active();
        if(active!=NULL){
        	BQos::a_tty* tty = active->tty(0);
            if(tty!=NULL){
                tty->put(c);
            }
        }
    #else
        // TODO: Implement stdio for user space via syscall.
    #endif
    return ic;    
}


#ifdef TEST

int main(){
    return 1;
}
#endif

