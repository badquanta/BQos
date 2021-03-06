#ifndef BQos_HW_VGA_colors16_hpp
#define BQos_HW_VGA_colors16_hpp 1/**
 * VGA/EGA Text mode implementation of a TTY
 */
namespace BQos::HW::VGA {
/**
 * Default VGA 16 entry palette color names.
 **/
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
}
#endif