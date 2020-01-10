/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#include <string.h>

size_t strlen(const char* str){
    size_t len=0;
    while(str[len]!=0)
    {
        len++;
    }
    return len;
}


#ifdef TEST

int main(){
    return 1;
}
#endif