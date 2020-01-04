#include <stdlib.h>

int32_t abs32(int32_t x){
    int t = x >> 31; 
    return t ^ (x + t);
}

int64_t abs64(int64_t x){
    int64_t t = x >> 63; 
    return t ^ (x + t);
}

/**
 * @link https://en.cppreference.com/w/c/numeric/math/abs
 **/
int abs(int x)
{
    return abs32(x);
}

long labs(long x){
    return abs32(x);
}

long long llabs(long long x){
    return abs64(x);
}

intmax_t imaxabs(intmax_t x){
    return abs64(x);
}