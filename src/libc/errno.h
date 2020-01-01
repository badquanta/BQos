#ifndef __BQLIBC_ERRNO_H
#define __BQLIBC_ERRNO_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * TODO: Implement errorno
 **/
#define errno __ERROR_NUMBER
    
static int __ERROR_NUMBER;

#define EDOM 1
#define ERANGE 2
#define EILSEQ 3

 #ifdef __cplusplus
}
#endif

#endif
 