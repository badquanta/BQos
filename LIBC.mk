include ALL.mk
include DIRS.mk
LIBC_BUILD_DIR	:= $(SYSROOT)/usr/lib
LIBC_SRC_DIR	:= $(REPO_SRC)/libc
LIBC_INC_DIR	:= $(REPO_INC)
# TODO: LIBC_TST_DIR		:= $(PREFIX)/tests
LIBK_BUILD_DIR	:= $(XBUILD_DIR)/libk
include COMMON.mk
LIBC_GCFLAGS				:=	$(PROJECT_GCFLAGS)
LIBC_TEST_FLAGS				:=	$(PROJECT_CFLAGS)
LIBC_DST			:= $(LIBC_BUILD_DIR)/libc.a
LIBC_C_SRCS			:= $(wildcard $(LIBC_SRC_DIR)/*.c)
LIBC_C_SRCS			+= $(wildcard $(LIBC_SRC_DIR)/*/*.c)
ALL_SUFFIXES				+= .c
LIBC_S_SRCS			:= $(wildcard $(LIBC_SRC_DIR)/*.s)
LIBC_S_SRCS			+= $(wildcard $(LIBC_SRC_DIR)/*/*.s)
ALL_SUFFIXES				+= .s
LIBC_H_SRCS			:= $(wildcard $(LIBC_INC_DIR)/*.h)
LIBC_H_SRCS			+= $(wildcard $(LIBC_INC_DIR)/*/*.h)
ALL_SUFFIXES				+= .h
LIBC_H_DST			:= $(LIBC_H_SRCS:$(LIBC_INC_DIR)/%.h=$(SYS_INC)/%.h)

ALL_INCLUDES		+= $(LIBC_H_DST)
ALL_DEP_FILES		+= $(wildcard $(LIBC_BUILD_DIR)/**.d)
LIBC_OBJS			:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBC_BUILD_DIR)/%.o)
LIBC_OBJS			+= $(LIBC_S_SRCS:$(LIBC_SRC_DIR)/%.s=$(LIBC_BUILD_DIR)/%.o)
ALL_OBJS			+= $(LIBC_OBJS)
ALL_SUFFIXES		+= .o





