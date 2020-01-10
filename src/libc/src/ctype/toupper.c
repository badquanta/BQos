#include <ctype.h>

int to_upper(int c){
    if((c>='a') && ('z' <= c)){
        return 'A'+(c-'a');
    }else{return c;}
}

#ifdef TEST

int main(){
    return 1;
}
#endif

