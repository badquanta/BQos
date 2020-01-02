#ifndef __BQLIBC__UNISTD_H
#define __BQLIBC__UNISTD_H
#include <sys/types.h>

#ifdef __cplusplus
extern "C" {
#endif
/** 
 * @link https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/unistd.h.html 
 * @link https://en.wikipedia.org/wiki/Unistd.h
 *  
 ***/

// LATER: Review if this should be changed:
//LATER: #define _POSIX_VERSION 200809L
// Maybe this should be -1, see docs.
//LATER: #define _POSIX2_VERSION 200809L
//LATER: int          access(const char *, int);
//LATER: unsigned     alarm(unsigned);
//LATER: int          chdir(const char *);
//LATER: int          chown(const char *, uid_t, gid_t);
//LATER: int          close(int);
//LATER: size_t       confstr(int, char *, size_t);
//[XSI][Option Start]
//LATER: char        *crypt(const char *, const char *);
//[Option End]
//LATER: int          dup(int);


//LATER: int          dup2(int, int);
//LATER: void         _exit(int);
///[XSI][Option Start]
//LATER: void         encrypt(char [64], int);
//[Option End]
//LATER: int          execl(const char *, const char *, ...);
//LATER: int          execle(const char *, const char *, ...);
//LATER: int          execlp(const char *, const char *, ...);
int          execv(const char *, char *const []);
int          execve(const char *, char *const [], char *const []);
int          execvp(const char *, char *const []);
//LATER: int          faccessat(int, const char *, int, int);
//LATER: int          fchdir(int);
//LATER: int          fchown(int, uid_t, gid_t);
//LATER: int          fchownat(int, const char *, uid_t, gid_t, int);
//[SIO][Option Start]
//LATER: int          fdatasync(int);
//[Option End]
//LATER: int          fexecve(int, char *const [], char *const []);
pid_t        fork(void);
//LATER: long         fpathconf(int, int);
//[FSC][Option Start]
//LATER: int          fsync(int);
//[Option End]
//LATER: int          ftruncate(int, off_t);
//LATER: char        *getcwd(char *, size_t);
//LATER: gid_t        getegid(void);
//LATER: uid_t        geteuid(void);
//LATER: gid_t        getgid(void);
//LATER: int          getgroups(int, gid_t []);
//[XSI][Option Start]
//LATER: long         gethostid(void);
//[Option End]
//LATER: int          gethostname(char *, size_t);
//LATER: char        *getlogin(void);
//LATER: int          getlogin_r(char *, size_t);
//LATER: int          getopt(int, char * const [], const char *);
//LATER: pid_t        getpgid(pid_t);
//LATER: pid_t        getpgrp(void);
//LATER: pid_t        getpid(void);
//LATER: pid_t        getppid(void);
//LATER: pid_t        getsid(pid_t);
//LATER: uid_t        getuid(void);
//LATER: int          isatty(int);
//LATER: int          lchown(const char *, uid_t, gid_t);
//LATER: int          link(const char *, const char *);
//LATER: int          linkat(int, const char *, int, const char *, int);
//[XSI][Option Start]
//LATER: int          lockf(int, int, off_t);
//[Option End]
//LATER: off_t        lseek(int, off_t, int);
//[XSI][Option Start]
//LATER: int          nice(int);
//[Option End]
//LATER: long         pathconf(const char *, int);
//LATER: int          pause(void);
//LATER: int          pipe(int [2]);
//LATER: ssize_t      pread(int, void *, size_t, off_t);
//LATER: ssize_t      pwrite(int, const void *, size_t, off_t);
//LATER: ssize_t      read(int, void *, size_t);
//LATER: ssize_t      readlink(const char *restrict, char *restrict, size_t);
//LATER: ssize_t      readlinkat(int, const char *restrict, char *restrict, size_t);
//LATER: int          rmdir(const char *);
//LATER: int          setegid(gid_t);
//LATER: int          seteuid(uid_t);
//LATER: int          setgid(gid_t);


//LATER: int          setpgid(pid_t, pid_t);
//[OB XSI][Option Start]
//LATER: pid_t        setpgrp(void);
//[Option End]
//[XSI][Option Start]
//LATER: int          setregid(gid_t, gid_t);
//LATER: int          setreuid(uid_t, uid_t);
//[Option End]
//LATER: pid_t        setsid(void);
//LATER: int          setuid(uid_t);
//LATER: unsigned     sleep(unsigned);
//[XSI][Option Start]
//LATER: void         swab(const void * restrict, void * restrict, ssize_t);
//[Option End]
//LATER: int          symlink(const char *, const char *);
//LATER: int          symlinkat(const char *, int, const char *);
//[XSI][Option Start]
//LATER: void         sync(void);
//[Option End]
//LATER: long         sysconf(int);
//LATER: pid_t        tcgetpgrp(int);
//LATER: int          tcsetpgrp(int, pid_t);
//LATER: int          truncate(const char *, off_t);
//LATER: char        *ttyname(int);
//LATER: int          ttyname_r(int, char *, size_t);
//LATER: int          unlink(const char *);
//LATER: int          unlinkat(int, const char *, int);
//LATER: ssize_t      write(int, const void *, size_t);

#ifdef __cplusplus
}
#endif
#endif