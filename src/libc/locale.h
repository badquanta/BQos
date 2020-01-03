#ifndef __BQLIBC_LOCALE_H
#define __BQLIBC_LOCALE_H

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    char *decimal_point, *thousands_sep, *grouping,
        *mon_decimal_point, *mon_thousands_sep, *mon_grouping,
        *positive_sign, *negative_sign,
        *currency_symbol, 
        frac_digits, 
        p_cs_precedes,  n_cs_precedes, 
        p_sep_by_space, n_sep_by_space,
        p_sign_posn,    n_sign_posn,
        *int_curr_symbol,
        int_frac_digits, 
        int_p_cs_precedes,  int_n_cs_precedes,
        int_p_sep_by_space, int_n_sep_by_space,
        int_p_sign_posn,    int_n_sign_posn;
} lconv;
#define LC_ALL      0xFFFF
#define LC_COLLATE  0x0001
#define LC_CTYPE    0x0002
#define LC_MONETARY 0x0004
#define LC_NUMERIC  0x0008
#define LC_TIME     0x0010
/** specs @link https://en.cppreference.com/w/c/locale/setlocale **/
char* setlocale(int,const char*);
/** specs @link https://en.cppreference.com/w/c/locale/localeconv **/
lconv *localeconv(void);

#ifdef __cplusplus
}
#endif

#endif