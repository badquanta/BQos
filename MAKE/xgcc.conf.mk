include MAKE/dirs.conf.mk
# Where do we get the source?
GCC_GIT := https://github.com/badquanta/gcc.git
# Which branch?
GCC_BRANCH := BQos
# Where do we clone it to?
XGCC_SRC_DIR := $(VPATH)src/gcc
# Where does gcc &etc get built?
XGCC_BUILD_DIR		:= $(XBUILD_DIR)/gcc
include MAKE/config.mk
# Which cross built g++?
XGPP			:= $(BINDIR)/$(ARCH)-g++
# Which cross built gcc?
XGCC			:= $(BINDIR)/$(ARCH)-gcc
# Hrm, kindda seems reductively redundant but following patter from binutils.
XGCC_TARGETS	:= $(XGCC)
XGPP_TARGETS    := $(XGPP)
# 	if XGCC is missing; run XGCC make install target
$(XGCC_TARGETS): $(XGCC_MAKE_INSTALL_TARGET)
#   if XGPP is missing; run XGPP make install target
$(XGPP_TARGETS): $(XGPP_MAKE_INSTALL_TARGET)
#	this is where configure will put the make file
#	TODO: Make sure we don't refer to this and maybe remove it?
XGCC_MAKEFILE := $(XGCC_BUILD_DIR)/Makefile
#	When configuring 
XGCC_CONFIGURE_PARAMS := \
						--target=$(ARCH)\
						--prefix="$(PREFIX)"\
						--with-sysroot=$(SYSROOT)  \
						--with-sysroot-build=$(ARCH) \
						--with-newlib \
						--enable-languages=c,c++
#						--disable-nls \
						--disable-bootstrap \
						--disable-multilib
						
XGCC_CONFIGURE_TARGET		:= $(TARGETS)/xgcc-configure.target
XGCC_MAKE_INSTALL_TARGET	:= $(TARGETS)/xgcc-make-install.target
XGPP_MAKE_INSTALL_TARGET 	:= $(TARGETS)/xgpp-make-install.target
ALL_SUFFIXES				+= .target
























