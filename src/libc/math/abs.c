#include <math.h>
int abs(int x)
{
    int t = x >> 31; 
    return t ^ (x + t);
}