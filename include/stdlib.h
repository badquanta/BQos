/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#ifndef _BQLIBC_STLIB_H
#define _BQLIBC_STLIB_H 1
#include <sys/cdefs.h>
#include <stddef.h>
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
#define NULL 0
#define EXIT_FAILURE 1
#define EXIT_SUCCESS 0
// TODO: Increase RAND_MAX from c reference minimum
#define RAND_MAX 32767

/* Unsigned.  */
# define UINT8_C(c)	c
# define UINT16_C(c)	c
# define UINT32_C(c)	c ## U
# if __WORDSIZE == 64
#  define UINT64_C(c)	c ## UL
# else
#  define UINT64_C(c)	c ## ULL
# endif
/** Types **/
    /** div_t Structure returned by div (type ) **/
    typedef struct div_t {int quot; int rem;} div_t;
    /** ldiv_t Structure returned by ldiv (type ) **/
    typedef struct ldiv_t {long quot; long rem;} ldiv_t;
    /** lldiv_t Structure returned by lldiv (type ) **/
    typedef struct lldiv_t {long long quot; long long rem;} lldiv_t;
    /** size_t Unsigned integral type (type ) **/
    // TODO: Review why I had to do this in stddef instead? 
/**Functions:**/
        void initialize_standard_library();
    /**String conversion **/
        /** atof* Convert string to double (function )**/
        double atof(const char* nptr);
        /** atoi  Convert string to integer (function )**/
        int atoi(const char*);
        /** atol Convert string to long integer (function ) **/
        long int atol(const char* nptr);
        /**atoll Convert string to long long integer (function )**/
        long long int atoll(const char* nptr);
        /**strtod Convert string to double (function )**/
        double strtod(const char* nptr, char** endptr);
        /**strtof Convert string to float (function )**/
        float strtof(const char* nptr, char** endptr);
        /**strtol Convert string to long integer (function )**/
        long int strtol(const char* nptr, char** endptr, int base);
        /**strtold Convert string to long double (function )**/
        long double strtold(const char* nptr, char** endptr);
        /**strtoll Convert string to long long integer (function )**/
        long long int strtoll(const char* nptr, char** endptr, int base);
        /*** strtoul* Convert string to unsigned long integer (function )**/
        unsigned long int strtoul (const char* str, char** endptr, int base);
        /*** strtoull Convert string to unsigned long long integer (function )**/
        unsigned long long int strtoull(const char* nptr, char** endptr, int base);
    /**Pseudo-random sequence generation**/
        /*** rand* Generate random number (function )**/
        int rand();
        /**srand Initialize random number generator (function ) **/
        void srand(unsigned int seed);
        /**Dynamic memory management**/
        /**calloc Allocate and zero-initialize array (function )**/
        void* calloc(size_t nmemb, size_t size);
        /**free Deallocate memory block (function ) **/
        void free(void*);
        /** malloc * Allocate memory block (function ) **/
        void* malloc(size_t);
        /**realloc Reallocate memory block (function )**/
        void* realloc(void* ptr, size_t size);
    /**Environment**/
       /**  abort* Abort current process (function )**/
        __attribute__((__noreturn__)) void abort(void);        
        /** atexitSet function to be executed on exit (function ) **/
        int atexit(void(*func)(void));
        /** at_quick_exit * Set function to be executed on quick exit (function )**/
        int at_quick_exit( void (*func)(void) );
        /*** exit Terminate calling process (function )**/
        __attribute__((__noreturn__)) void exit(int status);
        /** getenv * Get environment string (function ) **/
        char* getenv(const char* name);
        /** quick_exit Terminate calling process quick (function )**/
        __attribute__((__noreturn__)) void quick_exit(int status);
        /** system Execute system command (function )**/
        int system(const char* string);
        /** _Exit  Terminate calling process (function )**/
        __attribute__((__noreturn__)) void _Exit(int status);
    /** Searching and sorting **/
        /** bsearch Binary search in array (function )**/
        void* bsearch(const void* key, const void* base,
                size_t nmemb, size_t size, 
                int (*compar)(const void *a, const void *b));
        void* bsearch(const void* key, const void* base,
                size_t nmemb, size_t size, 
                int (*compar)(const void *a, const void *b));
        /**qsort Sort elements of array (function )**/
        void qsort(void* aBase, size_t aCount, size_t aSize, int (*aComparator)(void*,void*));
    /**Integer arithmetics**/
        /** abs Absolute value (function ) **/
        int abs(int);
   
    
        /** div Integral division (function )**/
        div_t div(int, int);
        /** labs Absolute value (function ) **/
        long labs(long);
        /** ldiv Integral division (function ) **/
        ldiv_t ldiv(long,long);
        /**llabs Absolute value (function )**/
        long long llabs(long long);
        /**lldiv Integral division (function )**/
        lldiv_t lldiv(long long, long long);
        
       
    /**Multibyte characters**/
        /**mblen Get length of multibyte character (function ) **/
        /** mbtowc Convert multibyte sequence to wide character (function ) **/
        /** wctomb Convert wide character to multibyte sequence (function ) **/
        /** Multibyte strings **/
        /** mbstowcs Convert multibyte string to wide-character string (function ) **/
        /** wcstombs Convert wide-character string to multibyte string (function ) **/
/** Macro constants **/
        /** EXIT_FAILURE Failure termination code (macro ) **/
        /** EXIT_SUCCESS Success termination code (macro ) **/
        /** MB_CUR_MAX Maximum size of multibyte characters (macro ) **/
        /** NULL Null pointer (macro ) **/
        /** RAND_MAX Maximum value returned by rand (macro ) **/

#ifdef __cplusplus
}
#endif
 
#endif