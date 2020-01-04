#include "../../../system/BQos/ARCH/i386.hpp"

using namespace BQos::ARCH;

x86_32::x86_32(multiboot_info_t* info, uint32_t mbm){

}

x86_32::~x86_32(){

}
/** TODO: Current implementation only returns VGA TTY if idx=0; else NULL **/
BQos::a_tty *x86_32::tty(int idx){
    if(idx==0){
        return &_tty;
    } else {
        return NULL;
    }
}
