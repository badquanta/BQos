/**
 * BQos Project
 * WARNING: DO NOT USE THIS PROJECT; NOT FIT FOR ANY PURPOSE; MAY DAMAGE SYSTEMS.
 * GNU-GPLv3
 * For self educational purposes.
 */
/*
 * MemoryManager.hpp
 *
 *  Created on: Dec 27, 2019
 *      Author: badquanta
 */

#ifndef SYSTEM_BQOS_MEMORY_HPP_
#define SYSTEM_BQOS_MEMORY_HPP_
#include <sys/types.h>
#include <stddef.h>
namespace BQ {
/**
 * Individual chunk of managed memory.
 * next prev should be continuous regions
 * as chunks are apt to be merged.
 */
struct memory_chunk {
	memory_chunk
	/** Pointer to the next contiguous  chunk of memory. **/
	*next,
	/** Pointer to previous contiguous chunk of memory. **/
	*previous;

	bool
	/** true if this memory chunk is occupied/used; false if available. **/
	allocated;
	size_t
	/** size in bytes of this particular chunk. **/
	size;
};
// Forward declaration for `MemoryRegion`'s use.
class Memory;
/**
 * This handles a continuous chunk of memory.
 * It has a reference to the next chunk of managed memory.
 */

class MemoryRegion {
	/** `MemoryRegion` allows `Memory` access to protected fields. **/
	friend Memory;
protected:
	/** Next logical region of memory. @note may not be in physical order. **/
	MemoryRegion *next { NULL };
	/** This is a pointer to the first chunk within the memory region.
	 * at first this will be the entire region; until malloc begins to
	 * break it up into smaller chunks.
	 * free _should_ piece together adjacent chunks that have been freed.
	 * @note the total of all chunks should equal the size of this region.
	 **/
	memory_chunk *chunks;
public:
	/**
	 * @brief Construct a new Memory Region object
	 *
	 * @param start memory address of the start of this region
	 * @param length length in bytes of this memory region to manage.
	 */
	MemoryRegion(size_t start, size_t length);
	/**
	 * @brief Destroy the Memory Region object
	 *
	 */
	~MemoryRegion();
	/**
	 * @brief Allocate from `chunks` a sub-chunk and return a pointer
	 * to that allocated space.
	 *
	 * @param size required size of memory chunk
	 * @return void* pointer to start of useable memory
	 */
	void* malloc(size_t size);
	/**
	 * @brief Deallocate (and defragment adjacently available) `chunks` of memory.
	 * previously allocated.
	 *
	 * @param ptr a pointer that was previously allocated.
	 */
	void free(void *ptr);
};
/**
 * A class that manages a collection of
 * `MemoryChunkManager`s
 */
class Memory {
public:
	/**
	 * @brief Defines the first logical memory region managed.
	 * @note It's good to define at boot a static section of memory that
	 * can be used right away before actually memory limits are discovered
	 */
	static MemoryRegion *first;
	/**
	 * @brief appends another memory region to be managed by this class.
	 * @param memRegPtr a pointer to a MemoryRegion instance.
	 */
	static void add(MemoryRegion *memRegPtr);
	/**
	 * @brief "memory allocate" a chunk of memory defined by `size`
	 * and return a pointer to the start of that memory.
	 *
	 * @param size length in bytes required
	 * @return void* pointer to start of usable memory.
	 */
	static void* malloc(size_t size);
	/**
	 * @brief "free"/deallocate memory previously allocated by this
	 * collection.
	 *
	 * @param ptr pointer to start of usable memory allocated by this collection.
	 */
	static void free(void *ptr);
	/**
	 * @brief Construct a new Memory object
	 *
	 */
	Memory(); // Do I need this now?
	/**
	 * @brief Destroy the Memory object
	 *
	 */
	~Memory();
};

} /* namespace BQos */

void* operator new(size_t size);

#endif /* SYSTEM_BQOS_MEMORY_HPP_ */
