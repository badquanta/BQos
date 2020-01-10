#include <ctype.h>


int isprint(int c){
    return (C_SPACE <= c <= C_PUNCT4_END);
}

#ifdef TEST

int main(){
    return 1;
}
#endif

