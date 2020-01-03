#ifndef _FCNTL_H_
#define	_FCNTL_H_

#ifdef __cplusplus
extern "C" {
#endif


/*
 * File status flags: these are used by open(2), fcntl(2).
 * They are also used (indirectly) in the kernel file structure f_flags,
 * which is a superset of the open/fcntl flags.  Open flags and f_flags
 * are inter-convertible using OFLAGS(fflags) and FFLAGS(oflags).
 * Open/fcntl flags begin with O_; kernel-internal flags begin with F.
 */
/* open-only flags */
#define	O_RDONLY	0x0001		/* open for reading only */
#define	O_WRONLY	0x0002		/* open for writing only */
#define	O_RDWR		0x0004		/* open for reading and writing */
#define	O_ACCMODE	0x0007		/* mask for above modes */

#define O_CREAT     0x0200      //Create file if it does not exist.
#define O_TRUNC     0x0400      // Truncate flag.
#define O_EXCL      0x0800      //Exclusive use flag.
#define O_NOCTTY    0x0100      //Do not assign controlling terminal.




#include <sys/types.h>
#include <sys/stat.h>

int  creat(const char *, mode_t);
int  fcntl(int, int, ...);
int open(const char *pathname, int flags);
//int open(const char *pathname, int flags, mode_t mode);
int  posix_fadvise(int, off_t, off_t, int);
int  posix_fallocate(int, off_t, off_t);
#ifdef __cplusplus
}
#endif
#endif