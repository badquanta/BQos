#ifndef BQos_HW_VGA_hpp
#define BQos_HW_VGA_hpp 1
#include <BQos/a_tty.hpp>
/**
 * VGA/EGA Text mode implementation of a TTY
 */
namespace BQos::HW::VGA 
{
    
    /** Simple implementation using the EGA hardware memory address. **/    
    class text_mode:    public BQos::a_tty 
    {       
        /** Create a VGA TextMode class.
         * TODO: Make this private/protected/etc and constructed by a driver.
         **/
        public:     text_mode();    
        /**
         * VGA TextMode version of a `a_tty::screen`
         */
        public:     class screen:   public BQos::a_tty::screen 
        {
            /** `text_mode` `screen` memory is organized as 16bit `cell`s.**/
            public: struct cell {
                /** It displays ASCII characterset by default.**/
                char txt;
                /** And uses a 16-color palette; 
                 * with the foreground and background colors of each
                 * ascii character taking up a nibble, or half of
                 * a single byte.
                 **/
                uint8_t fg:4,bg:4;
            } __attribute__((packed));
            /**
             * VGA TextMode memory is organized row-major in a linear order.
             * * In order to know the offset of each Y index; one must know the
             * "width" or size().x;
             * * In order to know when to clip; one must know the size of the screen.
             * * One assumes negative values are always clipped.
             */
            protected:      size_xy _size;
            /**
             * TODO: This buffer address should be set by the Driver.
             **/
            protected:      uint16_t *buffer;
            /**
             * TODO: The screen size should be set by the Driver.
             */
            public:         screen(size_xy);
            
            /** For every positive `XY` position within
             * the `screen.size()` (width/height,x/y)
             * there is a unique index that defines
             * which VGA `cell` this is in memory. */
            public:         size_t index_at(size_xy);
            /** text_mode will always 
             * @return `screen.size()`
             */
            public:         size_t max_index();
            /** `text_mode::screen` will always
             * @return `{0,0}`
             **/
            public:         size_t min_index();
        };
        
        public:     class cursor:   public BQos::a_tty::cursor 
        {
            protected:  screen *_screen;        
            protected:  size_xy _position;
            public:     cursor(screen*,size_xy={0,0});
            public:     virtual size_xy position();
        };
        protected:  static inline uint8_t entry_color(enum color, enum color);
        protected:  static inline uint16_t entry(unsigned char uc, uint8_t color);
        
        public:     int set_color(uint8_t color);
        public:     int put_entry_at(unsigned char, uint8_t, size_xy);
        public:     virtual int put(char);
        public:     virtual int put(const char *, size_t);
        public:     virtual int put(const char *);
        protected:  screen _screen;
        protected:  cursor _cursor;
        protected:  uint8_t _color;
    };
}
#endif