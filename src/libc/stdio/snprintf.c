#include <string.h>
#include <string.h>
#include <stdarg.h>
#include <limits.h>
/**
 * @link http://www.cplusplus.com/reference/cstdio/snprintf/
 * build a string from `aFormat` storing the result into `aBuffer`.
 * @note `aBuffer` is assumed to be large enough to hold aNumBytes.
 * @returns number of bytes actually written.
 *
 **/
int snprintf(char *aBuffer, size_t aNumBytes, char *aFormat, ...){
  // access the variable length parameters.
  va_list parameters;
  va_start(parameters, aFormat);
  // keep track of number of bytes actually written.
  int written = 0;
  // keep track of where in the buffer we are writing.
  char *bufferPointer = aBuffer;
  // while the format hasn't ended.
  while(*aFormat!='\0'){
    size_t maxrem = aNumBytes - written;
    // are we at a formatting token?
    if(aFormat[0]!='%'||aFormat[1]=='%'){//Not yet?
      if(aFormat[0]=='%'){
        aFormat++;
      }
      size_t amount = 1;
      while(aFormat[amount]&&aFormat[amount]!='%'){
        amount++;
      }
      if(maxrem<amount){
        //TODO: Error EOVERFLOW
        return -1;
      }
      memcpy(bufferPointer,aFormat,amount);
      aFormat += amount;
      bufferPointer+=amount;
      written += amount;
      continue;
    }

    const char* format_start_at = aFormat++;
    if(*aFormat == 'c'){// SINGLE CHAR
      aFormat++;
      char c = (char) va_arg(parameters, int);
      if(!maxrem){
        return -1;//TODO: Error EOVERFLOW
      }
      memcpy(bufferPointer, &c,sizeof(c));
      written++;
      bufferPointer++;
    } else if(*aFormat == 's'){// STRING (char*)
      aFormat++;
      const char* strParam = va_arg(parameters, const char*);
      size_t length = strlen(strParam);
      if(maxrem<length){
        //TODO: Error EOVERFLOW
        return -1;
      }
      memcpy(bufferPointer,strParam,length);
      written+=length;
      bufferPointer+=length;
    } else {
      aFormat = (char*)format_start_at;
      size_t length = strlen(aFormat);
      if(maxrem<length){
        //TODO: Error EOVERFLOW
        return -1;
      }
      memcpy(bufferPointer,aFormat,length);
      written += length;
      aFormat += length;
      bufferPointer+=length;
    }
  }
  va_end(parameters);
  *bufferPointer='\0';
  return written;
};
