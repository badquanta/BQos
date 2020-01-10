/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#include <stdio.h>

int puts(const char* string){
    return printf("%s\n",string);
}


#ifdef TEST

int main(){
    return 1;
}
#endif
