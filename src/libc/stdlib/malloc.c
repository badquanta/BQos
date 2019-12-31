#include <stdlib.h>

#if defined(__is_libk)
#include <BQos/Memory.hpp>
#else
    // TODO:: Handle user space
#endif

void* malloc(size_t aSize){
    #if defined(__is_libk)
        return Memory::malloc(aSize);
    #else
        // TODO: Handle user space malloc.
    #endif
}