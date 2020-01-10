/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#include <string.h>

int memcmp(const void* aptr, const void *bptr, size_t size){
    const unsigned char* a =(const unsigned char*)aptr;
    const unsigned char* b =(const unsigned char*)bptr;
    for(size_t i=0;i<size;i++){
        if(a[i]<b[i]){
            return -1;
        }else if(b[i]<a[i]){
            return 1;
        }
    }
    return 0;
}



#ifdef TEST

int main(){
    return 1;
}
#endif