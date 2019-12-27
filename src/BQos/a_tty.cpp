#include <BQos/a_tty.hpp>

using namespace BQos;
/** handle a new line by advancing the cursor position
 * @returns `0`
 ***/  
int a_tty::ASCII_LineFeed_handler::handle(a_tty*tty){
    tty->cursor_position({
        // Set X to start of line
        0,
        // Next line
        tty->cursor_position().y + (tty->line_feeds_up() ? 1 : -1)
    });
    return 0;//Because we handled the move.
}
/**
 * @brief by default will simple set the `cursor_position()`
 * to be at the beginning of the current line (`y` value.)
 * 
 * @param tty* A specific tty to control
 * @return int `0`
 */
int a_tty::ASCII_CarriageReturn_handler::handle(a_tty*tty){
    tty->cursor_position({
        // Start of line
        0,
        // Same line.
        tty->cursor_position().y
    });
    return 0;//Because we handled the move.
}
/** Base implementation will handle ASCII control characters. **/
a_tty::a_tty(){
    line_discipline[ASCII_LineFeed] = &line_feed;
    line_discipline[ASCII_CarriageReturn] = &carriage_return;
    //TODO: Handle other ASCII control characters?    
}

/** Base implementation returns {1,1} always. **/
size_xy a_tty::screen_size(){     return {1,1}; }
/** Base implementation always {0,0}**/
size_xy a_tty::cursor_position(){ return {0,0}; }
/** Base implementation always true **/
bool a_tty::left_to_right(){ return true; }
/** Base implementation cannot change the direction. */
bool a_tty::left_to_right(bool){return left_to_right();}
/** Base implementation always returns !left_to_right() */
bool a_tty::right_to_left(){ return !left_to_right(); }
/** Base implemetnation always returns true (feed up) **/
bool a_tty::line_feeds_up(){return true;}
/** Base implementation always returns !(line_feeds_up())**/
bool a_tty::line_feeds_down(){return !line_feeds_up();}
/** Base implementation always returns 8. **/
size_t a_tty::h_tabulation_size(){return 8;}
/** Base implementation always returns 8. **/
size_t a_tty::v_tabulation_size(){return 8;}
/**
 * @brief Place a character at a particular index.
 * @note Base implementation has no control character handling.
 * @note Base implementation does not actually do anything with value.
 * @note Base implementation tests if index is valid.
 * @returns if `index` is not a `valid_index(index)`
 *              then `0` else `1`
 */
int a_tty::put_at(int index, char value){
    if(valid_index(index))
    {
        return 1;
    }else{
        return 0;
    }
}
/** Base implementation will convert the pos into an index and  then attempt to `put_at(index, value)`.
 * @note `put_at()` may clip invalid positions
 * @param pos  a 2d position to place the character
 * @param value a character to place on the tty
 * @return int the result of `put_at(index,value)`
 */
int a_tty::put_at(size_xy pos, char value){    
    return put_at(index_at(pos), value);
}
/** Base implementation assumes column major ordering:
 * `(y*column_width)+x`
 */
int a_tty::index_at(size_xy pos){    
    if(pos.x < 0 || pos.y < 0) return -1;// Clip anything outside of screen top-left.
    size_xy size = screen_size();
    if(pos.x >= size.x || pos.y >= size.y) return -1;// also outside of bottom-right.
    // Otherwise use basic math to make a unique index for each 2d position.
    return (pos.y*size.x)+pos.x;
}
/** Base implementation assumes only valid index is 0
 */
bool a_tty::valid_index(size_t idx){
    return (0 <= idx) && (idx < 1);
}
/** Base implementation will handle control characters. **/
int a_tty::put(char c){
    if(line_discipline[c]!=NULL){
        return line_discipline[c]->handle(this);
    } else {
        return cursor_move(put_at(cursor_index(),c));
    }
}

/** Base implementation will simply call `put(buf[idx])` for `idx{0..length}`
 * @param *buf A pointer to the start of a char[] array.
 * @param length the length of the char[] array to `put()`
 * @returns the sum of each `put()`
 */
int a_tty::put(const char *buf, size_t length){
    int cnt=0;
    for(size_t idx = 0; idx<length; idx++){
        cnt+=put(buf[idx]);
    }
    return cnt;
}
/** Base implementation will simply call `put(buf[idx])` until buf[idx] == `\0`
 * (aka: `ASCII_NUL`)
 * @param *buf A pointer to the start of a char[] array.
 * @returns the sum of each `put()`
 */
int a_tty::put(const char *buf){
    int cnt=0;
    for(size_t idx = 0; buf[idx]!=ASCII_NUL; idx++){
        cnt+=put(buf[idx]);
    }
    return cnt;
}
