/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#ifndef _BQLIBC_SYS_CDEFS_H
#define _BQLIBC_SYS_CDEFS_H 1
#define BQLIBC 1
 
#include <stddef.h>
typedef signed long int ssize_t;
#ifndef _WINT_T
  typedef unsigned int wint_t;
  #define _WINT_T 1
#endif
#endif