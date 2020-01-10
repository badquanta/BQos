#include <ctype.h>


int isalpha(int c){
    return isupper(c)||islower(c);
}


#ifdef TEST

int main(){
    return 1;
}
#endif

