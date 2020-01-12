/*
 * MemoryManager.hpp
 *
 *  Created on: Dec 27, 2019
 *      Author: badquanta
 */

#ifndef SYSTEM_BQOS_MEMORY_HPP_
#define SYSTEM_BQOS_MEMORY_HPP_
#include <sys/types.h>
namespace BQ {
/**
 * Individual chunk of managed memory.
 * next prev should be continuous regions
 * as chunks are apt to be merged.
 */
struct memory_chunk {
  memory_chunk *next, *previous;
  bool allocated;
  size_t size;
};
// Forward declaration for
class Memory;
/**
 * This handles a continuous chunk of memory.
 * It has a reference to the next chunk of managed memory.
 */
class MemoryRegion {
  friend Memory;
protected:
  MemoryRegion *next { NULL };
protected:
  memory_chunk *chunks;

public:
  MemoryRegion(size_t start, size_t length);
public:
  ~MemoryRegion();

public:
  void* malloc(size_t size);
public:
  void free(void *ptr);
};
/**
 * A class that manages a collection of
 * `MemoryChunkManager`s
 */
class Memory {
public:
  static MemoryRegion *first;
public:
  static void add(MemoryRegion*);
public:
  static void* malloc(size_t size);
public:
  static void free(void *ptr);
public:
  Memory(); // Do I need this now?
public:
  ~Memory();
};

} /* namespace BQos */

void* operator new(size_t size);

#endif /* SYSTEM_BQOS_MEMORY_HPP_ */
