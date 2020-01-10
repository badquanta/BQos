/**
 * Intended as part of a poor stand in for a real libc
 * @link https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_types.h.html
 * Most documentation is sourced from there.
 **/
#ifndef __LIBBQ__TYPES_HPP
#define __LIBBQ__TYPES_HPP 1
#include <sys/cdefs.h>
#include <stddef.h>
#include <stdint.h>


/*Used for file system block counts.*/
typedef uint32_t                       fsblkcnt_t;
/*Used for file system file counts.*/
typedef uint32_t                       fsfilcnt_t;
/**Used for file serial numbers.**/
typedef uint32_t                            ino_t;
/**Used as a general identifier; can be used to contain at least a pid_t, uid_t, or gid_t.**/
typedef int32_t                              id_t;
/**Used for group IDs.**/
typedef id_t                                gid_t;
/**Used for user IDs.**/
typedef id_t                                uid_t;
/**Used for process IDs and process group IDs.**/
typedef id_t                                pid_t;
/**Used for file sizes.**/
typedef int32_t                             off_t;
//LATER: typedef int32_t                           ssize_t;
/**Used for some file attributes.**/
typedef int32_t                            mode_t;
/**Used for link counts.**/
typedef int32_t                           nlink_t;
/**Used for file block counts.**/
typedef int32_t                          blkcnt_t;
/**Used for block sizes.**/
typedef int32_t                         blksize_t;
/** Used for device IDs.**/
typedef int32_t                             dev_t;
/**Used for system times in clock ticks or CLOCKS_PER_SEC; see <time.h>.**/
typedef int32_t                           clock_t;//TODO: Maybe make 64 bits? or a float
/**Used for time in microseconds.**/
typedef int32_t                       suseconds_t;
/**Used for time in seconds.**/
typedef int32_t                            time_t;
/**Used for timer ID returned by timer_create().**/
typedef int32_t                           timer_t;
/**Used for clock ID type in the clock and timer functions.**/
typedef int32_t                         clockid_t;





/** Used to identify a thread attribute object.**/
typedef int32_t                     pthread_attr_t;


/** Used to identify a barrier.**/
typedef int32_t                     pthread_barrier_t;

/** Used to define a barrier attributes object.**/
typedef int32_t                     pthread_barrierattr_t;

/** Used for condition variables.**/
typedef int32_t                     pthread_cond_t;

/** Used to identify a condition attribute object.**/
typedef int32_t                     pthread_condattr_t;

/** Used for thread-specific data keys.**/
typedef int32_t                     pthread_key_t;

/** Used for mutexes.**/
typedef int32_t                     pthread_mutex_t;

/** Used to identify a mutex attribute object.**/
typedef int32_t                     pthread_mutexattr_t;

/** Used for dynamic package initialization.**/
typedef int32_t                     pthread_once_t;

/** Used for read-write locks.**/
typedef int32_t                     pthread_rwlock_t;

/** Used for read-write lock attributes.**/
typedef int32_t                     pthread_rwlockattr_t;

/** Used to identify a spin lock.**/
typedef int32_t                     pthread_spinlock_t;

/** Used to identify a thread.**/
typedef int32_t                     pthread_t;
#endif