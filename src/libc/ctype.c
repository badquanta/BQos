#include <libc/ctype.h>


int iscntrl(int c){
    return (C_NUL<=c<=C_LASTCONTROLCODE) || (c==C_DEL);
}

int isblank(int c){
    return (c==C_TAB)||(c==C_SPACE);
}

int isspace(int c){
    return (C_TAB<=c<=C_RL)||(c==C_SPACE);
}

int isupper(int c){
    return (C_ALPHA_UPPER_START <= c <=C_ALPHA_UPPER_END);
}

int islower(int c){
    return (C_ALPHA_LOWER_START <= c <= C_ALPHA_LOWER_END);
}

int isalpha(int c){
    return isupper(c)||islower(c);
}

int isdigit(int c){
    return (C_DIGIT_START <= c <= C_DIGIT_END);
}

int isxdigit(int c){
    return isdigit(c) || 
        (C_ALPHA_LOWER_START <= c <= C_ALPHA_LOWER_HEX_END) ||
        (C_ALPHA_UPPER_START <= c <= C_ALPHA_UPPER_HEX_END);
}

int isalnum(int c){
    return isdigit(c) || isalpha(c);
}

int ispunct(int c){
    return
        (C_PUNCT1_START <= c <= C_PUNCT1_END) ||   
        (C_PUNCT2_START <= c <= C_PUNCT2_END) ||
        (C_PUNCT3_START <= c <= C_PUNCT3_END) ||
        (C_PUNCT4_START <= c <= C_PUNCT4_END);
}

int isgraph(int c){
    return (C_PUNCT1_START <= c <= C_PUNCT4_END);
}

int isprint(int c){
    return (C_SPACE <= c <= C_PUNCT4_END);
}