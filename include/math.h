/**  * I'm absolutely certain my implementation is buggy.
 * Works for me; that's is the only goal
 * WARNING: DO NOT USE. **/
#ifndef __BQLIBC_MATH_H
#define __BQLIBC_MATH_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/**Common mathematical functions**/
float       fabsf(float);
double      fabs(double);
long double fabsl(long double);
float       remainderf(float,float);
double      remainder(double, double);
long double remainderl(long double, long double);
float       remquof(float, float, int*);
double      remquo(double,double,int*);
long double remquol(long double, long double);
float       fmaf(float, float, float);
double      fma(double, double, double);
long double fmal(long double, long double, long double);
float       fmaxf(float, float);
double      fmax(double,double);
long double fmaxl(long double, long double);
float       fminf(float, float);
double      fmin(double,double);
long double fminl(long double, long double);
float       fdimf(float, float);
double      fdim(double,double);
long double fdiml(long double, long double);
float       nanf(const char*arg);
double      nan(const char*arg);
long double nanl(const  char*arg);
float       cosf(float);
double      cos(double);
long double cosl(long double);
float       sinf(float);
double      sin(double);
long double sinl(long double);
float       tanf(float);
double      tan(double);
long double tanl(long double);
float       acosf(float);
double      acos(double);
long double acosl(long double);
float       asinf(float);
double      asin(double);
long double asinl(long double);
float       atanf(float);
double      atan(double);
long double atanl(long double);
/** atan2 Compute arc tangent with two parameters (function ) **/
float       atan2f(float, float);
double      atan2(double, double);
long double atan2l(long double, long double);
/****************************************Hyperbolic functions **/
/** cosh Compute hyperbolic cosine (function ) **/
float       coshf(float);
double      cosh(double);
long double coshl(long double);
/** sinh Compute hyperbolic sine (function ) **/
double sinh(double x);
float sinhf(float x);
long double sinhl(long double x);
/** tanh Compute hyperbolic tangent (function ) **/
double tanh(double x);
float tanhf(float x);
long double tanhl(long double x);
/** acosh Compute area hyperbolic cosine (function ) **/
double acosh(double x);
float acoshf(float x);
long double acoshl(long double x);
/** asinh Compute area hyperbolic sine (function ) **/
 double asinh(double x);
 float asinhf(float x);
 long double asinhl(long double x);
/** atanh Compute area hyperbolic tangent (function ) **/
 double atanh(double x);
 float atanhf(float x);
 long double atanhl(long double x);
/** ******************************Exponential and logarithmic functions **/
/** exp Compute exponential function (function ) **/
float       expf(float);
double      exp(double);
long double expl(long double);
/** frexp Get significand and exponent (function ) **/
float       frexpf( float arg, int* exp );//(1)	(since C99)
double      frexp( double arg, int* exp );//(2)	
long double frexpl( long double arg, int* exp );//(3)	(since C99)
/** ldexp Generate value from significand and exponent (function ) **/
float       ldexpf( float arg, int exp );//(1)	(since C99)
double      ldexp( double arg, int exp );//(2)	
long double ldexpl( long double arg, int exp );//(3)	(since C99)
/** log Compute natural logarithm (function ) **/
/** log10 Compute common logarithm (function ) **/
/** modf Break into fractional and integral parts (function ) **/
float       modff( float arg, float* iptr );//(1)	(since C99)
double      modf( double arg, double* iptr );//(2)	
long double modfl( long double arg, long double* iptr );//(3)	(since C99
/** exp2 Compute binary exponential function (function ) **/
float       exp2f(float);
double      exp2(double);
long double exp2l(long double);
/** expm1 Compute exponential minus one (function ) **/
float       expm1f(float);
double      expm1(double);
long double expm1l(long double);
/** ilogb Integer binary logarithm (function ) **/
int ilogbf( float arg );//(1)	(since C99)
int ilogb( double arg );//(2)	(since C99)
int ilogbl( long double arg );//
#define FP_ILOGB0 /*implementation-defined*/(since C99)
#define FP_ILOGBNAN /*implementation-defined*/(since C99)
/** log1p Compute logarithm plus one (function ) **/
float       log1pf( float arg );//(1)	(since C99)
double      log1p( double arg );//(2)	(since C99)
long double log1pl( long double arg );//(3)	(since C99)

float       logf(float);
double      log(double);
long double logl(long double); // TODO: move to 
float       log10f( float arg );//(1)	(since C99)
double      log10( double arg );//(2)	
long double log10l( long double arg );//

/** log2 Compute binary logarithm (function ) **/
float       log2f( float arg );//(1)	(since C99)
double      log2( double arg );//(2)	(since C99)
long double log2l( long double arg );//(3)	(since C99)
/** logb Compute floating-point base logarithm (function ) **/
float       logbf( float arg );//(1)	(since C99)
double      logb( double arg );//(2)	(since C99)
long double logbl( long double arg );//(3)	(since C99)
/** scalbn Scale significand using floating-point base exponent (function ) **/
float       scalbnf( float arg, int exp );//(1)	(since C99)
double      scalbn( double arg, int exp );//(2)	(since C99)
long double scalbnl( long double arg, int exp );//(3)	(since C99)
//#define scalbn( arg, exp )//(4)	(since C99)Defined in header <math.h>
/** scalbln Scale significand using floating-point base exponent (long) (function ) **/
float       scalblnf( float arg, long exp );//(5)	(since C99)
double      scalbln( double arg, long exp );//(6)	(since C99)
long double scalblnl( long double arg, long exp );//(7)	(since C99)
/** **********************************************Power functions**/
/**powRaise to power (function )**/
float       powf( float base, float exponent );//(1)	(since C99)
double      pow( double base, double exponent );//(2)	
long double powl( long double base, long double exponent );//(3)	(since C99)
/**sqrt Compute square root (function )**/
float       sqrtf( float arg );//(1)	(since C99)
double      sqrt( double arg );//(2)	
long double sqrtl( long double arg );//(3)	(since C99)//
 
//      float sqrt (float x);
//long double sqrt (long double x);
//     double sqrt (T x);           // additional overloads for integral types
/**cbrt Compute cubic root (function )**/
float       cbrtf( float arg );//(1)	(since C99)
double      cbrt( double arg );//(2)	(since C99)
long double cbrtl( long double arg );//(3)	(since C99)//
/**hypot Compute hypotenuse (function )**/
float       hypotf( float x, float y );//(1)	(since C99)
double      hypot( double x, double y );//(2)	(since C99)
long double hypotl( long double x, long double y );//(3)	(since C99) 
/**Error and gamma functions**/
/**erf Compute error function (function )**/
float       erff( float arg );//(1)	(since C99)
double      erf( double arg );//(2)	(since C99)
long double erfl( long double arg );//(3)	(since C99)
/**erfc Compute complementary error function (function )**/
float       erfcf( float arg );//(1)	(since C99)
double      erfc( double arg );//(2)	(since C99)
long double erfcl( long double arg );//(3)	(since C99)
/**tgamma Compute gamma function (function )**/
float       tgammaf( float arg );//(1)	(since C99)
double      tgamma( double arg );//(2)	(since C99)
long double tgammal( long double arg );//(3)	(since C99)
/**lgamma  Compute log-gamma function (function )**/
float       lgammaf( float arg );//(1)	(since C99)
double      lgamma( double arg );//(2)	(since C99)
long double lgammal( long double arg );//(3)	(since C99)
/** Rounding and remainder functions
ceil Round up value (function ) **/
float       ceilf( float arg );//(1)	(since C99)
double      ceil( double arg );//(2)	
long double ceill( long double arg );//(3)	(since C99)
/**floor Round down value (function )
**/
float       floorf( float arg );//(1)	(since C99)
double      floor( double arg );//(2)	
long double floorl( long double arg );//(3)	(since C99)
/**fmod Compute remainder of division (function )**/

float       fmodf (float, float);
double      fmod(double, double);
long double fmodl(long double, long double);
/**trunc Truncate value (function )**/
float       truncf( float arg );//(1)	(since C99)
double      trunc( double arg );//(2)	(since C99)
long double truncl( long double arg );//(3)	(since C99)

/**round Round to nearest (function )**/
float       roundf( float arg );//(1)	(since C99)
double      round( double arg );//(2)	(since C99)
long double roundl( long double arg );//(3)	(since C99)
//#define round( arg )//(4)	(since C99)Defined in header <math.h>
/**lround Round to nearest and cast to long integer (function )**/
long        lroundf( float arg );//(5)	(since C99)
long        lround( double arg );//(6)	(since C99)
long        lroundl( long double arg );//(7)	(since C99)
//#define lround( arg )//(8)	(since C99)Defined in header <math.h>
/** llround Round to nearest and cast to long long integer (function ) **/
long long   llroundf( float arg );//(9)	(since C99)
long long   llround( double arg );//(10)	(since C99)
long long   llroundl( long double arg );//(11)	(since C99)
//#define llround( arg )

/** rint Round to integral value (function ) **/
float       rintf( float arg ); //(1)	(since C99)
double      rint( double arg ); //(2)	(since C99)
long double rintl( long double arg ); //(3)	(since C99) // 
//#define rint( arg ) //(4)	(since C99) // Defined in header <math.h>
/** lrint Round and cast to long integer (function ) **/
long        lrintf( float arg ); //(5)	(since C99)
long        lrint( double arg ); //(6)	(since C99)
long        lrintl( long double arg ); //(7)	(since C99) // 
//#define lrint( arg ) //(8)	(since C99) // Defined in header <math.h>
/** llrint Round and cast to long long integer (function ) **/
long long   llrintf( float arg ); //(9)	(since C99)
long long   llrint( double arg ); //(10)	(since C99)
long long   llrintl( long double arg ); //(11)	(since C99) // 
/** nearbyint Round to nearby integral value (function ) **/
float       nearbyintf( float arg );//(1)	(since C99)
double      nearbyint( double arg );//(2)	(since C99)
long double nearbyintl( long double arg );//(3)	(since C99)
/** remainder Compute remainder (IEC 60559) (function ) **/

/** remquo Compute remainder and quotient (function ) **/
/**Floating-point manipulation functions**/
/**copysign Copy sign (function )**/
float       copysignf( float x, float y );//(1)	(since C99)
double      copysign( double x, double y );//(2)	(since C99)
long double copysignl( long double x, long double y );//(3)	(since C99)
/**nan Generate quiet NaN (function )**/
/**nextafter Next representable value (function )**/
float       nextafterf( float from, float to );//(1)	(since C99)
double      nextafter( double from, double to );//(2)	(since C99)
long double nextafterl( long double from, long double to );//(3)	(since C99)
/**nexttoward Next representable value toward precise value (function )**/
float       nexttowardf( float from, long double to );//(4)	(since C99)
double      nexttoward( double from, long double to );//(5)	(since C99)
long double nexttowardl( long double from, long double to );//(6)	(since C99)
/**Minimum, maximum, difference functions
fdim Positive difference (function )**/
/**fmax Maximum value (function )**/
/**fmin Minimum value (function )**/
/**Other functions**/
/**fabs Compute absolute value (function )**/
/**fma Multiply-add (function )**/
/**Macros / Functions
These are implemented as macros in C and as functions in C++:
Classification macro / functions **/
/**fpclassify Classify floating-point value (macro/function ) **/
/**isfinite Is finite value (macro )**/
/**isinf Is infinity (macro/function )**/
/**isnan Is Not-A-Number (macro/function )**/
/**isnormal Is normal (macro/function )**/
/**signbit Sign bit (macro/function )**/
/**Comparison macro / functions
isgreater Is greater (macro )**/
/**isgreaterequal Is greater or equal (macro )**/
/**isless Is less (macro )**/
/**islessequal Is less or equal (macro )**/
/**islessgreater Is less or greater (macro )**/
/**isunordered Is unordered (macro )**/
/**Macro constants
math_errhandling Error handling (macro )**/
/**INFINITY Infinity (constant )**/
/**NAN Not-A-Number (constant )**/
/**HUGE_VAL Huge value (constant )**/
/**HUGE_VALF 
Huge float value **/
/** HUGE_VALL 
Huge long double value (constant ) **/
/** This header also defines the following macro constants (since C99/C++11):
macro	type	description
MATH_ERRNO
MATH_ERREXCEPT	int	Bitmask value with the possible values math_errhandling can take.
FP_FAST_FMA
FP_FAST_FMAF
FP_FAST_FMAL	int	Each, if defined, identifies for which type fma is at least as efficient as x*y+z.
FP_INFINITE
FP_NAN
FP_NORMAL
FP_SUBNORMAL
FP_ZERO	int	The possible values returned by fpclassify.
FP_ILOGB0
FP_ILOGBNAN	int	Special values the ilogb function may return. **/
/** Types
double_t 
Floating-point type (type ) **/
/** float_t
Floating-point type (type )  **/
extern double const pi;	// pi
extern double const twopi;			// pi times 2
extern double const two_over_pi;		// 2/pi
extern double const halfpi;			// pi divided by 2
extern double const threehalfpi;  		// pi times 3/2, used in tan routines
extern double const four_over_pi;		// 4/pi, used in tan routines
extern double const qtrpi;			// pi/4.0, used in tan routines
extern double const sixthpi;			// pi/6.0, used in atan routines
//double const tansixthpi;=tan(sixthpi);		// tan(pi/6), used in atan routines

extern double const twelfthpi;			// pi/12.0, used in atan routines
//double const tantwelfthpi;=tan(twelfthpi);	// tan(pi/12), used in atan routines
#define tansixthpi tan(sixthpi)
#define tantwelfthpi tan(twelthpi)
#ifdef __cplusplus
}
#endif
#endif
