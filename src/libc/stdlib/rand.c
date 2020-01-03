#include <stdlib.h>
#define SEED_COUNT 10
static int seeds[SEED_COUNT];
static int count=0;
int rand(){
    int current = count++;
    for(int idx=0;idx<SEED_COUNT;idx++){
        current=(!current)|seeds[idx];
    }
    seeds[count%SEED_COUNT]=current;
    return current; // TODO: Rand()
}