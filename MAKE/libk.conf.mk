#LIBK.mk
# libk is the kernel's version of libc; and so inherits a lot of it's
# make definitions from LIBC.mk
# it also uses KERNELS.mk's settings so that it produces kernel-compatable
# objects.
# LIBK objects are differentiated from libc objects by the `libk` extenstion
#	Created on: Jan 11, 2020
#		Author: badquanta
include MAKE/libc.conf.mk
include MAKE/kernels.conf.mk

LIBK_GCFLAGS			:= $(KERNEL_CFLAGS)
LIBK_GCFLAGS			+= -D__is_libk
LIBK_DST				:= $(LIBK_BUILD_DIR)/libk.a
ALL_SUFFIXES			+= .a
LIBK_OBJS				:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBK_BUILD_DIR)/%.libk)
# TODO: Right now we just don't include any assembler sources in the kernel Libk?
#LIBK_OBJS				+= $(LIBC_I386_SRCS:$(LIBC_SRC_DIR)/%.s=$(LIBK_BUILD_DIR)/%.libk)
ALL_SUFFIXES			+= .libk
ALL_OBJS				+= $(LIBK_OBJS)

	
	
	
	