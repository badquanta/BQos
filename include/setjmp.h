#ifndef __BQLIBC_SETJMP_H
#define __BQLIBC_SETJMP_H

#ifdef __cplusplus
extern "C"{
#endif
typedef struct jump_buf_struct {int todo;} jmp_buf;
void longjmp( jmp_buf env, int status );

#define setjmp(env) /* TODO */

#ifdef __cplusplus
}
#endif
#endif