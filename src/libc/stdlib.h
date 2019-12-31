/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#ifndef _BQLIBC_STLIB_H
#define _BQLIBC_STLIB_H 1
 
#include <sys/cdefs.h>
 
#ifdef __cplusplus
extern "C" {
#endif
 
__attribute__((__noreturn__))
void abort(void);
void* malloc(size_t);
void free(void*);
int atexit(void(*func)(void));
int atoi(const char*);
char* getenv(const char* name);
#ifdef __cplusplus
}
#endif
 
#endif