#include <BQos/multiboot_main.hpp>

#include <BQos/ARCH/i386.hpp>
#include <BQos/Memory.hpp>
#include <stdio.h>
static uint8_t bootMem[1024]{0};
extern "C" {
void multiboot_main(multiboot_info_t* info, uint32_t magic){
    //BQos::Memory::add(&bootMem, sizeof(bootMem));
    BQos::MemoryRegion bootMemRegion((size_t)&bootMem, sizeof(bootMem));
    BQos::Memory::add(&bootMemRegion);
    BQos::ARCH::x86_32 hw = BQos::ARCH::x86_32(info,magic);
    BQos::a_tty* out = hw.tty(0);
    out->put("Hello World.\n");
    out->put("New line.");
    printf("Testing...\n");
}
}




#ifdef TEST
extern "C" {
int main(){
    return 1;
}}
#endif
