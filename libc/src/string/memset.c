/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#include <string.h>
/**TODO: won't value be truncated? Should it be declared uint8_t or int8_t?**/
void *memset(void *bufptr, int value, size_t size){
    unsigned char* buf=(unsigned char*)bufptr;
    for(size_t i=0;i<size;i++){
        buf[i]=(unsigned char)value;
    }
    return bufptr;
}


#ifdef TEST

int main(){
    return 1;
}
#endif