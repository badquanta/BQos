/*
 * hardware.cpp
 *
 *  Created on: Dec 27, 2019
 *      Author: badquanta
 */
#include "BQos/hardware.hpp"
using namespace BQos;

hardware* hardware::active{NULL};

hardware::~hardware(){
    if(hardware::active==this){
        hardware::active = NULL;
        // TODO: An event saying hardware is going offline?
        // on second thought nothing should be alive at this point.
    }
}
a_tty *hardware::tty(int){
	return NULL;
}




#ifdef TEST
extern "C" {
int main(){
    return 1;
}}
#endif