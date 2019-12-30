#ifndef BQos_HW_VGA_hpp
#define BQos_HW_VGA_hpp 1
#include <BQos/a_tty.hpp>
/**
 * VGA/EGA Text mode implementation of a TTY
 */
namespace BQos::HW::VGA
{
    using namespace BQ;
    /** `text_mode` `screen` memory is organized as 16bit `text_mode_cell`s.**/
    struct text_mode_cell {
        /** It displays ASCII characterset by default.**/
        char txt;
        /** And uses a 16-color palette;
         * with the foreground and background colors of each
         * ascii character taking up a nibble, or half of
         * a single byte.
         **/
        uint8_t fg:4,bg:4;
    } __attribute__((__packed__));
    /** Simple implementation using the EGA hardware memory address. **/
    class text_mode:    public BQos::a_tty
    {
        /** Create a VGA TextMode class.
         * TODO: Make this private/protected/etc and constructed by a driver.
         **/
        public:     text_mode();
        public:		virtual ~text_mode();
        /**
         * VGA TextMode memory is organized row-major in a linear order.
         * * In order to know the offset of each Y index; one must know the
         * "width" or size().x;
         * * In order to know when to clip; one must know the size of the screen.
         * * One assumes negative values are always clipped.
         */
        protected:  int32_xy _screen_size;
        protected:  int _cursor_index;//TODO: Read cursor position from hardware?
        /**
         * TODO: This buffer address should be set by the Driver.
         **/
        protected:  text_mode_cell *buffer;
        public:     virtual int32_xy screen_size();
        /**
         * TODO: The screen size should be set by the Driver.
         */
        public:     virtual int32_xy screen_size(int32_xy);
        public:     virtual int cursor_index();
        public:     virtual int cursor_index(int);
        public:     virtual int32_xy cursor_position();
        public:     virtual int32_xy cursor_position(int32_xy);        public:     int set_color(uint8_t color);
        //public:     int put_entry_at(unsigned char, uint8_t, int32_xy);
        public:     virtual int put_at(int,char);
        public:     virtual int max_index();
    };
}
#endif
