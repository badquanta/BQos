#ifndef BQos_HW_a_tty_hpp
#define BQos_HW_a_tty_hpp 1
#include <libc/types.h>
#include <libBQ/XY.hpp>
/**
 * @brief These defines simply name various ASCII control character values.
 */
#define ASCII_NUL                       0x00
#define ASCII_StartOfHeading            0x01
#define ASCII_StartOfText               0x02
#define ASCII_EndOfText                 0x03
#define ASCII_EndOfTransmission         0x04
#define ASCII_Enquiry                   0x05
#define ASCII_Acknowledge               0x06
#define ASCII_Bell                      0x07
#define ASCII_Backspace                 0x08
#define ASCII_H_Tabulation              0x09
#define ASCII_LineFeed                  0x0A
#define ASCII_V_Tabulation              0x0B
#define ASCII_FormFeed                  0x0C
#define ASCII_CarriageReturn            0x0D
#define ASCII_ShiftOut                  0x0E
#define ASCII_ShiftIn                   0x0F
#define ASCII_DataLinkEscape            0x10
#define ASCII_DeviceControl1            0x11
#define ASCII_DeviceControl2            0x12
#define ASCII_DeviceControl3            0x13
#define ASCII_DeviceControl4            0x14
#define ASCII_NegativeAcknowledge       0x15
#define ASCII_SynchronousIdle           0x16
#define ASCII_EndOfTransmissionBlock    0x17
#define ASCII_Cancel                    0x18
#define ASCII_EndOfMedium               0x19
#define ASCII_Substitute                0x1A
#define ASCII_Escape                    0x1B
#define ASCII_FileSeparator             0x1C
#define ASCII_GroupSeparator            0x1D
#define ASCII_RecordSeparator           0x1E
#define ASCII_UnitSeparator             0x1F
#define ASCII_Delete                    0x7F

namespace BQos 
{    
    using namespace BQ;
    /**
     * Provide a generic interface to different "teletype"
     * devices.  While intended to be the abstract interface,
     * this base class also happens to instantiate usefull
     * "NULL" ttys that are safe to dump data to but
     * 
     * @note all data written will be lost; unless extended.
     **/
    class a_tty 
    {   
        /** Generic control character handler. **/
        public: class a_ASCII_Control_handler {
        	public:virtual int handle(a_tty*)=0;
        	public:virtual ~a_ASCII_Control_handler();
        };
        /** Default line feed handler **/
        public: class ASCII_LineFeed_handler : public a_ASCII_Control_handler {
            public:virtual int handle(a_tty* tty);
        };
        public: static ASCII_LineFeed_handler line_feed();
        /** ASCII_CarriageReturn handler **/
        public: class ASCII_CarriageReturn_handler : public a_ASCII_Control_handler {
            public:virtual int handle(a_tty* tty);
        };
        public: static ASCII_CarriageReturn_handler carriage_return();
        /**
         * @brief This defines the "Line Discipline" of this abstract TTY.
         * A "Line Discipline" will define if the TTY will handle the control
         * character; or pass it onto the TTY medium via `put_at()`
         */
        protected:a_ASCII_Control_handler *line_discipline[0x20]{NULL};
        /**
        * @brief  Make a "Teletype". 
        * 
        */
        public:a_tty();        
        public:virtual ~a_tty();
        /**
         * @brief query the dimensions of the tty screen.
         * 
         */        
        public:virtual size_xy screen_size();
        /**
         * @brief Get the `size_t` index of the current cursor.
         * 
         */
        public:virtual size_t cursor_index();
        /**
         * @brief Attempt to change where the cursor is
         * @note may not work; depending on actually tty device
         * @returns actual index location of cursor.
         * 
         */        
        public:virtual size_t cursor_index(size_t);
        /**
         * @brief Attempt to change the cursor relative to it's
         * current location.
         * @note may not actually work; should return 0 to indicate.
         * @returns actually distance location moved.
         * 
         */
        public:virtual size_t cursor_move(signed int);
        /**
         * @brief query the position of the tty cursor.
         * 
         */
        public:virtual size_xy cursor_position();
        /**
         * @brief attempt to set the position of the tty cursor;
         * @returns the actuall value of the cursor position after the attempt.
         * @note may be ignored
         * @note may be clipped to nearest valid position
         */
        public:virtual size_xy cursor_position(size_xy);
        /**
         * @brief Defines if printing order is "ABCDEF"...-> (true) or <-..."FEDCBA" (false)
         */
        public:virtual bool left_to_right();
        /**
         * @brief Attempts to set the printing order.
         * @note May not be supported.
         * @param {bool} desired setting
         * @returns {bool} actual setting
         */
        public:virtual bool left_to_right(bool);
        /**
         * @brief The inverse of `left_to_right()`
         * @note Controlled via `left_to_right(bool)`
         */
        public:virtual bool right_to_left();
        public:virtual bool line_feeds_up();
        public:virtual bool line_feeds_down();
        public:virtual size_t h_tabulation_size();
        public:virtual size_t v_tabulation_size();      
        
        /**
         * @brief Place a character at a certain linear `size_t` index in the tty buffer.
         * @note This does not interpret the character; it simply places whatever value
         * specified by the `char` into the tty buffer.
         */
        public:virtual int put_at(size_t, char);
        /**
         * @brief Place a character at a certain `size_xy` position within the tty buffer.
         * @note the `position` may be clipped if outside of the `screen_size()` of the buffer.
         */
        public:virtual int put_at(size_xy, char);
        /**
         * @brief Convert a `size_xy` 2D position into a `size_t` linear index.
         * @note for each point within `{0,0}` & `screen_size()` will have a unique
         * value between 0 & the length of the tty buffer indexes.
         * @note this will return -1 if the size_xy value is greater than `screen_size()`
         * or has either negative X or Y.
         * @return {int} index of xy position in tty linear buffer. `-1` if clipped.
         */
        public:virtual size_t index_at(size_xy);
        /**
         * @brief Declares if a particular index is valid or invalid.
         * @note indexes should start at 0; so -1 should be a save value for invalids.
         * @note indexes generally have a maximum value as well.
         */
        public:virtual bool valid_index(size_t);
        /**
         * @brief Declares the Min Index.
         *
         *
         */
        public:virtual size_t min_index();
        public:virtual size_t max_index();
        /** Place an individual character onto the TTY.
         * This should also advance the cursor. 
         * @returns 0 or 1; 1 if the character is "visible" 
         *                  or 0 if it was an unprintable "control"
         *                  character.
         * @note: For extender of abstract tty; this routine is all that
         *          must be extended but remember that calling this base class's
         *          implementation will ensure control characters are handled.
         *          If this routine returns 0; the character was a control character
         *          and the extending class can safely ignore and return printing nothing.
         * @note: After this character is printed; one must put_at(get_cursor()-1);
         */
        public:virtual int put(char c);
        /**
         * This will copy `length` number of characters from the buffer
         * and `put` them onto the TTY.  This should return the total
         * number returned by `put`; which corresponds to the total
         * number of 'non-control' characters present in the buffer.
         * @returns int
         */
        public:virtual int put(const char *buffer, size_t length);
        /**
         * This will copy characters from the buffer until it is null 
         * terminated.  This should return the total number that is
         * returned by the individual calls to `put`; reflecting the 
         * total number of 'non-control' characters that were put 
         * on the tty
         * @returns int
         */
        public:virtual int put(const char *buffer);

    };
}
#endif
