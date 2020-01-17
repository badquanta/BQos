#include <ctype.h>

int ispunct(int c){
    return
        ((C_PUNCT1_START <= c) && (c <= C_PUNCT1_END)) ||
        ((C_PUNCT2_START <= c) && (c <= C_PUNCT2_END)) ||
        ((C_PUNCT3_START <= c) && (c <= C_PUNCT3_END)) ||
        ((C_PUNCT4_START <= c) && (c <= C_PUNCT4_END));
}



#ifdef TEST

int main(){
    return 1;
}
#endif

