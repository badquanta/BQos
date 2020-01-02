#ifndef __BQLIBC_TIME_H
#define __BQLIBC_TIME_H

#ifdef __cplusplus
extern "C" {
#endif
// TODO: time.h
typedef unsigned int time_t;
/**
 * @link https://en.cppreference.com/w/cpp/chrono/c/tm
 **/
typedef struct {
    int tm_sec, tm_min, tm_hour, tm_mday, tm_mon, tm_year, tm_wday, tm_yday, tm_isdst;
} tm;

#ifdef __cplusplus
}
#endif
#endif
