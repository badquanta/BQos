include MAKE/all.conf.mk
include MAKE/dirs.conf.mk
LIBC_BUILD_DIR	:= $(SYSROOT)/usr/lib
LIBC_SRC_DIR	:= $(REPO_SRC)/libc
LIBC_INC_DIR	:= $(REPO_INC)libc
# TODO: LIBC_TST_DIR		:= $(PREFIX)/tests
LIBK_BUILD_DIR	:= $(XBUILD_DIR)/libk
include MAKE/common.conf.mk
LIBC_GCFLAGS				:=	$(CFLAGS)
LIBC_TEST_FLAGS				:=	$(PROJECT_CFLAGS)
LIBC_DST					:= $(LIBC_BUILD_DIR)/libc.a
LIBC_C_SRCS					:= $(wildcard $(LIBC_SRC_DIR)/**/*.c)
ALL_SUFFIXES				+= .c
LIBC_I386_SRCS				:= $(wildcard $(LIBC_SRC_DIR)/I386/**/*.s)
ALL_SUFFIXES				+= .s
LIBC_H_SRCS					:= $(wildcard $(LIBC_INC_DIR)/*.h)
LIBC_H_SRCS					+= $(wildcard $(LIBC_INC_DIR)/*/*.h)
ALL_SUFFIXES				+= .h
LIBC_H_DST					:= $(LIBC_H_SRCS:$(LIBC_INC_DIR)/%.h=$(SYS_INC)/%.h)

ALL_INCLUDES				+= $(LIBC_H_DST)
ALL_DEP_FILES				+= $(wildcard $(LIBC_BUILD_DIR)/**.d)
LIBC_ALL_OBJS				:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBC_BUILD_DIR)/%.o)
LIBC_I386_OBJS				:= $(LIBC_I386_SRCS:$(LIBC_SRC_DIR)/%.s=$(LIBC_BUILD_DIR)/%.o)
LIBC_OBJS					:= $(LIBC_I386_OBJS) $(LIBC_ALL_OBJS)
ALL_OBJS					+= $(LIBC_OBJS)
ALL_SUFFIXES				+= .o





