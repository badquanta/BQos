#LIBBQ.mk
#	Created on: Jan 11, 2020
#		Author: badquanta
include MAKE/dirs.conf.mk
include MAKE/common.conf.mk
include MAKE/all.conf.mk
include MAKE/kernels.conf.mk
LIBBQ_GPPFLAGS			:= $(KERNEL_CFLAGS)
LIBBQ_HPP_SRC_DIR		:= $(REPO_DIR)include/libbq
LIBBQ_CPP_SRC_DIR		:= $(REPO_DIR)src/libbq
LIBBQ_C_SRC_DIR			:= $(REPO_DIR)src/libbq
LIBBQ_HPP_DST_DIR		:= $(SYSROOT)/usr/include/libbq
LIBBQ_H_DST_DIR			:= $(SYSROOT)/usr/include/libbq
LIBBQ_DST_DIR			:= $(SYSROOT)/lib/libbq
LIBBQ_DST				:= $(LIBBQ_DST_DIR)/libbq.a
LIBBQ_CPP_SRCS			:= $(wildcard $(LIBBQ_CPP_SRC_DIR)/**.cpp)
LIBBQ_C_SRCS			:= $(wildcard $(LIBBQ_C_SRC_DIR)/*.c )
LIBBQ_OBJS				:= $(LIBBQ_CPP_SRCS:$(LIBBQ_CPP_SRC_DIR)/%.cpp=$(LIBBQ_DST_DIR)/%.o)
LIBBQ_OBJS				+= $(LIBBQ_C_SRCS:$(LIBBQ_C_SRC_DIR)/%.c=$(LIBBQ_DST_DIR)/%.o)
LIBBQ_HPP_SRCS			:= $(wildcard $(LIBBQ_HPP_SRC_DIR)/*.hpp)
LIBBQ_HPP_SRCS			+= $(wildcard $(LIBBQ_HPP_SRC_DIR)/*/*.hpp)
LIBBQ_HPP_DST			:= $(LIBBQ_HPP_SRCS:$(LIBBQ_HPP_SRC_DIR)/%.hpp=$(LIBBQ_HPP_DST_DIR)/%.hpp)
ALL_SUFFIXES			+= .hpp
ALL_INCLUDES			+= $(LIBBQ_HPP_DST)
ALL_DEP_FILES			+= $(wildcard $(LIBBQ_DST_DIR)/**.d)
	