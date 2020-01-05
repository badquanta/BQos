#include <BQos/HW/VGA/text_mode.hpp>
using namespace BQos::HW::VGA;

text_mode::text_mode(){
    _screen_size={80,25};
    _cursor_index=0;
    buffer = (text_mode_cell*)0xB8000;
}

text_mode::~text_mode(){

}

int32_xy text_mode::screen_size(){
    return _screen_size;
}
int32_xy text_mode::screen_size(int32_xy){
    //TODO: Not current redefinable.
    return screen_size();
}
int text_mode::cursor_index(){
    return _cursor_index;
}

int32_xy text_mode::cursor_position(){
  return {(_cursor_index % _screen_size.x), (_cursor_index / _screen_size.x)};
}

int32_xy text_mode::cursor_position(int32_xy position){
  _cursor_index = index_at(position);
  return cursor_position();
}

int text_mode::cursor_index(int new_index){
    _cursor_index = new_index;
    return _cursor_index;
}

int text_mode::put_at(int idx, char c){
    if(a_tty::put_at(idx, c)){
        buffer[idx].txt=c;
        return 1;
    } else return 0;
}

int text_mode::max_index(){
    return screen_size().x*screen_size().y;
}
