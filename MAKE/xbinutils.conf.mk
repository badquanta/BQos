include MAKE/dirs.conf.mk
BINUTILS_GIT := https://github.com/badquanta/binutils-gdb.git
BINUTILS_GIT_BRANCH := BQos
XBINUTILS_SRC_DIR := $(XSRC_DIR)/binutils
XBUILD_BINUTILS := $(XBUILD_DIR)/binutils
include MAKE/config.mk
XAR				:= $(BINDIR)/$(ARCH)-ar
XAS				:= $(BINDIR)/$(ARCH)-as
XNM				:= $(BINDIR)/$(ARCH)-nm
XBINUTILS_TARGETS:= $(XAR) $(XAS) $(XNM)7777777777777777777


XBINUTILS_MAKEFILE := $(XBUILD_BINUTILS)/Makefile
XBINUTILS_CONFIGURE_PARAMS:= \
									--target=$(ARCH) \
									--prefix="$(PREFIX)" \
									--with-sysroot="$(SYSROOT)" \
									--disable-werror
# These are used to mark the successfull execution of each of these makefile targets.
XBINUTILS_CONFIGURE_TARGET	:= $(TARGETS)/xbinutils-configure.target
XBINUTILS_MAKE_TARGET 		:= $(TARGETS)/xbinutils-make.target
XBINUTILS_INSTALL_TARGET	:= $(TARGETS)/xbinutils-install.target
ALL_SUFFIXES				+= .target
#