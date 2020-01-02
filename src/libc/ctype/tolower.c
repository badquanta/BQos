#include <ctype.h>

int to_upper(int c){
    if((c>='A') && ('Z' <= c)){
        return 'a'+(c-'A');
    }else{return c;}
}