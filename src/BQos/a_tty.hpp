#ifndef BQos_HW_a_tty_hpp
#define BQos_HW_a_tty_hpp 1
#include <libc/types.h>
#include <libBQ/XY.hpp>
#include <BQos/ascii_defs.hpp>
namespace BQos
{
    using namespace BQ;
    class a_tty;
    typedef int (*ASCII_ControlChar_handler_t)(a_tty *);
    int ASCII_LineFeed_handler(a_tty*);
    int ASCII_CarriageReturn_handler(a_tty*);
    /**
     * Provide a generic interface to different "teletype"
     * devices.  While intended to be the abstract interface,
     * this base class also happens to instantiate useful
     * "NULL" ttys that are safe to dump data to but
     *
     * @note all data written will be lost; unless extended.
     **/
    class a_tty
    {
        protected:ASCII_ControlChar_handler_t line_discipline[0x20]{NULL};
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
        public:virtual int32_xy screen_size();
        /**
         * @brief Get the `size_t` index of the current cursor.
         *
         */
        public:virtual int cursor_index();
        /**
         * @brief Attempt to change where the cursor is
         * @note may not work; depending on actually tty device
         * @returns actual index location of cursor.
         *
         */
        public:virtual int cursor_index(int);
        /**
         * \overload int a_tty::cursor_index()
         * @brief Attempt to change the cursor relative to it's
         * current location.
         * @note may not actually work; should return 0 to indicate.
         * @returns actually distance location moved.
         *
         */
        public:virtual signed int cursor_move(signed int);
        /**
         * @brief query the position of the tty cursor.
         *
         */
        public:virtual int32_xy cursor_position();
        /**
         * @brief attempt to set the position of the tty cursor;
         * @returns the actuall value of the cursor position after the attempt.
         * @note may be ignored
         * @note may be clipped to nearest valid position
         */
        public:virtual int32_xy cursor_position(int32_xy);
        /**
         * @brief Defines if printing order is "ABCDEF"...-> (true) or <-..."FEDCBA" (false)
         */
        public:virtual bool left_to_right();
        /**
         * @brief Attempts to set the printing order.
         * @note May not be supported.
         * @param  desired setting
         * @returns actual setting
         */
        public:virtual bool left_to_right(bool);
        /**
         * @brief The inverse of `left_to_right()`
         * @note Controlled via `left_to_right(bool)`
         */
        public:virtual bool right_to_left();
        /** @brief Does the text scroll upwards towards Y=0 or away from Y=0?**/
        public:virtual bool line_feeds_up();
        /** @brief Does the text scroll upwards towards Y=0 or away from Y=0?**/
        public:virtual bool line_feeds_down();
        /** How wide are tabulations on this TTY? */
        public:virtual int h_tabulation_size();
        /** How wide are vertical tabulations on this TTY? */
        public:virtual int v_tabulation_size();
        /**
         * @brief Place a character at a certain linear `size_t` index in the tty buffer.
         * @note This does not interpret the character; it simply places whatever value
         * specified by the `char` into the tty buffer.
         */
        public:virtual int put_at(int, char);
        /**
         * @brief Place a character at a certain `int32_xy` position within the tty buffer.
         * @note the `position` may be clipped if outside of the `screen_size()` of the buffer.
         */
        public:virtual int put_at(int32_xy, char);
        /**
         * @brief Convert a `int32_xy` 2D position into a `size_t` linear index.
         * @note for each point within `{0,0}` & `screen_size()` will have a unique
         * value between 0 & the length of the tty buffer indexes.
         * @note this will return -1 if the int32_xy value is greater than `screen_size()`
         * or has either negative X or Y.
         * @return {int} index of xy position in tty linear buffer. `-1` if clipped.
         */
        public:virtual int index_at(int32_xy);
        /**
         * @brief Declares if a particular index is valid or invalid.
         * @note indexes should start at 0; so -1 should be a save value for invalids.
         * @note indexes generally have a maximum value as well.
         */
        public:virtual bool valid_index(int index);
        /**
         * @brief Declares the Min Index.
         *
         *
         */
        public:virtual int min_index();
        public:virtual int max_index();
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
