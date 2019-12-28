#include <BQos/multiboot_main.hpp>
#include <BQos/ARCH/i386.hpp>
extern "C" {
void multiboot_main(multiboot_info_t* info, uint32_t magic){
    BQos::ARCH::x86_32 hw = BQos::ARCH::x86_32(info,magic);
    hw.tty(0)->put("Hello World.");
}
}
