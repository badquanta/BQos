/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#include <stdio.h>
#if defined(__is_libk)
#include <BQos/hardware.hpp>
#else
    /** @todo handle user-space **/
#endif

int putchar(int ic){
    #if defined(__is_libk)
#warning Compling putchar for LIBK
        char c = (char)ic;
        BQos::hardware* active = BQos::hardware::get_active();
        if(active!=NULL){
        	BQ::a_tty* tty = active->tty(0);
            if(tty!=NULL){
                tty->put(c);
            }
        }
    #else
#warning Compling putchar for LIBC    
        /** @todo Implement stdio for user space via syscall. **/
    #endif
    return ic;    
}


#ifdef TEST

int main(){
    return 1;
}
#endif

