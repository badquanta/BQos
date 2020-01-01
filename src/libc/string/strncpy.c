#include <string.h>
/***
 * @link http://www.cplusplus.com/reference/cstring/strvcpy/
 * Copy the C string in aSource to aDestination; specifying a length.
 **/
char* strncpy(char*aDestination, const char *aSource, size_t aLength){    
    memcpy(aDestination,aSource,aLength);
    return aDestination;
}