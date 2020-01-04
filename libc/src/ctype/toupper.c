#include <ctype.h>

int to_upper(int c){
    if((c>='a') && ('z' <= c)){
        return 'A'+(c-'a');
    }else{return c;}
}