#ifndef __BQos__X86_HPP
#define __BQos__X86_HPP 1#include <BQos/hardware.hpp>
#include <BQos/HW/VGA/text_mode.hpp>
#include <GNU/multiboot.h>
namespace BQos::HW {
    using namespace BQ;    
    /** Support of i386 class hardware **/
    class i386: public hardware {
    public:
        /**
         * 
         * @param mbi {multiboot_info_t*} 
         *        pointer to multiboot_info structure provided by grub
         * @param mbm {uint32_t}
         *        `multiboot magic` signature
         **/
        i386(multiboot_info_t* mbi, uint32_t mbm);        
        virtual a_tty &get_tty(int=0);
    protected:
        BQos::HW::VGA::tty _tty;
    };
}
#endif