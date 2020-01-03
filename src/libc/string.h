/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#ifndef _BQLIBC_STRING_H
#define _BQLIBC_STRING_H 1

#include <stddef.h>
#include <sys/cdefs.h>
#include <sys/types.h>

#ifdef __cplusplus
extern "C" {
#define __CORRECT_ISO_CPP_STRING_H_PROTO 1
#endif
int ffs(int __val);
int ffsl(long __val);
//__extension__ int 	ffsll (long long __val)
void *memccpy(void *, const void *, int, size_t);
void *memchr(const void *, int, size_t);
int memcmp(const void *, const void *, size_t);
void *memcpy(void *__restrict, const void *__restrict, size_t);
void *memmem(const void *, size_t, const void *, size_t);
void *memmove(void *, const void *, size_t);
void *memset(void *, int, size_t);
char *strcat(char *, const char *);
size_t strlen(const char *);
int strcmp(const char *str1, const char *str2);
size_t strcspn(const char *str1, const char *str2);
char *strcpy(char *aDestination, const char *aSource);
char *strchr(const char *aString, int aCharacter);

char * strrchr (char * str, int character );
int strcoll(const char *str1, const char *str2);
size_t strspn ( const char * str1, const char * str2 );
char *strncat(char *destination, const char *source, size_t num);
int strncmp(const char *str1, const char *str2, size_t num);
char *strncpy(char *aDestination, const char *aSource, size_t length);
char * strtok ( char * str, const char * delimiters );
size_t strxfrm ( char * destination, const char * source, size_t num );
char * strpbrk (char * str1, const char * str2 );
char * strstr (char * str1, const char * str2 );

char *strerror(int errnum);

#ifdef __cplusplus
}
#endif

#endif
