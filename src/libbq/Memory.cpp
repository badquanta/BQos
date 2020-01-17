/*
 * MemoryManager.cpp
 *
 *  Created on: Dec 27, 2019
 *      Author: badquanta
 */

#include <libbq/Memory.hpp>
#include <stddef.h>
namespace BQ {

MemoryRegion::MemoryRegion(size_t start, size_t size){
  if(size<sizeof(memory_chunk)){
    chunks = NULL;
  } else {
    chunks = (memory_chunk*)start;
    chunks->allocated = false;
    chunks->next = NULL;
    chunks->previous = NULL;
    chunks->size = size - sizeof(memory_chunk);
  }
}

MemoryRegion::~MemoryRegion(){
  /** @todo What should we do when a memory region goes away?? **/
  // When could that happen?
  // Should we add a "remove" function to `Memory`?
  // What happens to active pointers? Do we ignore the fact that they might still point here?
}

void *MemoryRegion::malloc(size_t size){
  memory_chunk *result = NULL;
  for(memory_chunk *chunk=chunks;chunk!=NULL&&result==NULL; chunk=chunk->next){
    if(chunk->size > size && !chunk->allocated){// This one big enough?
      result = chunk;// Yup; it'll do.
      //TODO: break; // Why keep looking?  Should we just assign highest first?
    }
  }
  if(result==NULL){
    if(next!=NULL){
      return next->malloc(size);
    } else {
      return NULL; /** @todo HANDLE OUT OF MEMORY ERROR! **/
    }
  }// Either we have a result; or we handled that and returned.
  if(result-> size >=size+sizeof(memory_chunk)+1){
    //Temp will be the fragment left over after this allocation.
    memory_chunk *leftovers =
        // cast to pointer the location of result + the size of our bookkeeping.
        (memory_chunk*)((size_t)result+sizeof(memory_chunk)+size);
    leftovers->allocated = false;
    leftovers->size = result->size - size - sizeof(memory_chunk);
    leftovers->previous = result;
    leftovers->next = result->next;
    if(leftovers->next!=NULL){ // Ensure "next" knows about the new "leftovers"
      leftovers->next->previous = leftovers;
    }
    result->size = size;
    result->next = leftovers;
  }
  result->allocated = true;
  void* allocated = (void*)(((size_t)result)+sizeof(memory_chunk));
  return allocated;
}

void MemoryRegion::free(void* allocate){
  memory_chunk *chunk = (memory_chunk*)((size_t)allocate-sizeof(memory_chunk));
      chunk->allocated = false;
  // collapse chunks..
  while(chunk->previous!=NULL && !chunk->previous->allocated){
    chunk->previous->next = chunk->next;
    chunk->previous->size += chunk->size;
    if(chunk->next!=NULL){
      chunk->next->previous = chunk->previous;
    }
    chunk = chunk->previous;
  }
}

/** Ensure there are no garbage "chunks" **/
MemoryRegion* Memory::first = NULL;

Memory::Memory()
{
  /** @todo Review if we need to initialize anything? **/
}

Memory::~Memory() {
  // TODO Auto-generated destructor stub
}
/** This will add the chunk as the "first" chunk.
 * If this chunk is not NULL; the current first chunk
 * will be set as this chunk's "next" chunk.
 */
void Memory::add(MemoryRegion*region){
  if(region!=NULL){
    region->next=first;
    first=region;
  }
}

void* Memory::malloc(size_t size){
  if(first!=NULL){
    return first->malloc(size);
  } else {
    return NULL; /** @todo Should never return null. **/
  }
}

void Memory::free(void* allocated){
  if(first!=NULL){
    return first->free(allocated);
  } else {
    return;
  }
}

} /* namespace BQos */

void *operator new(size_t size){
  return BQ::Memory::malloc(size);
}

void operator delete(void* allocated){
  return BQ::Memory::free(allocated);
}

/** Todo: Right now I'm ignoring the size specified.*/
void operator delete(void* allocated, size_t){
  /** @todo Should we match the allocated & free sizes? **/
  // Todo: Should we return only part of the allocated size?
  // Todo: What happens if it tries to delete more than it allocated?
  return BQ::Memory::free(allocated);
}


#ifdef TEST
extern "C" {
int main(){
    return 1;
}}
#endif
