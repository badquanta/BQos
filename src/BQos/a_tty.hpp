#ifndef BQos_HW_a_tty_hpp
#define BQos_HW_a_tty_hpp 1
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
     * NOTE: all data written will be lost; unless extended.
     **/
    class a_tty 
    {   /** Make a "Teletype". **/   
        public:a_tty();        
        
        public:virtual size_xy screen_size();
        public:virtual size_xy cursor_position();
        public:virtual size_xy cursor_position(size_xy);
        public:virtual bool print_left_to_right();
        public:virtual bool print_left_to_right(bool);
        public:virtual bool print_right_to_left();
        public:virtual bool line_feeds_up();
        public:virtual bool line_feeds_down();
        public:virtual size_t h_tabulation_size();
        public:virtual size_t v_tablulation_size();      
        /** Control Character Handlers **/
        
        protected:virtual int on_ASCII_NUL();
        protected:virtual int on_ASCII_StartOfHeading();
        protected:virtual int on_ASCII_StartOfText();
        protected:virtual int on_ASCII_EndOfText();
        protected:virtual int on_ASCII_EndOfTransmission();
        protected:virtual int on_ASCII_Enquiry();
        protected:virtual int on_ASCII_Acknowledge();
        protected:virtual int on_ASCII_Bell();
        protected:virtual int on_ASCII_Backspace();
        protected:virtual int on_ASCII_H_Tabulation();
        protected:virtual int on_ASCII_LineFeed();
        protected:virtual int on_ASCII_V_Tabulation();
        protected:virtual int on_ASCII_FormFeed();
        protected:virtual int on_ASCII_CarriageReturn();
        protected:virtual int on_ASCII_ShiftOut();
        protected:virtual int on_ASCII_ShiftIn();
        protected:virtual int on_ASCII_DataLinkEscape();
        protected:virtual int on_ASCII_DeviceControl1();
        protected:virtual int on_ASCII_DeviceControl2();
        protected:virtual int on_ASCII_DeviceControl3();
        protected:virtual int on_ASCII_DeviceControl4();
        protected:virtual int on_ASCII_NegativeAcknowledge();
        protected:virtual int on_ASCII_SynchronousIdle();
        protected:virtual int on_ASCII_EndOfTransmissionBlock();
        protected:virtual int on_ASCII_Cancel();
        protected:virtual int on_ASCII_EndOfMedium();
        protected:virtual int on_ASCII_Substitute();
        protected:virtual int on_ASCII_Escape();
        protected:virtual int on_ASCII_FileSeparator();
        protected:virtual int on_ASCII_GroupSeparator();
        protected:virtual int on_ASCII_RecordSeparator();
        protected:virtual int on_ASCII_UnitSeparator();
        protected:virtual int on_ASCII_Delete();
        public:virtual int put_at(int, char);
        public:virtual int put_at(size_xy, char);
        public:virtual int index_at(size_xy);
        /** Place an individual character onto the TTY.
         * This should also advance the cursor. 
         * @returns 0 or 1; 1 if the character is "visible" 
         *                  or 0 if it was an unprintable "control"
         *                  character.
         * @note: For extenders of abstract tty; this routine is all that
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
         * number returned by `put`; which corrisponds to the total
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
        /**
         * @brief advance the cursor to the next line
         * 
         */
        public:virtual int newline();
        /**
         * @brief return the cursor to the beginning of the line 
         */
        public:virtual int returnline();

    };
}
#endif