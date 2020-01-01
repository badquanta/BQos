/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#ifndef _BQLIBC_STDIO_H
#define _BQLIBC_STDIO_H 1
//#include <sys/fcntl.h>
#include <sys/cdefs.h>
#include <sys/types.h> 

#define EOF (-1)
 
#ifdef __cplusplus
extern "C" {
#endif
/** TODO: Operations on files:
 * - [ ] remove
 * - [ ] rename
 * - [ ] tmpfile
 * - [ ] tmpnam
 */

/** File Identification structure. **/
typedef struct {int unused;} FILE;
/** Required by GCC; TODO: implement stderr `FILE` pointer. **/
FILE * stderr,stdin,stdout;
/** FILE ACCESS ROUTINES **/
int fclose(FILE*);
int fflush(FILE*);
FILE *fopen(const char*,const char*);
// TODO: freopen @link http://www.cplusplus.com/reference/cstdio/freopen/

enum SEEK_ORIGINS {
    SEEK_SET,
    SEEK_CUR,
    SEEK_END
};
int fseek(FILE* aStream, long int aOffset, int aOrigin);
long int ftell ( FILE *aStream);
size_t fwrite(const void *aPointer, size_t aSize, size_t aCount, FILE *aStream);
void setbuf( FILE *aStream, char *aBuffer);


int fprintf(FILE*,const char*,...);
// TODO: fscanf
int printf(const char* __restrict, ...);
int sprintf(char *aBuffer, const char* aFormat, ...);
int snprintf(char *aBuffer, size_t aNumBytes, char *aFormat, ...);
// TODO: http://www.cplusplus.com/reference/cstdio/fscanf/
// TODO: http://www.cplusplus.com/reference/cstdio/sscanf/
int vfprintf ( FILE * aStream, const char * aFormat,...);
// TODO: http://www.cplusplus.com/reference/cstdio/vfscanf/
// TODO: http://www.cplusplus.com/reference/cstdio/vprintf/
// TODO: http://www.cplusplus.com/reference/cstdio/vscanf/
// TODO: http://www.cplusplus.com/reference/cstdio/vsnprintf/
// TODO: http://www.cplusplus.com/reference/cstdio/vsprintf/
// TODO: http://www.cplusplus.com/reference/cstdio/vsscanf/


// TODO: http://www.cplusplus.com/reference/cstdio/fgetc/
// TODO: http://www.cplusplus.com/reference/cstdio/fgets/
// TODO: http://www.cplusplus.com/reference/cstdio/fputc/
// TODO: http://www.cplusplus.com/reference/cstdio/fputs/
// TODO: http://www.cplusplus.com/reference/cstdio/getc/
// TODO: http://www.cplusplus.com/reference/cstdio/getchar/
// TODO: http://www.cplusplus.com/reference/cstdio/gets/
char * gets ( char * str );
// TODO: http://www.cplusplus.com/reference/cstdio/putc/
int putc( int aCharacter, FILE *aStream);
int putchar(int);
int puts(const char*);
// TODO: ungetc http://www.cplusplus.com/reference/cstdio/ungetc/


size_t fread(void *aPointer, size_t aSize, size_t aCount, FILE *aStream);
// TODO: fwrite http://www.cplusplus.com/reference/cstdio/fwrite/



#ifdef __cplusplus
}
#endif
 
#endif