#ifndef BQos_hardware__hpp
#define BQos_hardware__hpp 1
#include <libBQ/a_tty.hpp>
namespace BQos {
    /** Abstract class representing common features
     * of different hardware.
     **/
    class hardware {        
        protected:static hardware* active;
        public:static hardware* get_active();
    	public:virtual ~hardware();
        /** Request an interface to a tty **/
    	public:virtual BQ::a_tty *tty(int=0);
    };
}
#endif
