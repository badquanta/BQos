#include <math.h>
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
																

double x2;							// The input argument squared

x2=x * x;
return (c1 + x2*(c2 + x2*(c3 + x2*(c4 + c5*x2))));
}

//
//  This is the main cosine approximation "driver"
// It reduces the input argument's range to [0, pi/2],
// and then calls the approximator. 
// See the notes for an explanation of the range reduction.
//
double cos_73(double x){
	int quad;						// what quadrant are we in?

	x=fmod(x, twopi);				// Get rid of values > 2* pi
	if(x<0)x=-x;					// cos(-x) = cos(x)
	quad=(x * two_over_pi);			// Get quadrant # (0 to 3) we're in
	switch (quad){
	case 0: return  cos_73s(x);
	case 1: return -cos_73s(pi-x);
	case 2: return -cos_73s(x-pi);
	case 3: return  cos_73s(twopi-x);
	}
}
/** soh CAH toa **/

double cos(double v){
    return cos_73(v);
}


#ifdef TEST

int main(){
    return 1;
}
#endif

