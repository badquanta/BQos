/** Original code from: https://wiki.osdev.org/Meaty_Skeleton#libc_and_libk **/
#ifndef _BQLIBC_STLIB_H
#define _BQLIBC_STLIB_H 1
 
#include <sys/cdefs.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif


/* Unsigned.  */
# define UINT8_C(c)	c
# define UINT16_C(c)	c
# define UINT32_C(c)	c ## U
# if __WORDSIZE == 64
#  define UINT64_C(c)	c ## UL
# else
#  define UINT64_C(c)	c ## ULL
# endif
/**
 * TODO:
 *      C Standard General Utilities Library
        This header defines several general purpose functions, including dynamic memory management, random number generation, communication with the environment, integer arithmetics, searching, sorting and converting.
 * TODO: [ ] All stdlib functions.
 **/
/**Functions:
    String conversion **/
        /** atof
         * Convert string to double (function )
         * atoi 
         **/
        int atoi(const char*);
        /** Convert string to integer (function )
        atol
        Convert string to long integer (function )
        atoll 
        Convert string to long long integer (function )
        strtod
        Convert string to double (function )
        strtof 
        Convert string to float (function )
        strtol
        Convert string to long integer (function )
        strtold 
        Convert string to long double (function )
        strtoll 
        Convert string to long long integer (function )
        **/
        /**
         * strtoul
         * Convert string to unsigned long integer (function )
         **/
        unsigned long int strtoul (const char* str, char** endptr, int base);
        /**
         * strtoull 
        Convert string to unsigned long long integer (function )

    Pseudo-random sequence generation**/
        /**
         * rand
         * Generate random number (function )
         **/
        int rand();
        /**
        srand
        Initialize random number generator (function )

        Dynamic memory management
        calloc
        Allocate and zero-initialize array (function )
        **/
        /**free
        Deallocate memory block (function )
        **/
        void free(void*);
        /** malloc
         * Allocate memory block (function )
         **/
        void* malloc(size_t);
        /**realloc
        Reallocate memory block (function )

    Environment
        **/
       /**  abort
        * Abort current process (function )
        **/
        __attribute__((__noreturn__))
        void abort(void);        
        /** atexit
        Set function to be executed on exit (function ) **/
        int atexit(void(*func)(void));
        /** at_quick_exit 
         * Set function to be executed on quick exit (function )
         **/
        /**
         * exit
        Terminate calling process (function )
         **/
        /** getenv
         * Get environment string (function )
         **/
        char* getenv(const char* name);
         
        /**
        quick_exit 
        Terminate calling process quick (function )
         **/
        /**
        system
        Execute system command (function )
         **/
        /**
        _Exit 
        Terminate calling process (function )
 **/
        /**
    Searching and sorting
     **/
        /**
        bsearch
        Binary search in array (function )
         **/
        /**
        qsort
        Sort elements of array (function )
         **/
        void qsort(void* aBase, size_t aCount, size_t aSize, int (*aComparator)(const void*,const void*));

        /**

    Integer arithmetics
     **/
        /**
        abs
        Absolute value (function )
         **/
        /**
        div
        Integral division (function )
         **/
        /**
        labs
        Absolute value (function )
         **/
        /**
        ldiv
        Integral division (function )
         **/
        /**
        llabs 
        Absolute value (function )
         **/
        /**
        lldiv 
        Integral division (function )
         **/
        /**

    Multibyte characters
     **/
        /**
        mblen
        Get length of multibyte character (function )
         **/
        /**
        mbtowc
        Convert multibyte sequence to wide character (function )
         **/
        /**
        wctomb
        Convert wide character to multibyte sequence (function )
 **/
        /**
    Multibyte strings
     **/
        /**
        mbstowcs
        Convert multibyte string to wide-character string (function )
         **/
        /**
        wcstombs
        Convert wide-character string to multibyte string (function )
         **/
        /**

Macro constants
 **/
        /**
        EXIT_FAILURE
        Failure termination code (macro )
         **/
        /**
        EXIT_SUCCESS
        Success termination code (macro )
         **/
        /**
        MB_CUR_MAX
        Maximum size of multibyte characters (macro )
         **/
        /**
        NULL
        Null pointer (macro )
         **/
        /**
        RAND_MAX
        Maximum value returned by rand (macro )
 **/
        /**
Types
 **/
        /**
        div_t
        Structure returned by div (type )
         **/
        /**
        ldiv_t
        Structure returned by ldiv (type )
         **/
        /**
        lldiv_t 
        Structure returned by lldiv (type )
         **/
        /**
        size_t
        Unsigned integral type (type )
**/
#ifdef __cplusplus
}
#endif
 
#endif