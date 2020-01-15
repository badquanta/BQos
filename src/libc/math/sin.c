#include <math.h>
/** @link https://www.sanfoundry.com/c-program-value-sin-x/**/
/** SOH cah toa **/
double sin(double x){
    return cos(halfpi-x);
}


#ifdef TEST

int main(){
    return 1;
}
#endif