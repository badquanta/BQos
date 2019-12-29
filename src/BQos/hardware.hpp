#ifndef BQos_hardware__hpp
#define BQos_hardware__hpp 1
#include <BQos/a_tty.hpp>
namespace BQos {
    /** Abstract class representing common features
     * of different hardware.
     **/
    class hardware {
    	public:virtual ~hardware();
        /** Request an interface to a tty **/
    	public:virtual a_tty *tty(int=0);
    };
}

#endif
