#include <stdlib.h>
#define SEED_COUNT 10
static int seeds[SEED_COUNT];
static int count=0;
int rand(){
    int this = count++;
    for(int idx=0;idx<SEED_COUNT;idx++){
        this=(!this)|seeds[idx];
    }
    seeds[count%SEED_COUNT]=this;
    return this; // TODO: Rand()
}