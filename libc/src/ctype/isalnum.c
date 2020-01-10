#include <ctype.h>
int isalnum(int c){
    return isdigit(c) || isalpha(c);
}


#ifdef TEST

int main(){
    return 1;
}
#endif

