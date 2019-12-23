#include "../Vga.hpp"
using namespace osinc::hw::vga;

uint8_t terminal::entry_color(enum color fg, enum color bg){
    return fg | bg << 4;
}

uint16_t terminal::vga_entry(unsigned char uc, uint8_t color){
    return (uint16_t)uc|(uint16_t)color<<8;
}    

terminal::terminal(){
    row=0; column=0; color = entry_color(LIGHT_GREY,BLACK);
}