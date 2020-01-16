#ifndef __BQLIBC_TIME_H
#define __BQLIBC_TIME_H

#ifdef __cplusplus
extern "C" {
#endif
//#include <stddef.h>
#include <sys/types.h>
// TODO: time.h
//typedef unsigned int time_t;
//typedef unsigned int clock_t;
typedef long long timespec;
/**
 * @link https://en.cppreference.com/w/cpp/chrono/c/tm
 **/
typedef struct tm {
    int tm_sec, tm_min, tm_hour, tm_mday, tm_mon, tm_year, tm_wday, tm_yday, tm_isdst;
} tm;

clock_t clock();
double difftime(time_t time1, time_t time0);
time_t mktime(struct tm* timeptr);
time_t time(time_t* timer);
int timespec_get(timespec* ts, int base);
char* asctime(const struct tm* timeptr);
char* ctime(const time_t* timer);
struct tm* gmtime(const time_t* timer);
struct tm* localtime(const time_t* timer);
size_t strftime(char* s, size_t maxsize, const char* format, const struct tm* timeptr);
size_t strftime (char* ptr, size_t maxsize, const char* format,
                 const struct tm* timeptr );
#ifdef __cplusplus
}
#endif
#endif
