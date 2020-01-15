#include <ctype.h>


int isblank(int c){
    return (c==C_TAB)||(c==C_SPACE);
}


#ifdef TEST

int main(){
    return 1;
}
#endif

