#include <stdlib.h>

#if defined(__is_libk)
#include <libbq/Memory.hpp>
#else
    // TODO:: Handle user space
#endif

void* malloc(size_t aSize){
    #if defined(__is_libk)
        return BQ::Memory::malloc(aSize);
    #else
        // TODO: Handle user space malloc.
    #endif
}


#ifdef TEST

int main(){
    return 1;
}
#endif
