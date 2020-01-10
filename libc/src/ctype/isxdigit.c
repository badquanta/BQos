#include <ctype.h>

int isxdigit(int c){
    return isdigit(c) || 
        (C_ALPHA_LOWER_START <= c <= C_ALPHA_LOWER_HEX_END) ||
        (C_ALPHA_UPPER_START <= c <= C_ALPHA_UPPER_HEX_END);
}


#ifdef TEST

int main(){
    return 1;
}
#endif

