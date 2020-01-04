#include <string.h>
/***
 * @link http://www.cplusplus.com/reference/cstring/strcpy/
 * Copy the C string in aSource to aDestination.
 **/
char* strcpy(char*aDestination, const char *aSource){
    size_t length = strlen(aSource);
    memcpy(aDestination,aSource,length);
    return aDestination;
}