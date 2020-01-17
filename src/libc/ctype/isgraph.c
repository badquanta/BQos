#include <ctype.h>
int isgraph(int c){
    return (C_PUNCT1_START <= c) && (c <= C_PUNCT4_END);
}


#ifdef TEST

int main(){
    return 1;
}
#endif

