#ifndef libBQ_XY_hpp
#define libBQ_XY_hpp 1
#include <sys/types.h>
namespace BQ {
    template<typename Dimension>
    struct XY {
        Dimension x, y;
    };
    typedef XY<size_t> size_xy;
    typedef XY<int8_t> int8_xy;
    typedef XY<int16_t> int16_xy;
    typedef XY<int32_t> int32_xy;
    typedef XY<double> double_xy;
    typedef XY<float> float_xy;
    typedef XY<long> long_xy;
}
#endif