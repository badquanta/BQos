#LIBBQ.mk
#	Created on: Jan 11, 2020
#		Author: badquanta
include DIRS.mk
include COMMON.mk
include ALL.mk
include KERNELS.mk
libBQ_GPPFLAGS			:= $(KERNEL_CFLAGS)
libBQ_HPP_SRC_DIR		:= $(REPO_DIR)include/libBQ
libBQ_CPP_SRC_DIR		:= $(REPO_DIR)src/libBQ
libBQ_C_SRC_DIR			:= $(REPO_DIR)src/libBQ
libBQ_HPP_DST_DIR		:= $(SYSROOT)/usr/include/libBQ
libBQ_H_DST_DIR			:= $(SYSROOT)/usr/include/libBQ
libBQ_DST_DIR			:= $(SYSROOT)/lib
libBQ_DST				:= $(libBQ_DST_DIR)/libBQ.a
libBQ_CPP_SRCS			:= $(wildcard $(libBQ_CPP_SRC_DIR)/**/*.cpp)
libBQ_C_SRCS			:= $(wildcard $(libBQ_C_SRC_DIR)/**/*.c)
libBQ_OBJS				:= $(libBQ_CPP_SRCS:$(libBQ_CPP_SRC_DIR)/%.cpp=$(libBQ_DST_DIR)/%.o)
libBQ_OBJS				+= $(libBQ_C_SRCS:$(libBQ_C_SRC_DIR)/%.cpp=$(libBQ_DST_DIR)/%.o)
libBQ_HPP_SRCS			:= $(wildcard $(libBQ_HPP_SRC_DIR)/*.hpp)
libBQ_HPP_SRCS			+= $(wildcard $(libBQ_HPP_SRC_DIR)/*/*.hpp)
libBQ_HPP_DST			:= $(libBQ_HPP_SRCS:$(libBQ_HPP_SRC_DIR)/%.hpp=$(libBQ_HPP_DST_DIR)/%.hpp)
ALL_SUFFIXES			+= .hpp
ALL_INCLUDES			+= $(libBQ_HPP_DST)
ALL_DEP_FILES			+= $(wildcard $(libBQ_DST_DIR)/**.d)
	