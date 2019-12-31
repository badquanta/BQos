/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#ifndef _BQLIBC_STDIO_H
#define _BQLIBC_STDIO_H 1
 
#include <sys/cdefs.h>
#include <sys/types.h> 

#define EOF (-1)
 
#ifdef __cplusplus
extern "C" {
#endif

typedef struct {int unused;} FILE;
int fflush(FILE*);
int fprintf(FILE*,const char*,...);
int printf(const char* __restrict, ...);
int putchar(int);
int puts(const char*);
FILE *fopen(const char*,const char*);
int fclose(FILE*);
size_t fread(void *aPointer, size_t aSize, size_t aCount, FILE *aStream);
int fseek(FILE* aStream, long int aOffset, int aOrigin);
long int ftell ( FILE *aStream);
size_t fwrite(const void *aPointer, size_t aSize, size_t aCount, FILE *aStream);
void setbuf( FILE *aStream, char *aBuffer);
int vfprintf ( FILE * aStream, const char * aFormat,...);
#ifdef __cplusplus
}
#endif
 
#endif