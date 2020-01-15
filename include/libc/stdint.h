#ifndef __OPEN__STDINT_H
#define __OPEN__STDINT_H 1

typedef char                               int8_t;
typedef unsigned char                     uint8_t;
typedef short                             int16_t;
typedef unsigned short                   uint16_t;
typedef int                               int32_t;
typedef unsigned int                     uint32_t;
typedef long long int                     int64_t;
typedef unsigned long long int           uint64_t;
typedef int64_t                          intmax_t;
typedef uint64_t                        uintmax_t;
typedef uint32_t                        uintptr_t;
typedef int64_t                          intptr_t;
#define INTMAX_MIN            -9223372036854775807

#define INTMAX_MAX            9223372036854775807

#define UINTMAX_MAX           18446744073709551615

#define INT8_MIN                           -(2^7-1)
#define INT8_MAN                            (2^7-1)
#define INT16_MIN                         -(2^15-1)
#define INT16_MAN                          (2^15-1)
#define INT32_MIN                         -(2^31-1)
#define INT32_MAX                          (2^31-1)
#define UINT8_MAX                         (2^8-1)
#define UINT16_MAX                         (2^16-1)
#define UINT32_MAX                         (2^32-1)
#define UINT64_MAX                         (2^64-1)


#endif
