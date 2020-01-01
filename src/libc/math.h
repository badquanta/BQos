#ifndef __BQLIBC_MATH_H
#define __BQLIBC_MATH_H


/** TODO: math.h
 * ctions

Trigonometric functions
cos
Compute cosine (function )
sin
Compute sine (function )
tan
Compute tangent (function )
acos
Compute arc cosine (function )
asin
Compute arc sine (function )
atan
Compute arc tangent (function )
atan2
Compute arc tangent with two parameters (function )

Hyperbolic functions
cosh
Compute hyperbolic cosine (function )
sinh
Compute hyperbolic sine (function )
tanh
Compute hyperbolic tangent (function )
acosh 
Compute area hyperbolic cosine (function )
asinh 
Compute area hyperbolic sine (function )
atanh 
Compute area hyperbolic tangent (function )

Exponential and logarithmic functions
exp
Compute exponential function (function )
frexp
Get significand and exponent (function )
ldexp
Generate value from significand and exponent (function )
log
Compute natural logarithm (function )
log10
Compute common logarithm (function )
modf
Break into fractional and integral parts (function )
exp2 
Compute binary exponential function (function )
expm1 
Compute exponential minus one (function )
ilogb 
Integer binary logarithm (function )
log1p 
Compute logarithm plus one (function )
log2 
Compute binary logarithm (function )
logb 
Compute floating-point base logarithm (function )
scalbn
**/
double scalbn (double x     , int n);
//float scalbn (float x      , int n);
/**
Scale significand using floating-point base exponent (function )
scalbln 
Scale significand using floating-point base exponent (long) (function )

Power functions
 **/
/**
pow
Raise to power (function )
 **/
/**
sqrt
Compute square root (function )
 **/
 double sqrt (double x);
//      float sqrt (float x);
//long double sqrt (long double x);
//     double sqrt (T x);           // additional overloads for integral types
/**
cbrt 
Compute cubic root (function )
 **/
/**
hypot 
Compute hypotenuse (function )
 **/
/**
Error and gamma functions
 **/
/**
erf 
Compute error function (function )
 **/
/**
erfc 
Compute complementary error function (function )
 **/
/**
tgamma 
Compute gamma function (function )
 **/
/**
lgamma 
Compute log-gamma function (function )
 **/
/**
Rounding and remainder functions
ceil
Round up value (function )
 **/
/**
floor
Round down value (function )
**/
double floor (double x);
//float floor (float x);

//long double floor (long double x);
/**
fmod
Compute remainder of division (function )
 **/
/**
trunc 
Truncate value (function )
 **/
/**
round 
Round to nearest (function )
 **/
/**
lround 
Round to nearest and cast to long integer (function )
 **/
/**
llround 
Round to nearest and cast to long long integer (function )
 **/
/**
rint 
Round to integral value (function )
 **/
/**
lrint 
Round and cast to long integer (function )
 **/
/**
llrint 
Round and cast to long long integer (function )
 **/
/**
nearbyint 
Round to nearby integral value (function )
 **/
/**
remainder 
Compute remainder (IEC 60559) (function )
 **/
/**
remquo 
Compute remainder and quotient (function )
 **/
/**

Floating-point manipulation functions
copysign 
Copy sign (function )
 **/
/**
nan 
Generate quiet NaN (function )
 **/
/**
nextafter 
Next representable value (function )
 **/
/**
nexttoward 
Next representable value toward precise value (function )
 **/
/**

Minimum, maximum, difference functions
fdim 
Positive difference (function )
 **/
/**
fmax 
Maximum value (function )
 **/
/**
fmin 
Minimum value (function )
 **/
/**

Other functions
fabs
Compute absolute value (function )
 **/
/**
abs
Compute absolute value (function )
**/
double abs (double x);
//float abs (float x);
/**
 * 
fma 
Multiply-add (function )
 **/
/**
Macros / Functions
These are implemented as macros in C and as functions in C++:
Classification macro / functions
 **/
/**
fpclassify 
Classify floating-point value (macro/function )
 **/
/**
isfinite 
Is finite value (macro )
 **/
/**
isinf 
Is infinity (macro/function )
 **/
/**
isnan 
Is Not-A-Number (macro/function )
 **/
/**
isnormal 
Is normal (macro/function )
 **/
/**
signbit 
Sign bit (macro/function )
 **/
/**

Comparison macro / functions
isgreater 
Is greater (macro )
 **/
/**
isgreaterequal 
Is greater or equal (macro )
 **/
/**
isless 
Is less (macro )
 **/
/**
islessequal 
Is less or equal (macro )
 **/
/**
islessgreater 
Is less or greater (macro )
 **/
/**
isunordered 
Is unordered (macro )
 **/
/**

Macro constants
math_errhandling 
Error handling (macro )
 **/
/**
INFINITY 
Infinity (constant )
 **/
/**
NAN
Not-A-Number (constant )
 **/
/**
HUGE_VAL
Huge value (constant )
 **/
/**
HUGE_VALF 
Huge float value
 **/
/**
HUGE_VALL 
Huge long double value (constant )
 **/
/**
This header also defines the following macro constants (since C99/C++11):
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
FP_ILOGBNAN	int	Special values the ilogb function may return.
 **/
/**
Types
double_t 
Floating-point type (type )
 **/
/**
float_t
Floating-point type (type ) 
 **/

#endif