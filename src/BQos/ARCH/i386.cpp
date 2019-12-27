#include <BQos/ARCH/i386.hpp>

using namespace BQos::ARCH;

i386::i386(multiboot_info_t* info, uint32_t mbm){
    
}
/** TODO: Current implementat only returns VGA TTY if idx=0; else NULL **/
BQos::a_tty *i386::tty(int idx=0){
    if(idx==0){
        return &_tty;
    } else {
        return NULL;
    }   
}