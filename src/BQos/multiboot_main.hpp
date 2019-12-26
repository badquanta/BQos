#ifndef BQos_multiboot_main_hpp
#define BQos_multiboot_main_hpp
#include <libc/types.h>
#include <GNU/multiboot.h>
extern "C" {
void multiboot_main(multiboot_info_t*,uint32_t);

}
#endif