#include <math.h>

double const pi=3.1415926535897932384626433;	// pi
double const twopi=2.0*pi;			// pi times 2
double const two_over_pi= 2.0/pi;		// 2/pi
double const halfpi=pi/2.0;			// pi divided by 2
double const threehalfpi=3.0*pi/2.0;  		// pi times 3/2, used in tan routines
double const four_over_pi=4.0/pi;		// 4/pi, used in tan routines
double const qtrpi=pi/4.0;			// pi/4.0, used in tan routines
double const sixthpi=pi/6.0;			// pi/6.0, used in atan routines
double const twelfthpi=pi/12.0;			// pi/12.0, used in atan routines



#ifdef TEST

int main(){
    return 1;
}
#endif

#include <math.h>
float fmodf(float aA, float aB){
    // TODO:
}
double fmod(double aA, double aB){
    // TODO:
}long double fmodl(long double aA, long double aB){
    // TODO:
}
/** soh cah TOA **/double tan(double v){}
/** @link https://www.sanfoundry.com/c-program-value-sin-x/**/
/** SOH cah toa **/
double sin(double x){
    return cos(halfpi-x);
}
/** Original reference code from @link http://www.ganssle.com/approx/sincos.cpp 
 ** Thank you Jack Ganssle
 * **/
// *********************************************************
// ***
// ***   Routines to compute sine and cosine to 7.3 digits
// ***  of accuracy. 
// ***
// *********************************************************
//
//		cos_73s computes cosine (x)
//
//  Accurate to about 7.3 decimal digits over the range [0, pi/2].
//  The input argument is in radians.
//
//  Algorithm:
//		cos(x)= c1 + c2*x**2 + c3*x**4 + c4*x**6 + c5*x**8
//   which is the same as:
//		cos(x)= c1 + x**2(c2 + c3*x**2 + c4*x**4 + c5*x**6)
//		cos(x)= c1 + x**2(c2 + x**2(c3 + c4*x**2 + c5*x**4))
//		cos(x)= c1 + x**2(c2 + x**2(c3 + x**2(c4 + c5*x**2)))
//
double cos_73s(double x)
{
const double c1= 0.999999953464;
const double c2=-0.499999053455;
const double c3= 0.0416635846769;
const double c4=-0.0013853704264;
const double c5= 0.00002315393167;  	
																double x2;							// The input argument squaredx2=x * x;
return (c1 + x2*(c2 + x2*(c3 + x2*(c4 + c5*x2))));
}//
//  This is the main cosine approximation "driver"
// It reduces the input argument's range to [0, pi/2],
// and then calls the approximator. 
// See the notes for an explanation of the range reduction.
//
double cos_73(double x){
	int quad;						// what quadrant are we in?	x=fmod(x, twopi);				// Get rid of values > 2* pi
	if(x<0)x=-x;					// cos(-x) = cos(x)
	quad=(x * two_over_pi);			// Get quadrant # (0 to 3) we're in
	switch (quad){
	case 0: return  cos_73s(x);
	case 1: return -cos_73s(pi-x);
	case 2: return -cos_73s(x-pi);
	case 3: return  cos_73s(twopi-x);
	}
}
/** soh CAH toa **/double cos(double v){
    return cos_73(v);
}double acos(double x){
    return x; /** @todo double acos(); **/
}