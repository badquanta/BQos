/** Original code from: 
 * https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk 
 
 * **/
#ifndef _BQLIBC_STDIO_H
#define _BQLIBC_STDIO_H 1
//#include <sys/fcntl.h>
#include <sys/cdefs.h>
#include <sys/types.h> 
#include <stdarg.h>
#include <fcntl.h>
#define EOF (-1)
/** @see @link https://www.gnu.org/software/libc/manual/html_node/Controlling-Buffering.html 
 * 
**/
#define _IOFBF (-8)
#define _IOLBF (-16)
#define _IONBF (-32)
#ifdef __cplusplus
extern "C" {
#endif
/** Required for GPP complication; setting it to the size of EGA memory for now. **/
#define BUFSIZ (80*25*2)
/** File Identification structure. **/
typedef struct {int unused;} FILE;
/** Compliclation has required the definition of fpos_t **/
typedef struct {char* path; int unused;} fpos_t;
/** Required by GCC; TODO: implement stderr `FILE` pointer. **/
FILE * stderr,*stdin,*stdout;
/** FILE ACCESS ROUTINES **/
int remove(const char* filename);
int rename(const char* old, const char* aNew);
FILE* tmpfile();
char* tmpnam(char* s);
int fclose(FILE*);
int fflush(FILE*);
FILE *fopen(const char*,const char*);
FILE *fdopen(int fildes, const char *mode); 
// TODO: freopen @link http://www.cplusplus.com/reference/cstdio/freopen/
FILE* freopen(const char* filename, const char* mode, FILE* stream);

enum SEEK_ORIGINS {
    SEEK_SET,
    SEEK_CUR,
    SEEK_END
};
int fseek(FILE* aStream, long int aOffset, int aOrigin);
long int ftell ( FILE *aStream);
size_t fwrite(const void *aPointer, size_t aSize, size_t aCount, FILE *aStream);
void setbuf( FILE *aStream, char *aBuffer);
int setvbuf(FILE* stream, char* buf, int mode, size_t size);

int fprintf(FILE*,const char*,...);
// TODO: fscanf
int printf(const char* __restrict, ...);
int sprintf(char *aBuffer, const char* aFormat, ...);
int snprintf(char *aBuffer, size_t aNumBytes, char *aFormat, ...);
// TODO: http://www.cplusplus.com/reference/cstdio/fscanf/
int fscanf(FILE* stream, const char* format, ...);
// TODO: http://www.cplusplus.com/reference/cstdio/sscanf/
int sscanf(const char* s, const char* format, ...);

// TODO: http://www.cplusplus.com/reference/cstdio/vfscanf/
int vfscanf(FILE* stream, const char* format, va_list arg);
// TODO: http://www.cplusplus.com/reference/cstdio/vprintf/
int vprintf(const char* format, va_list arg);
int vfprintf ( FILE * aStream, const char * aFormat,...);
// TODO: http://www.cplusplus.com/reference/cstdio/vscanf/
int vscanf(const char* format, va_list arg);
// TODO: http://www.cplusplus.com/reference/cstdio/vsnprintf/
int vsnprintf(char* s, size_t n, const char* format, va_list arg);
// TODO: http://www.cplusplus.com/reference/cstdio/vsprintf/
int vsprintf(char* s, const char* format, va_list arg);
// TODO: http://www.cplusplus.com/reference/cstdio/vsscanf/
int vsscanf(const char* s, const char* format, va_list arg);

// TODO: http://www.cplusplus.com/reference/cstdio/fgetc/
int fgetc(FILE* stream);
// TODO: http://www.cplusplus.com/reference/cstdio/fgets/
char* fgets(char* s, int n, FILE* stream);
// TODO: http://www.cplusplus.com/reference/cstdio/fputc/
int fputc(int c, FILE* stream);
// TODO: http://www.cplusplus.com/reference/cstdio/fputs/
 int fputs(const char* s, FILE* stream);
// TODO: http://www.cplusplus.com/reference/cstdio/getc/
  int getc(FILE* stream);
// TODO: http://www.cplusplus.com/reference/cstdio/getchar/
  int getchar();
// TODO: http://www.cplusplus.com/reference/cstdio/gets/
char * gets ( char * str );
// TODO: http://www.cplusplus.com/reference/cstdio/putc/
int putc( int aCharacter, FILE *aStream);
int putchar(int);
int puts(const char*);
// TODO: ungetc http://www.cplusplus.com/reference/cstdio/ungetc/
int ungetc(int c, FILE* stream);

size_t fread(void *aPointer, size_t aSize, size_t aCount, FILE *aStream);
// TODO: fwrite http://www.cplusplus.com/reference/cstdio/fwrite/
size_t fwrite(const void* ptr, size_t size, size_t nmemb, FILE* stream);
int scanf ( const char * format, ... );
int fgetpos(FILE* stream, fpos_t* pos);
int fseek(FILE* stream, long int offset, int whence);
int fsetpos(FILE* stream, const fpos_t* pos);
long int ftell(FILE* stream);
void rewind(FILE* stream);
void clearerr(FILE* stream);
int feof(FILE* stream);
int ferror(FILE* stream);
void perror(const char* s);

/** The fileno() function shall return the integer file descriptor associated with the stream pointed to by stream.**/
int fileno(FILE *stream);

#ifdef __cplusplus
}
#endif
 
#endif