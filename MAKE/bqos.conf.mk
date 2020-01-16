include MAKE/dirs.conf.mk
BQos_CPP_SRC_DIR		:= $(REPO_DIR)src/BQos
BQos_S_SRC_DIR			:= $(REPO_DIR)src/BQos
BQos_HPP_SRC_DIR		:= $(REPO_DIR)include/BQos
BQos_HPP_DST_DIR		:= $(SYSROOT)/usr/include/BQos
BQos_DST_DIR			:= $(PREFIX)/lib
BQos_BOOT				:= $(SYSROOT)/boot
BQos_BOOT_GRUB			:= $(BQos_BOOT)/grub
#include MAKE/common.conf.mk
include MAKE/kernels.conf.mk
BQos_GCFLAGS				:= $(KERNEL_CFLAGS)
BQos_GASFLAGS				:= $(PROJECT_GASFLAGS)							
BQos_KERNEL_LINK_FLAGS		:=	-T linker.ld -m32 -O2 -lgcc -nostdlib -ffreestanding
BQos_CPP_SRCS		:= $(wildcard $(BQos_CPP_SRC_DIR)/*.cpp)
BQos_CPP_SRCS		+= $(wildcard $(BQos_CPP_SRC_DIR)/*/*.cpp)
BQos_CPP_SRCS		+= $(wildcard $(BQos_CPP_SRC_DIR)/*/*/*.cpp)
BQos_CPP_SRCS		+= $(wildcard $(BQos_CPP_SRC_DIR)/*/*/*/*.cpp)
ALL_SUFFIXES		+= .cpp
BQos_S_SRCS			:= $(wildcard $(BQos_S_SRC_DIR)/*.s)
BQos_S_SRCS			+= $(wildcard $(BQos_S_SRC_DIR)/*/*.s)
BQos_S_SRCS			+= $(wildcard $(BQos_S_SRC_DIR)/*/*/*.s)
BQos_S_SRCS			+= $(wildcard $(BQos_S_SRC_DIR)/*/*/*/*.s)
ALL_SUFFIXES		+= .s
BQos_HPP_SRCS		:= $(wildcard $(BQos_HPP_SRC_DIR)/*.hpp)
BQos_HPP_SRCS		+= $(wildcard $(BQos_HPP_SRC_DIR)/*/*.hpp)
BQos_H_SRCS			+= $(wildcard $(BQos_HPP_SRC_DIR)/**/*.h)
BQos_HPP_SRCS		+= $(wildcard $(BQos_HPP_SRC_DIR)/*/*/*.hpp)
BQos_S_SRCS			+= $(wildcard $(BQos_S_SRC_DIR)/*/*/*/*/*.s)
BQos_HPP_DST		:= $(BQos_HPP_SRCS:$(BQos_HPP_SRC_DIR)/%.hpp=$(BQos_HPP_DST_DIR)/%.hpp)
BQos_H_DST			:= $(BQos_H_SRCS:$(BQos_HPP_SRC_DIR)/%.h=$(BQos_HPP_DST_DIR)/%.h)
ALL_INCLUDES		+= $(BQos_HPP_DST)
ALL_INCLUDES 		+= $(BQos_H_DST)
BQos_OBJS			:= $(BQos_CPP_SRCS:$(BQos_CPP_SRC_DIR)/%.cpp=$(BQos_DST_DIR)/%.o)
BQos_OBJS			+= $(BQos_S_SRCS:$(BQos_S_SRC_DIR)/%.s=$(BQos_DST_DIR)/%.o)
ALL_SUFFIXES		+= .o
ALL_OBJS			+= $(BQos_OBJS)
ALL_CLEAN			+= $(BQos_OBJS)
ALL_DEP_FILES		+= $(wildcard $(BQos_DST_DIR)/**.d)
############################################# .kernel(s)
BQos_BOOT_KERNEL			:= $(BQos_BOOT)/$(ARCH).kernel
ALL_SUFFIXES				+= .kernel
# TODO: Test/diagnostic kernels.
############################################# .iso(s)
BQos_ISO:= $(PREFIX).iso
ALL_SUFFIXES				+= .iso
BQos_BOOT_GRUB_CONFIG := $(BQos_BOOT_GRUB)/grub.cfg

