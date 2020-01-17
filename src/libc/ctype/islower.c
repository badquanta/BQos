#include <ctype.h>
int islower(int c){
    return (C_ALPHA_LOWER_START <= c) && (c <= C_ALPHA_LOWER_END);
}


#ifdef TEST

int main(){
    return 1;
}
#endif

