#include <string.h>
/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
void *memcpy(void *dstptr, const void* srcptr, size_t size){
    unsigned char* dst = (unsigned char*) dstptr;
    const unsigned char* src = (const unsigned char*) srcptr;
    for(size_t i= 0;i<size;i++){
        dst[i]=src[i];        
    }
    return dstptr;
}


#ifdef TEST

int main(){
    return 1;
}
#endif