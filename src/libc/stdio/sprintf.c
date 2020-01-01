#include <string.h>
#include <stdarg.h>
#include <limits.h>
/**
 * build a string from `aFormat` storing the result into `aBuffer`.
 * @note `aBuffer` is assumed to be large enough.
 **/

int sprintf(char *aBuffer, const char* aFormat, ...){
  return snprintf(aBuffer, INT_MAX, aFormat);
};
