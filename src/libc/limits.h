#ifndef _BQLIBC_LIMITS_H
#define _BQLIBC_LIMITS_H
//	Number of bits in a char object (byte)	8 or greater*
#define CHAR_BIT 8
//	Minimum value for an object of type signed char	-127 (-27+1) or less*
#define SCHAR_MIN -127
//	Maximum value for an object of type signed char	127 (27-1) or greater*
#define SCHAR_MAX 127
//	Maximum value for an object of type unsigned char	255 (28-1) or greater*
#define UCHAR_MAX 255
//	Minimum value for an object of type char	either SCHAR_MIN or 0
#define CHAR_MIN 0
//	Maximum value for an object of type char	either SCHAR_MAX or UCHAR_MAX
#define CHAR_MAX 255
//	Maximum number of bytes in a multibyte character, for any locale	1 or greater*
#define MB_LEN_MAX 1
//	Minimum value for an object of type short int	-32767 (-215+1) or less*
#define SHRT_MIN -32767
//	Maximum value for an object of type short int	32767 (215-1) or greater*
#define SHRT_MAX 32767
//	Maximum value for an object of type unsigned short int	65535 (216-1) or greater*
#define USHRT_MAX 65535
//	Minimum value for an object of type int	-32767 (-215+1) or less*
#define INT_MIN -32767
//	Maximum value for an object of type int	32767 (215-1) or greater*
#define INT_MAX 32767
//	Maximum value for an object of type unsigned int	65535 (216-1) or greater*
#define UINT_MAX 65535	
//	Minimum value for an object of type long int	-2147483647 (-231+1) or less*
#define LONG_MIN -2147483647	
//	Maximum value for an object of type long int	2147483647 (231-1) or greater*
#define LONG_MAX 2147483647	
//	Maximum value for an object of type unsigned long int	4294967295 (232-1) or greater*
#define ULONG_MAX 4294967295	
//	Minimum value for an object of type long long int	-9223372036854775807 (-263+1) or less*
#define LLONG_MIN -9223372036854775807	
//	Maximum value for an object of type long long int	9223372036854775807 (263-1) or greater*
#define LLONG_MAX 9223372036854775807
//	Maximum value for an object of type unsigned long long int	18446744073709551615 (264-1) or greater*
#define ULLONG_MAX 18446744073709551615
#endif