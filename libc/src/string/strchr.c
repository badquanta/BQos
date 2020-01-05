#include <string.h>
//const char * strchr ( const char *aString, int aCharacter){
//    char* pointer = aString;
//    return strchr(pointer, aCharacter);
//}

char * strchr (const char *aString, int aCharacter){
    char* pointer = aString;
    while(*pointer!=aCharacter&&*pointer!='\0'){
        ++pointer;
    }
    if(*pointer==aCharacter){
        return pointer;
    } else {
        return NULL;
    }
}
