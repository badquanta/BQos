PROJECT_SRC_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PROJECT_NAME    := BQos
LOGS_DIR := $(PROJECT_SRC_DIR)logs
include CONFIG.mk
XARCH     ?= i386-elf
.PHONY: all clean-all status-config status-libc libc
all: libc libk # Makefile.svg

PROJECT_DST_DIR ?= $(realpath $(PROJECT_SRC_DIR)..)/BUILD-$(PROJECT_NAME)

SYSROOT ?= $(PROJECT_DST_DIR)/$(XARCH)/sys-root

##### Start Cross (X) Built Binutils, GAS, GCC, and G++
XPREFIX   := $(PROJECT_DST_DIR)

XPATH_DIR := $(XPREFIX)/bin
XBINUTILS_BUILD_DIR := $(XPREFIX)/build/binutils
XBINUTILS_SRC_DIR := $(XPREFIX)/src/binutils
XBINUTILS_MAKEFILE := $(XBINUTILS_BUILD_DIR)/Makefile
BINUTILS_GIT := git://sourceware.org/git/binutils-gdb.git
BINUTILS_GIT_BRANCH := binutils-2_33_1
XBINUTILS_CONFIGURE_PARAMS:= \
		--target=$(XARCH) \
		--prefix="$(XPREFIX)" \
		--with-sysroot="$(SYSROOT)" \
		--disable-nls \
		--disable-werror
XBINUTILS_CONFIGURE_LOG := $(LOGS_DIR)/xbinutils-configure.log
XBINUTILS_MAKE_LOG := $(LOGS_DIR)/xbinutils-make.log
XBINUTILS_INSTALL_LOG := $(LOGS_DIR)/xbinutils-install.log
XAR				:= $(XPATH_DIR)/$(XARCH)-ar
XAS				:= $(XPATH_DIR)/$(XARCH)-as
GIT_SHALLOW		:= git clone --depth 1 --single-branch --branch

$(XBINUTILS_SRC_DIR):
	$(GIT_SHALLOW) $(BINUTILS_GIT_BRANCH)  $(BINUTILS_GIT) $(XBINUTILS_SRC_DIR)

xbinutils-configure $(XBINUTILS_CONFIGURE_LOG) $(XBINUTILS_MAKEFILE): $(LOGS_DIR) $(XBINUTILS_BUILD_DIR) $(XBINUTILS_SRC_DIR) CONFIG.mk $(LOGS_DIR)
	rm -f $(XBINUTILS_CONFIGURE_LOG)
	cd $(XBINUTILS_BUILD_DIR) && $(XBINUTILS_SRC_DIR)/configure $(XBINUTILS_CONFIGURE_PARAMS) 2>&1 | tee --output-error\=warn -a $(XBINUTILS_CONFIGURE_LOG)
	@echo "XBINUTILS configured"
xbinutils-make $(XBINUTILS_MAKE_LOG): $(XBINUTILS_MAKEFILE)
	rm -f $(XBINUTILS_MAKE_LOG)
	cd $(XBINUTILS_BUILD_DIR) && make -j $(XJOBS) 2>&1 | tee --output-error=warn -a $(XBINUTILS_MAKE_LOG)
xbinutils-install $(XBINUTILS_INSTALL_LOG): $(XBINUTILS_MAKE_LOG)
	cd $(XBINUTILS_BUILD_DIR) && make install 2>&1 | tee --output-error=warn -a $(XBINUTILS_INSTALL_LOG)
	touch $(XAR) $(XAS)
	@echo "XBINUTILS installed"
$(XAR) $(XAS): #$(XBINUTILS_INSTALL_LOG)
##### Start Cross (X) Built GCC/G++
GCC_GIT := https://github.com/badquanta/gcc.git
GCC_BRANCH := gcc-9_2_0-release
XGCC_BUILD_DIR := $(XPREFIX)/build/gcc
XGCC_SRC_DIR := $(XPREFIX)/src/gcc
XGCC_MAKEFILE := $(XGCC_BUILD_DIR)/Makefile
XGCC_CONFIGURE_PARAMS := \
			--target=$(XARCH)\
			--prefix="$(XPREFIX)"\
			--with-sysroot=$(SYSROOT)  \
			--with-sysroot-build=$(XARCH) \
			--disable-nls \
			--disable-bootstrap \
			--disable-multilib \
			--with-newlib \
			--enable-languages=c,c++
XGCC_CONFIGURE_LOG := $(LOGS_DIR)/xgcc-configure.log
XGCC_MAKE_LOG := $(LOGS_DIR)/xgcc-make.log
XGCC_INSTALL_LOG := $(LOGS_DIR)/xgcc-install.log
XGPP       := $(XPATH_DIR)/$(XARCH)-gpp
XGCC       := $(XPATH_DIR)/$(XARCH)-gcc


$(XGPP) $(XGCC): $(XGCC_INSTALL_LOG)

$(XGCC_SRC_DIR):
	$(GIT_SHALLOW) $(GCC_BRANCH) $(GCC_GIT) $(XGCC_SRC_DIR)

xgcc-configure $(XGCC_MAKEFILE) $(XGCC_CONFIGURE_LOG): libc-dst-h $(XBINUTILS_INSTALL_LOG) $(XGCC_BUILD_DIR) $(XGCC_SRC_DIR) CONFIG.mk $(LOGS_DIR)
	rm -f $(XGCC_CONFIGURE_LOG)
	cd $(XGCC_BUILD_DIR) && $(XGCC_SRC_DIR)/configure $(XGCC_CONFIGURE_PARAMS) 2>&1 | tee --output-error=warn -a $(XGCC_CONFIGURE_LOG)
	@echo "XGCC Configured."

xgcc-make $(XGCC_MAKE_LOG):  $(XGCC_MAKEFILE) 
	rm -f $(XGCC_MAKE_LOG)
	cd $(XGCC_BUILD_DIR) && make all-gcc -j $(XJOBS) 2>&1 | tee --output-error=warn -a $(XGCC_MAKE_LOG)
	cd $(XGCC_BUILD_DIR) && make all-target-libgcc -j $(XJOBS) 2>&1 | tee --output-error=warn -a $(XGCC_MAKE_LOG)
	cd $(XGCC_BUILD_DIR) && make all-target-libstdc++-v3 -j $(XJOBS) 2>&1 | tee --output-error=warn -a $(XGCC_MAKE_LOG)
	@echo "XGCC Built."
xgcc-install $(XGCC_INSTALL_LOG):  $(XGCC_MAKE_LOG) 
	rm -f $(XGCC_INSTALL_LOG)
	cd $(XGCC_BUILD_DIR) && make install-gcc 2>&1 | tee --output-error=warn -a $(XGCC_INSTALL_LOG)
	cd $(XGCC_BUILD_DIR) && make install-target-libgcc 2>&1 | tee --output-error=warn -a $(XGCC_INSTALL_LOG)
	cd $(XGCC_BUILD_DIR) && make install-target-libstdc++-v3 2>&1 | tee --output-error=warn -a $(XGCC_INSTALL_LOG)
	touch $(XGPP) $(XGCC)
	@echo "XGCC Installed."
##### Start libC Make variables and rules
LIBC_DIR			:= $(PROJECT_SRC_DIR)libc
LIBC_SRC_DIR		:= $(LIBC_DIR)/src
LIBC_DST_DIR		:= $(SYSROOT)/lib
LIBC_DST			:= $(LIBC_DST_DIR)/libc.a
LIBK_DST			:= $(LIBC_DST_DIR)/libk.a
LIBC_INC_DIR		:= $(LIBC_DIR)/include
LIBC_INC_DST_DIR	:= $(SYSROOT)/usr/include
LIBC_C_SRCS			:= $(wildcard $(LIBC_SRC_DIR)/*.c)
LIBC_C_SRCS			+= $(wildcard $(LIBC_SRC_DIR)/*/*.c)
LIBC_S_SRCS			:= $(wildcard $(LIBC_SRC_DIR)/*.s)
LIBC_S_SRCS			+= $(wildcard $(LIBC_SRC_DIR)/*/*.s)
LIBC_H_SRCS			:= $(wildcard $(LIBC_INC_DIR)/*.h)
LIBC_H_SRCS			+= $(wildcard $(LIBC_INC_DIR)/*/*.h)
LIBC_OBJS			:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBC_DST_DIR)/%.o)
LIBC_OBJS			+= $(LIBC_S_SRCS:$(LIBC_SRC_DIR)/%.s=$(LIBC_DST_DIR)/%.o)
LIBK_OBJS			:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBC_DST_DIR)/%.libk)
LIBK_OBJS			+= $(LIBC_S_SRCS:$(LIBC_SRC_DIR)/%.s=$(LIBC_DST_DIR)/%.libk)
LIBC_H_DST			:= $(LIBC_H_SRCS:$(LIBC_INC_DIR)/%.h=$(LIBC_INC_DST_DIR)/%.h)
libc-dst-h: $(LIBC_H_DST)
##### how to make sysroot libc headers
$(LIBC_INC_DST_DIR)/%.h : $(LIBC_INC_DIR)/%.h
	@mkdir -p $(@D)
	cp -f $< $@
##### how to make sysroot libc objects
$(LIBC_DST_DIR)/%.o:  $(LIBC_SRC_DIR)/%.c |  $(XGCC)
	mkdir -p $(@D)
	$(XGCC) $(CFLAGS) $(CPPFLAGS)  -MD -c $< -o $@
##### how to make sysroot libk objects
$(LIBC_DST_DIR)/%.libk:  $(LIBC_SRC_DIR)/%.c |  $(XGCC)
	mkdir -p $(@D)
	$(XGCC) $(CFLAGS) $(CPPFLAGS)  -MD -c $< -o $@

libc: $(LIBC_DST)
libk: $(LIBK_DST)

$(LIBC_DST_DIR)/libc.a: $(LIBC_OBJS) $(XAR)
	$(XAR) rcs $@ $(LIBC_OBJS)

$(LIBC_DST_DIR)/libk.a: $(LIBK_OBJS) $(XAR)
	$(XAR) rcs $@ $(LIBK_OBJS)

$(LOGS_DIR) $(PROJECT_DST_DIR) $(SYSROOT) $(LIBC_INC_DST_DIR) $(XGCC_BUILD_DIR) $(XBINUTILS_BUILD_DIR):
	@if test -f $@; then; else @echo "Creating $@"; mkdir -p $@; fi

clean-all:
	rm -rf $(PROJECT_DST_DIR) $(LOGS_DIR)

include STATUS.mk



Makefile.svg: Makefile CONFIG.mk
	rm -f Makefile.svg
	make -Bnd 2>&1 | tee make.Bdn | \
	makefile2graph -r -s -b 2>&1 | tee make.dot |\
	sed "s@$(SYSROOT)@S@g" |\
	sed "s@$(PROJECT_DST_DIR)@X@g" |\
	sed "s@$(PROJECT_SRC_DIR)@./@g" |\
	sed "s@$(HOME)/Work/@@g" |\
	dot -T svg -o Makefile.svg
