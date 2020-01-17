#ifndef __OPEN__CTYPE_H
#define __OPEN__CTYPE_H 1
/** http://www.cplusplus.com/reference/cctype/ **/

#define C_NUL 0x00
#define C_TAB 0x09
#define C_F 0x0A
#define C_V 0x0B
#define C_NL  0x0C
#define C_RL  0x0D
#define C_LASTCONTROLCODE 0x1F
#define C_SPACE 0x20
#define C_PUNCT1_START 0x21
#define C_PUNCT1_END 0x2F
#define C_DIGIT_START 0x30
#define C_DIGIT_END 0x39
#define C_PUNCT2_START 0x3a
#define C_PUNCT2_END 0x40
#define C_ALPHA_UPPER_START 0x41
#define C_ALPHA_UPPER_HEX_END 0x46
#define C_ALPHA_UPPER_END   0x5A
#define C_PUNCT3_START 0x5B
#define C_PUNCT3_END 0x60
#define C_ALPHA_LOWER_START 0x61
#define C_ALPHA_LOWER_HEX_END 0x66
#define C_ALPHA_LOWER_END 0x7A
#define C_PUNCT4_START 0x7B
#define C_PUNCT4_END 0x7E
#define C_DEL 0x7F
#define _U	0x01	/* upper */
#define _L	0x02	/* lower */
#define	_N	0x04
#define _D	0x04	/* digit */
#define _C	0x08	/* cntrl */
#define _P	0x10	/* punct */
#define _S	0x20	/* white space (space/lf/tab) */
#define _X	0x40	/* hex digit */
#define	_B	0x80
#define _SP	0x80	/* hard space (0x20) */
#ifdef __cplusplus
extern "C" {
#endif
extern char 	_ctype_ [];
/** http://www.cplusplus.com/reference/cctype/isalnum/ **/
int isalnum(int);
/** http://www.cplusplus.com/reference/cctype/isalpha/ **/
int isalpha(int);
/** http://www.cplusplus.com/reference/cctype/isblank/ **/
int isblank(int);
/** http://www.cplusplus.com/reference/cctype/iscntrl/ **/
int iscntrl(int);
/** http://www.cplusplus.com/reference/cctype/isdigit/ **/    
int isdigit(int);
int isgraph(int);
/** http://www.cplusplus.com/reference/cctype/islower/ **/
int islower(int);
/** http://www.cplusplus.com/reference/cctype/isprint/ **/
int isprint(int);
/** http://www.cplusplus.com/reference/cctype/ispunct/ **/
int ispunct(int);
/** http://www.cplusplus.com/reference/cctype/isspace/ **/
int isspace(int);
/** http://www.cplusplus.com/reference/cctype/isupper/ **/
int isupper(int);
/** http://www.cplusplus.com/reference/cctype/isdigit/ **/
int isxdigit(int);

int tolower(int);
int toupper(int);

#ifdef __cplusplus
}
#endif
 
#endif
