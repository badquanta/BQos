# General top-level settings
# such as what this is called.
PROJECT_NAME    := BQos
# what target environment we are assembling for
XARCH=i386-BQos
# how many paralel jobs can run?
XJOBS=`nproc`
#2
#`nproc`

################################################################### LINK FLAGS
BQos_KERNEL_LINK_FLAGS		:=	-T linker.ld -m32 -O2 -lgcc -nostdlib -ffreestanding
################################################################### GIT SOURCES
BINUTILS_GIT := https://github.com/badquanta/binutils-gdb.git
GCC_GIT := https://github.com/badquanta/gcc.git
################################################################### GIT BRANCHES
BINUTILS_GIT_BRANCH := BQos
GCC_BRANCH := BQos
XALL_SUFFIXES :=
################################################################## DIRECTORIES
# where this is located
PROJECT_SRC_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
# where progress is tracked
TARGETS := $(PROJECT_SRC_DIR)logs
## XPREFIX the folder where everything will be assembled.
XPREFIX ?= $(realpath $(PROJECT_SRC_DIR))/X
## The XPREFIX bin directory; where all cross compilers and binutils will live.
XPATH_DIR 		:= $(XPREFIX)/bin
export PATH		:= $(XPATH_DIR):$(PATH)
XSRC_DIR		:= $(XPREFIX)/$(XARCH)/src
## Where binutils & gcc will be checked out / cloned into:
XBINUTILS_SRC_DIR := $(XSRC_DIR)/binutils
XGCC_SRC_DIR := $(XSRC_DIR)/gcc
## Where bintuils & gcc will be built
## @note XGCC uses this as it's SYSTOOT as well; and expects libc headers to be present.
SYSROOT := $(PROJECT_SRC_DIR)/SYSROOT
#SYSROOT ?= $(XPREFIX)/$(XARCH)/sys-root
XBUILD_DIR		:= $(XPREFIX)/$(XARCH)/build
XBUILD_GCC		:= $(XBUILD_DIR)/gcc
XBUILD_BINUTILS := $(XBUILD_DIR)/binutils
LIBC_BUILD_DIR	:= $(SYSROOT)/usr/lib
LIBK_BUILD_DIR	:= $(XBUILD_DIR)/libk
## SYSROOT is the folder that will be made into the boot image root.

#### Start libC Make variables and rules
LIBC_DIR			:= $(PROJECT_SRC_DIR)libc
LIBC_SRC_DIR		:= $(LIBC_DIR)/src

LIBC_TST_DIR		:= $(XPREFIX)/tests
LIBC_INC_DIR		:= $(LIBC_DIR)/include
LIBC_INC_DST_DIR	:= $(SYSROOT)/usr/include
BQos_CPP_SRC_DIR		:= $(PROJECT_SRC_DIR)src
BQos_S_SRC_DIR			:= $(PROJECT_SRC_DIR)src
BQos_HPP_SRC_DIR		:= $(PROJECT_SRC_DIR)src
BQos_DST_DIR			:= $(XPREFIX)/lib
BQos_BOOT				:= $(SYSROOT)/boot
BQos_BOOT_GRUB			:= $(BQos_BOOT)/grub

###################################################################### C FLAGS
PROJECT_GCFLAGS := \
	-fno-omit-frame-pointer \
	-Wall \
	-static \
	-Wextra \
	-pedantic \
	-Wshadow \
	-Wpointer-arith \
	-Wcast-align \
	-Wwrite-strings \
	-Wmissing-declarations \
	-Wredundant-decls \
	-Winline \
	-Wno-long-long \
	-Wconversion \
	-Wno-write-strings
LIBC_GCFLAGS				:=	$(PROJECT_GCFLAGS) \
								-MD
LIBC_TEST_FLAGS				:=	$(PROJECT_CFLAGS)
BQos_GCFLAGS			:= $(PROJECT_GCFLAGS)
BQos_GCFLAGS				+=\
								-I$(PROJECT_SRC_DIR) \
								-fno-leading-underscore \
								-fcheck-new \
								-fno-use-cxa-atexit \
								-nostdlib \
								-fno-rtti \
								-fno-exceptions

BQos_GASFLAGS			:= $(PROJECT_GASFLAGS)							
################################################################### FILES $(XPATH_DIR))
XAR				:= $(XPATH_DIR)/$(XARCH)-ar
XAS				:= $(XPATH_DIR)/$(XARCH)-as
XBINUTILS_TARGETS:= $(XAR) $(XAS)
XGPP			:= $(XPATH_DIR)/$(XARCH)-g++
XGCC			:= $(XPATH_DIR)/$(XARCH)-gcc
XGCC_TARGETS	:= $(XGPP) $(XGCC)
############################################################# $(XSRC_DIR)/<xyz>/Makefile
XBINUTILS_MAKEFILE := $(XBUILD_BINUTILS)/Makefile
XGCC_MAKEFILE := $(XBUILD_GCC)/Makefile


############################################################# ./configure PARAMS
XBINUTILS_CONFIGURE_PARAMS:= \
									--target=$(XARCH) \
									--prefix="$(XPREFIX)" \
									--with-sysroot="$(SYSROOT)" \
									--disable-werror
# 									--disable-nls									
XGCC_CONFIGURE_PARAMS := \
									--target=$(XARCH)\
									--prefix="$(XPREFIX)"\
									--with-sysroot=$(SYSROOT)  \
									--with-sysroot-build=$(XARCH) \
									--with-newlib \
									--enable-languages=c,c++
#									--disable-nls \
									--disable-bootstrap \
									--disable-multilib \
									
									
LIBC_DST			:= $(LIBC_BUILD_DIR)/libc.a
LIBK_DST			:= $(LIBK_BUILD_DIR)/libk.a
XALL_SUFFIXES       += .a

XBINUTILS_CONFIGURE_TARGET	:= $(TARGETS)/xbinutils-configure.tag
XBINUTILS_MAKE_TARGET 		:= $(TARGETS)/xbinutils-make.tag
XBINUTILS_INSTALL_TARGET	:= $(TARGETS)/xbinutils-install.tag
XGCC_CONFIGURE_TARGET		:= $(TARGETS)/xgcc-configure.tag
XGCC_MAKE_INSTALL_TARGET	:= $(TARGETS)/xgcc-make-install.tag
XSTDCPP_MAKE_INSTALL_TARGET 		:= $(TARGETS)/stdcpp-make-install.tag
XALL_SUFFIXES				+= .tag
############################################# *.c
LIBC_C_SRCS			:= $(wildcard $(LIBC_SRC_DIR)/*.c)
LIBC_C_SRCS			+= $(wildcard $(LIBC_SRC_DIR)/*/*.c)
XALL_SUFFIXES				+= .c
############################################# *.cpp
BQos_CPP_SRCS		:= $(wildcard $(BQos_CPP_SRC_DIR)/*.cpp)
BQos_CPP_SRCS		+= $(wildcard $(BQos_CPP_SRC_DIR)/*/*.cpp)
BQos_CPP_SRCS		+= $(wildcard $(BQos_CPP_SRC_DIR)/*/*/*.cpp)
BQos_CPP_SRCS		+= $(wildcard $(BQos_CPP_SRC_DIR)/*/*/*/*.cpp)
XALL_SUFFIXES		+= .cpp
############################################# *.s
LIBC_S_SRCS			:= $(wildcard $(LIBC_SRC_DIR)/*.s)
LIBC_S_SRCS			+= $(wildcard $(LIBC_SRC_DIR)/*/*.s)
BQos_S_SRCS			:= $(wildcard $(BQos_S_SRC_DIR)/*.s)
BQos_S_SRCS			+= $(wildcard $(BQos_S_SRC_DIR)/*/*.s)
BQos_S_SRCS			+= $(wildcard $(BQos_S_SRC_DIR)/*/*/*.s)
BQos_S_SRCS			+= $(wildcard $(BQos_S_SRC_DIR)/*/*/*/*.s)
XALL_SUFFIXES				+= .s
############################################# *.h
LIBC_H_SRCS			:= $(wildcard $(LIBC_INC_DIR)/*.h)
LIBC_H_SRCS			+= $(wildcard $(LIBC_INC_DIR)/*/*.h)
LIBC_H_DST			:= $(LIBC_H_SRCS:$(LIBC_INC_DIR)/%.h=$(LIBC_INC_DST_DIR)/%.h)
XALL_SUFFIXES		+= .h
############################################# *.hpp
BQos_HPP_SRCS		:= $(wildcard $(BQos_HPP_SRC_DIR)/*.hpp)
BQos_HPP_SRCS		+= $(wildcard $(BQos_HPP_SRC_DIR)/*/*.hpp)
BQos_HPP_SRCS		+= $(wildcard $(BQos_HPP_SRC_DIR)/*/*/*.hpp)
BQos_S_SRCS			+= $(wildcard $(BQos_S_SRC_DIR)/*/*/*/*/*.s)
XALL_SUFFIXES		+= .hpp
############################################# *.o
LIBC_OBJS			:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBC_BUILD_DIR)/%.o)
LIBC_OBJS			+= $(LIBC_S_SRCS:$(LIBC_SRC_DIR)/%.s=$(LIBC_BUILD_DIR)/%.o)
BQos_OBJS			:= $(BQos_CPP_SRCS:$(BQos_CPP_SRC_DIR)/%.cpp=$(BQos_DST_DIR)/%.o)
BQos_OBJS			+= $(BQos_S_SRCS:$(BQos_S_SRC_DIR)/%.s=$(BQos_DST_DIR)/%.o)
XALL_SUFFIXES		+= .o
############################################# *.libk
LIBK_OBJS			:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBK_BUILD_DIR)/%.libk)
LIBK_OBJS			+= $(LIBC_S_SRCS:$(LIBC_SRC_DIR)/%.s=$(LIBK_BUILD_DIR)/%.libk)
XALL_SUFFIXES		+= .libk
############################################# *.t
LIBC_TST_OBJS		:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBC_TST_DIR)/%.t)
XALL_SUFFIXES		+= .t
############################################# *_TEST
# executable test programs for libc; each libc implementation file should have a test routine
# built in.
LIBC_TESTS			:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBC_TST_DIR)/%_TEST)
XALL_SUFFIXES				+= _TEST
############################################# .kernel(s)
BQos_BOOT_KERNEL			:= $(BQos_BOOT)/$(XARCH).kernel
XALL_SUFFIXES				+= .kernel
############################################# .iso(s)
BQos_ISO:= $(XPREFIX).iso
XALL_SUFFIXES				+= .iso
BQos_BOOT_GRUB_CONFIG := $(BQos_BOOT_GRUB)/grub.cfg
################################################################### MACROS
# Some macros used for debugging/output/status.
UPDATE_STATUS := ##make update-status-svg
REDIRECT := #| cat 2>&1 >>
## ^ OR v  ##
#REDIRECT := 2>&1 | tee --output-error=warn -a
################################################################### TARGET COLLECTIONS
# This is where all the "default" targets will be collected; to be
# referenced later in `Makefile`
XALL_DEFAULTS :=
# This is where all the "PHONY" targets will be collected; to be
# referenced later in `Makefile`
XALL_PHONY := default all clean clean-all
GIT_SHALLOW		:= git clone --depth 1 --single-branch --branch