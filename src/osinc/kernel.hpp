#ifndef __OSINC__KERNEL_HPP
#define __OSINC__KERNEL_HPP
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif
#if !defined(__i386__)
#error "This tutorial needs to be compiled with a ix86-elf compiler"
#endif
#define __STDC_HOSTED__ false
#include "vendor/multiboot.h"
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

namespace osinc{

/**
 *KERNEL: The Chief Executive Object.
 **/
class kernel {
public:
    kernel(const multiboot_info_t*,uint32_t);
    ~kernel();
};
}
void kernel_main(void);
#endif