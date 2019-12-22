#ifndef __OSINC__HW__VGA_HPP
#define __OSINC__HW__VGA_HPP
namespace osinc::hw::vga {
enum color {
    BLACK = 0,
    BLUE = 1,
    GREEN = 2,
    CYAN = 3,
    RED = 4,
    MAGENTA = 5,
    BROWN = 6,
    LIGHT_GREY = 7,
    DARK_GREY = 8,
    LIGHT_BLUE = 9,
    LIGHT_GREEN = 10,
    LIGHT_CYAN = 11,
    LIGHT_RED = 12,
    LIGHT_MAGENTA = 13,
    LIGHT_BROWN = 14,
    WHITE = 15,
};
    
class terminal {
    public:
        terminal();
        ~terminal();

        static inline uint8_t entry_color(enum color);
        static inline uint16_t entry(unsigned char uc, uint8_t color);
        
};
}
#endif