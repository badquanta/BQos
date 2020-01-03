#ifndef __BQLIBC_INTTYPES_H
#define __BQLIBC_INTTYPES_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
intmax_t    imaxabs(intmax_t);
intmax_t    imaxdiv(intmax_t, intmax_t);
typedef struct imaxdiv_t {intmax_t quot; intmax_t rem;} imaxdiv_t;

#ifdef __cplusplus
}
#endif
#endif