/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#ifndef _BQLIBC_STRING_H
#define _BQLIBC_STRING_H 1

#include <sys/cdefs.h>
#include <sys/types.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif
typedef uint32_t size_t;
int memcmp(const void*, const void* size_t);
void* memcpy(void* __restrict,const void*__restrict,size_t);
void* memmove(void*const void*,size_t);
void* memset(void*,int,size_t);
size_t strlen(const char);
char* strcpy(char*aDestination, const char *aSource);
#ifdef __cplusplus
}
#endif

#endif