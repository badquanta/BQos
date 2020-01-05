default: update-status-svg all update-status-svg
PROJECT_SRC_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PROJECT_NAME    := BQos
LOGS_DIR := $(PROJECT_SRC_DIR)logs
include CONFIG.mk
#REDIRECT := 2>&1 | tee --output-error=warn -a
REDIRECT := | cat 2>&1 >>
XARCH     ?= i386-elf
XALL_DEFAULTS := 
XALL_PHONY := default all clean clean-all
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
	make update-status-svg

xbinutils-configure $(XBINUTILS_CONFIGURE_LOG) $(XBINUTILS_MAKEFILE): $(XBINUTILS_SRC_DIR)  
	rm -f $(XBINUTILS_CONFIGURE_LOG)
	mkdir -p $(XBINUTILS_BUILD_DIR)
	cd $(XBINUTILS_BUILD_DIR) && $(XBINUTILS_SRC_DIR)/configure $(XBINUTILS_CONFIGURE_PARAMS) $(REDIRECT) $(XBINUTILS_CONFIGURE_LOG)
	make update-status-svg
	@echo "XBINUTILS configured"
xbinutils-make $(XBINUTILS_MAKE_LOG): $(XBINUTILS_MAKEFILE)
	rm -f $(XBINUTILS_MAKE_LOG)
	cd $(XBINUTILS_BUILD_DIR) && make -j $(XJOBS) $(REDIRECT) $(XBINUTILS_MAKE_LOG)
	make update-status-svg
xbinutils-install $(XBINUTILS_INSTALL_LOG): $(XBINUTILS_MAKE_LOG)
	cd $(XBINUTILS_BUILD_DIR) && make install $(REDIRECT) $(XBINUTILS_INSTALL_LOG)
	touch $(XAR) $(XAS)
	make update-status-svg
	@echo "XBINUTILS installed"
$(XAR) $(XAS): $(XBINUTILS_INSTALL_LOG)
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

#### Start libC Make variables and rules
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

$(XGPP) $(XGCC): $(XGCC_INSTALL_LOG)

$(XGCC_SRC_DIR):
	$(GIT_SHALLOW) $(GCC_BRANCH) $(GCC_GIT) $(XGCC_SRC_DIR)
	make update-status-svg

xgcc-configure $(XGCC_MAKEFILE) $(XGCC_CONFIGURE_LOG): $(LIBC_INC_DST_DIR) $(XBINUTILS_INSTALL_LOG) $(XGCC_SRC_DIR) 
	rm -f $(XGCC_CONFIGURE_LOG)
	mkdir -p $(XGCC_BUILD_DIR)
	cd $(XGCC_BUILD_DIR) && $(XGCC_SRC_DIR)/configure $(XGCC_CONFIGURE_PARAMS) $(REDIRECT) $(XGCC_CONFIGURE_LOG)
	make update-status-svg
	@echo "XGCC Configured."

xgcc-make $(XGCC_MAKE_LOG):  $(XGCC_MAKEFILE)  
	rm -f $(XGCC_MAKE_LOG)
	cd $(XGCC_BUILD_DIR) && make all-gcc -j $(XJOBS) $(REDIRECT) $(XGCC_MAKE_LOG)
	cd $(XGCC_BUILD_DIR) && make all-target-libgcc -j $(XJOBS) $(REDIRECT) $(XGCC_MAKE_LOG)
	cd $(XGCC_BUILD_DIR) && make all-target-libstdc++-v3 -j $(XJOBS) $(REDIRECT) $(XGCC_MAKE_LOG)
	make update-status-svg
	@echo "XGCC Built."
xgcc-install $(XGCC_INSTALL_LOG):  $(XGCC_MAKE_LOG) 
	rm -f $(XGCC_INSTALL_LOG)
	cd $(XGCC_BUILD_DIR) && make install-gcc $(REDIRECT) $(XGCC_INSTALL_LOG)
	cd $(XGCC_BUILD_DIR) && make install-target-libgcc $(REDIRECT) $(XGCC_INSTALL_LOG)
	cd $(XGCC_BUILD_DIR) && make install-target-libstdc++-v3 $(REDIRECT) $(XGCC_INSTALL_LOG)
	touch $(XGPP) $(XGCC)
	make update-status-svg
	@echo "XGCC Installed."
#

##### how to make sysroot libc headers
$(LIBC_INC_DST_DIR): $(LIBC_H_DST)
	touch $@


$(LIBC_INC_DST_DIR)/%.h : $(LIBC_INC_DIR)/%.h
	mkdir -p $(@D)
	cp -fv $< $@
	#touch $@
	#touch $(@D)

##### how to make sysroot libc objects
$(LIBC_DST_DIR)/%.o:  $(LIBC_SRC_DIR)/%.c |  $(XGCC)
	mkdir -p $(@D)
	$(XGCC) $(CFLAGS) $(CPPFLAGS)  -MD -c $< -o $@
##### how to make sysroot libk objects
$(LIBC_DST_DIR)/%.libk:  $(LIBC_SRC_DIR)/%.c |  $(XGCC)
	mkdir -p $(@D)
	$(XGCC) $(CFLAGS) $(CPPFLAGS)  -MD -c $< -o $@

libc: update-status-svg $(LIBC_DST) update-status-svg
libk: update-status-svg $(LIBK_DST) update-status-svg

XALL_PHONY += libc libk
XALL_DEFAULTS += libc libk

$(LIBC_DST_DIR)/libc.a: $(LIBC_OBJS) $(XAR)
	$(XAR) rcs $@ $(LIBC_OBJS)

$(LIBC_DST_DIR)/libk.a: $(LIBK_OBJS) $(XAR)
	$(XAR) rcs $@ $(LIBK_OBJS)

$(LOGS_DIR) $(PROJECT_DST_DIR) $(SYSROOT) $(XGCC_BUILD_DIR) $(XBINUTILS_BUILD_DIR):
	mkdir -p $@

clean-all:
	mkdir -p $(LOGS_DIR)
	rm -rf $(PROJECT_DST_DIR) $(LOGS_DIR)/*.log
	@make update-status-svg
XALL_PHONY += clean-all

include STATUS.mk

update-status-svg: 
	rm -f make.status.svg
	make -Bnd | \
	makefile2graph |\
	sed "s@$(SYSROOT)@S@g" |\
	sed "s@$(PROJECT_DST_DIR)@X@g" |\
	sed "s@$(PROJECT_SRC_DIR)@./@g" |\
	sed "s@$(HOME)/Work/@@g" |\
	dot -T svg -o make.status.svg

XALL_PHONY+=update-status-svg
XALL_DEFAULTS += update-status-svg


.PHONY: $(XALL_PHONY)
all: $(XALL_DEFAULTS)