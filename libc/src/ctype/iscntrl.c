#include <ctype.h>


int iscntrl(int c){
    return (C_NUL<=c<=C_LASTCONTROLCODE) || (c==C_DEL);
}