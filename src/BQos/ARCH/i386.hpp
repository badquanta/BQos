#ifndef __BQos__X86_HPP
#define __BQos__X86_HPP 1
#include <BQos/hardware.hpp>
#include <BQos/HW/VGA/text_mode.hpp>
#include <GNU/multiboot.h>
namespace BQos::ARCH {
    /** Support of x86_32 class hardware **/
    class x86_32: public hardware {
    public:
        /**
         *
         * @param mbi {multiboot_info_t*}
         *        pointer to multiboot_info structure provided by grub
         * @param mbm {uint32_t}
         *        `multiboot magic` signature
         **/
        x86_32(multiboot_info_t* mbi, uint32_t mbm);
        virtual ~x86_32();
        virtual a_tty *tty(int=0);
    protected:
        BQos::HW::VGA::text_mode _tty;
    };
}
#endif
