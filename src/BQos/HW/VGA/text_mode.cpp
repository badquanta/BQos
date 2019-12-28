#include <BQos/HW/VGA/text_mode.hpp>
using namespace BQos::HW::VGA;

text_mode::text_mode(){
    _screen_size={80,25};
    _cursor_index=0;
    buffer = (text_mode_cell*)0xB8000;
}

text_mode::~text_mode(){

}

size_xy text_mode::screen_size(){
    return _screen_size;
}
size_xy text_mode::screen_size(size_xy){
    //TODO: Not current redefinable.
    return screen_size();
}
size_t text_mode::cursor_index(){
    return _cursor_index;
}

size_xy text_mode::cursor_position(){
  return {(_cursor_index % _screen_size.x), (_cursor_index / _screen_size.x)};
}

size_xy text_mode::cursor_position(size_xy position){
  _cursor_index = index_at(position);
  return cursor_position();
}

size_t text_mode::cursor_index(size_t new_index){
    _cursor_index = new_index;
    return _cursor_index;
}

int text_mode::put_at(size_t idx, char c){
    if(a_tty::put_at(idx, c)){
        buffer[idx].txt=c;
        return 1;
    } else return 0;
}
