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
#define _POSIX_VERSION 200809L
// Maybe this should be -1, see docs.
#define _POSIX2_VERSION 200809L
int          access(const char *, int);
unsigned     alarm(unsigned);
int          chdir(const char *);
int          chmod(const char * filename, mode_t mode);
int          chown(const char *, uid_t, gid_t);
int          close(int);
size_t       confstr(int, char *, size_t);
//[XSI][Option Start]
char        *crypt(const char *, const char *);
//[Option End]
int          dup(int);


int          dup2(int, int);
void         _exit(int);
///[XSI][Option Start]
void         encrypt(char [64], int);
//[Option End]
int          execl(const char *, const char *, ...);
int          execle(const char *, const char *, ...);
int          execlp(const char *, const char *, ...);
int          execv(const char *, char *const []);
int          execve(const char *, char *const [], char *const []);
int          execvp(const char *, char *const []);
int          faccessat(int, const char *, int, int);
int          fchdir(int);
int          fchown(int, uid_t, gid_t);
int          fchownat(int, const char *, uid_t, gid_t, int);
//[SIO][Option Start]
int          fdatasync(int);
//[Option End]
int          fexecve(int, char *const [], char *const []);
pid_t        fork(void);
long         fpathconf(int, int);
//[FSC][Option Start]
int          fsync(int);
//[Option End]
int          ftruncate(int, off_t);
char        *getcwd(char *, size_t);
gid_t        getegid(void);
uid_t        geteuid(void);
gid_t        getgid(void);
int          getgroups(int, gid_t []);
//[XSI][Option Start]
long         gethostid(void);
//[Option End]
int          gethostname(char *, size_t);
char        *getlogin(void);
int          getlogin_r(char *, size_t);
int          getopt(int, char * const [], const char *);
pid_t        getpgid(pid_t);
pid_t        getpgrp(void);
pid_t        getpid(void);
pid_t        getppid(void);
pid_t        getsid(pid_t);
uid_t        getuid(void);
int          isatty(int);
int          lchown(const char *, uid_t, gid_t);
int          link(const char *, const char *);
int          linkat(int, const char *, int, const char *, int);
//[XSI][Option Start]
int          lockf(int, int, off_t);
//[Option End]
off_t        lseek(int, off_t, int);
//[XSI][Option Start]
int          nice(int);
//[Option End]
long         pathconf(const char *, int);
int          pause(void);
int          pipe(int [2]);
ssize_t      pread(int, void *, size_t, off_t);
ssize_t      pwrite(int, const void *, size_t, off_t);
ssize_t      read(int, void *, size_t);
ssize_t      readlink(const char *, char *, size_t);
ssize_t      readlinkat(int, const char *, char *, size_t);
int          rmdir(const char *);
int          setegid(gid_t);
int          seteuid(uid_t);
int          setgid(gid_t);


int          setpgid(pid_t, pid_t);
//[OB XSI][Option Start]
pid_t        setpgrp(void);
//[Option End]
//[XSI][Option Start]
int          setregid(gid_t, gid_t);
int          setreuid(uid_t, uid_t);
//[Option End]
pid_t        setsid(void);
int          setuid(uid_t);
unsigned     sleep(unsigned);
//[XSI][Option Start]
void         swab(const void * , void * , ssize_t);
//[Option End]
int          symlink(const char *, const char *);
int          symlinkat(const char *, int, const char *);
//[XSI][Option Start]
void         sync(void);
//[Option End]
long         sysconf(int);
pid_t        tcgetpgrp(int);
int          tcsetpgrp(int, pid_t);
int          truncate(const char *, off_t);
char        *ttyname(int);
int          ttyname_r(int, char *, size_t);
int          unlink(const char *);
int          unlinkat(int, const char *, int);
ssize_t      write(int, const void *, size_t);

#ifdef __cplusplus
}
#endif
#endif