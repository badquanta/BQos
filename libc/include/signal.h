#ifndef __BQLIBC_SIGNAL_H
#define __BQLIBC_SIGNAL_H

#ifdef __cplusplus
extern "C"{
#endif
typedef int sig_atomic_t;
#define SIGTERM /*TODO: SIGNALS*/
#define SIGSEGV /*TODO: SIGNALS*/
#define SIGINT /*TODO: SIGNALS*/
#define SIGILL /*TODO: SIGNALS*/
#define SIGABRT /*TODO: SIGNALS*/
#define SIGFPE /*TODO: SIGNALS*/
void (*signal( int sig, void (*handler) (int))) (int);
int raise( int sig );

#ifdef __cplusplus
}
#endif
#endif