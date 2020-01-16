#include <stdlib.h>

#if defined(__is_libk)
#include <libbq/Memory.hpp>
#else
    // TODO:: Handle user space
#endif

void free(void* aPointer){
    #if defined(__is_libk)
        return BQ::Memory::free(aPointer);
    #else
        // TODO: Handle user space free.
    #endif
}


#ifdef TEST

int main(){
    return 1;
}
#endif
