#include <ctype.h>
int isgraph(int c){
    return (C_PUNCT1_START <= c <= C_PUNCT4_END);
}