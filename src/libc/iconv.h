/** https://pubs.opengroup.org/onlinepubs/7908799/xsh/iconv.h.html **/

#ifndef __LIBC_ICONV_H
#define __LIBC_ICONV_H

#ifdef __cplusplus
extern "C"{
#endif
#include <stddef.h>
typedef void *iconv_t;
iconv_t iconv_open(const char *, const char *);
size_t  iconv(iconv_t, char **, size_t *, char **, size_t *);
int     iconv_close(iconv_t);

#ifdef __cplusplus
}
#endif
#endif