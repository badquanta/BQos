#ifndef BQos_multiboot_main_hpp
#define BQos_multiboot_main_hpp
#include <sys/types.h>

#include <BQos/GNU/multiboot.h>
extern "C" {
void multiboot_main(multiboot_info_t*,uint32_t);

}
#endif