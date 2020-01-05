default: all 
PROJECT_SRC_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PROJECT_NAME    := BQos
LOGS_DIR := $(PROJECT_SRC_DIR)logs
UPDATE_STATUS := make update-status-svg
include CONFIG.mk
#REDIRECT := 2>&1 | tee --output-error=warn -a
REDIRECT := | cat 2>&1 >>
XARCH     ?= i386-elf
XALL_DEFAULTS := 
XALL_PHONY := default all clean clean-all
PROJECT_DST_DIR ?= $(realpath $(PROJECT_SRC_DIR)..)/BUILD-$(PROJECT_NAME)
SYSROOT ?= $(PROJECT_DST_DIR)/$(XARCH)/sys-root
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
	$(UPDATE_STATUS)

xbinutils-configure $(XBINUTILS_CONFIGURE_LOG) $(XBINUTILS_MAKEFILE): $(XBINUTILS_SRC_DIR)  
	rm -f $(XBINUTILS_CONFIGURE_LOG)
	mkdir -p $(XBINUTILS_BUILD_DIR)
	cd $(XBINUTILS_BUILD_DIR) && $(XBINUTILS_SRC_DIR)/configure $(XBINUTILS_CONFIGURE_PARAMS) $(REDIRECT) $(XBINUTILS_CONFIGURE_LOG)
	$(UPDATE_STATUS)
	@echo "XBINUTILS configured"
xbinutils-make $(XBINUTILS_MAKE_LOG): $(XBINUTILS_MAKEFILE)
	rm -f $(XBINUTILS_MAKE_LOG)
	cd $(XBINUTILS_BUILD_DIR) && make -j $(XJOBS) $(REDIRECT) $(XBINUTILS_MAKE_LOG)
	$(UPDATE_STATUS)
xbinutils-install $(XBINUTILS_INSTALL_LOG): $(XBINUTILS_MAKE_LOG)
	cd $(XBINUTILS_BUILD_DIR) && make install $(REDIRECT) $(XBINUTILS_INSTALL_LOG)
	
	$(UPDATE_STATUS)
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
XGPP       := $(XPATH_DIR)/$(XARCH)-g++
XGCC       := $(XPATH_DIR)/$(XARCH)-gcc

#### Start libC Make variables and rules
LIBC_DIR			:= $(PROJECT_SRC_DIR)libc
LIBC_SRC_DIR		:= $(LIBC_DIR)/src
LIBC_DST_DIR		:= $(SYSROOT)/lib
LIBK_DST_DIR		:= $(PROJECT_DST_DIR)/lib
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
LIBK_OBJS			:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBK_DST_DIR)/%.libk)
LIBK_OBJS			+= $(LIBC_S_SRCS:$(LIBC_SRC_DIR)/%.s=$(LIBK_DST_DIR)/%.libk)
LIBC_H_DST			:= $(LIBC_H_SRCS:$(LIBC_INC_DIR)/%.h=$(LIBC_INC_DST_DIR)/%.h)
LIBC_GCFLAGS			:= $(PROJECT_GCFLAGS) \
						-MD
$(XGPP) $(XGCC): $(XGCC_INSTALL_LOG) 

$(XGCC_SRC_DIR): 
	$(GIT_SHALLOW) $(GCC_BRANCH) $(GCC_GIT) $(XGCC_SRC_DIR)
	$(UPDATE_STATUS)

xgcc-configure $(XGCC_MAKEFILE) $(XGCC_CONFIGURE_LOG):$(LIBC_INC_DST_DIR) $(XBINUTILS_INSTALL_LOG) $(XGCC_SRC_DIR) 
	rm -f $(XGCC_CONFIGURE_LOG)
	mkdir -p $(XGCC_BUILD_DIR)
	cd $(XGCC_BUILD_DIR) && $(XGCC_SRC_DIR)/configure $(XGCC_CONFIGURE_PARAMS) $(REDIRECT) $(XGCC_CONFIGURE_LOG)
	$(UPDATE_STATUS)
	@echo "XGCC Configured."

xgcc-make $(XGCC_MAKE_LOG):$(XGCC_MAKEFILE)   
	rm -f $(XGCC_MAKE_LOG)
	cd $(XGCC_BUILD_DIR) && make all-gcc -j $(XJOBS) $(REDIRECT) $(XGCC_MAKE_LOG)
	cd $(XGCC_BUILD_DIR) && make all-target-libgcc -j $(XJOBS) $(REDIRECT) $(XGCC_MAKE_LOG)
	cd $(XGCC_BUILD_DIR) && make all-target-libstdc++-v3 -j $(XJOBS) $(REDIRECT) $(XGCC_MAKE_LOG)
	$(UPDATE_STATUS)
	@echo "XGCC Built."

xgcc-install $(XGCC_INSTALL_LOG): $(XGCC_MAKE_LOG)  
	rm -f $(XGCC_INSTALL_LOG)
	cd $(XGCC_BUILD_DIR) && make install-gcc $(REDIRECT) $(XGCC_INSTALL_LOG)
	cd $(XGCC_BUILD_DIR) && make install-target-libgcc $(REDIRECT) $(XGCC_INSTALL_LOG)
	cd $(XGCC_BUILD_DIR) && make install-target-libstdc++-v3 $(REDIRECT) $(XGCC_INSTALL_LOG)	
	$(UPDATE_STATUS)
	@echo "XGCC Installed."
#


##### how to make sysroot libc headers
$(LIBC_INC_DST_DIR): $(LIBC_H_DST) 
	touch $@
	$(UPDATE_STATUS)


$(LIBC_INC_DST_DIR)/%.h : $(LIBC_INC_DIR)/%.h 
	mkdir -p $(@D)
	cp -fv $< $@
	@#$(UPDATE_STATUS)
	#touch $@
	#touch $(@D)

##### how to make sysroot libc objects
$(LIBC_DST_DIR)/%.o:  $(LIBC_SRC_DIR)/%.c |  $(XGCC)
	mkdir -p $(@D)
	$(XGCC) $(LIBC_GCFLAGS)  -MD -c $< -o $@
	@#$(UPDATE_STATUS)
##### how to make sysroot libk objects
$(LIBK_DST_DIR)/%.libk: $(LIBC_SRC_DIR)/%.c |  $(XGCC)
	mkdir -p $(@D)
	$(XGCC) $(LIBC_GCFLAGS)  -MD -c $< -o $@
	@#$(UPDATE_STATUS)


##### how to make sysroot libc objects
$(LIBC_DST_DIR)/%.o:  $(LIBC_SRC_DIR)/%.s |  $(XGCC)
	mkdir -p $(@D)
	$(XAS) $(LIBC_GASFLAGS)  -MD -c $< -o $@
	@#$(UPDATE_STATUS)
##### how to make sysroot libk objects
$(LIBK_DST_DIR)/%.libk: $(LIBC_SRC_DIR)/%.s |  $(XGCC)
	mkdir -p $(@D)
	$(XAS) $(LIBC_GASFLAGS)  -MD -c $< -o $@
	@#$(UPDATE_STATUS)


libc: $(LIBC_DST)
	$(UPDATE_STATUS)
#libk: $(LIBK_DST) 
#	$(UPDATE_STATUS)

XALL_PHONY += libc
XALL_DEFAULTS += libc

$(LIBC_DST_DIR)/libc.a: $(LIBC_OBJS) $(XAR)
	$(XAR) rcs $@ $(LIBC_OBJS)
	$(UPDATE_STATUS)

$(LIBC_DST_DIR)/libk.a: $(LIBK_OBJS) $(XAR)
	$(XAR) rcs $@ $(LIBK_OBJS)
	$(UPDATE_STATUS)

$(LOGS_DIR) $(PROJECT_DST_DIR) $(SYSROOT) $(XGCC_BUILD_DIR) $(XBINUTILS_BUILD_DIR):
	mkdir -p $@

clean-all:
	mkdir -p $(LOGS_DIR)
	rm -rf $(PROJECT_DST_DIR) $(LOGS_DIR)/*.log
	@#$(UPDATE_STATUS)
XALL_PHONY += clean-all

BQos_CPP_SRC_DIR		:= $(PROJECT_SRC_DIR)src
BQos_CPP_SRCS			:= $(wildcard $(BQos_CPP_SRC_DIR)/*.cpp)
BQos_CPP_SRCS			+= $(wildcard $(BQos_CPP_SRC_DIR)/*/*.cpp)
BQos_CPP_SRCS			+= $(wildcard $(BQos_CPP_SRC_DIR)/*/*/*.cpp)
BQos_CPP_SRCS			+= $(wildcard $(BQos_CPP_SRC_DIR)/*/*/*/*.cpp)
BQos_S_SRC_DIR			:= $(PROJECT_SRC_DIR)src
BQos_S_SRCS				:= $(wildcard $(BQos_S_SRC_DIR)/*.s)
BQos_S_SRCS				+= $(wildcard $(BQos_S_SRC_DIR)/*/*.s)
BQos_S_SRCS				+= $(wildcard $(BQos_S_SRC_DIR)/*/*/*.s)
BQos_S_SRCS				+= $(wildcard $(BQos_S_SRC_DIR)/*/*/*/*.s)
BQos_HPP_SRC_DIR		:= $(PROJECT_SRC_DIR)src
BQos_HPP_SRCS			:= $(wildcard $(BQos_HPP_SRC_DIR)/*.hpp)
BQos_HPP_SRCS			+= $(wildcard $(BQos_HPP_SRC_DIR)/*/*.hpp)
BQos_HPP_SRCS			+= $(wildcard $(BQos_HPP_SRC_DIR)/*/*/*.hpp)
BQos_S_SRCS				+= $(wildcard $(BQos_S_SRC_DIR)/*/*/*/*/*.s)
BQos_DST_DIR			:= $(PROJECT_DST_DIR)/lib
BQos_OBJS				:= $(BQos_CPP_SRCS:$(BQos_CPP_SRC_DIR)/%.cpp=$(BQos_DST_DIR)/%.o)
BQos_OBJS				+= $(BQos_S_SRCS:$(BQos_S_SRC_DIR)/%.s=$(BQos_DST_DIR)/%.o)
BQos_BOOT				:= $(SYSROOT)/boot
BQos_BOOT_KERNEL		:= $(BQos_BOOT)/$(XARCH).kernel
BQos_GCFLAGS			:= $(PROJECT_GCFLAGS)
BQos_GASFLAGS			:= $(PROJECT_GASFLAGS)
BQos_GCFLAGS			+= \
	-I$(PROJECT_SRC_DIR) \
	-fno-leading-underscore \
	-fcheck-new \
	-fno-use-cxa-atexit \
	-nostdlib \
	-fno-rtti \
	-fno-exceptions

$(BQos_DST_DIR)/%.o : $(BQos_CPP_SRC_DIR)/%.cpp
	mkdir -p $(@D)
	$(XGPP) $(BQos_GCFLAGS) -o $@ -c $<
$(BQos_DST_DIR)/%.o : $(BQos_S_SRC_DIR)/%.s
	mkdir -p $(@D)
	$(XAS) $(BQos_GASFLAGS) -o $@ -c $<
BQos_KERNEL_LINK_FLAGS:=		-T linker.ld -m32 -O2 -lgcc -nostdlib -ffreestanding

$(BQos_BOOT_KERNEL): $(BQos_OBJS) $(LIBK_DST) | $(linker.ld)
	mkdir -p $(@D)
	$(XGPP) $(BQos_KERNEL_LINK_FLAGS) -o $@ $^

run-BQos-KERNEL: $(BQos_BOOT_KERNEL)
	qemu-system-i386 -kernel $<


clean-BQos-OBJS:
	rm -f $(BQos_OBJS)
clean-BQos-KERNELS:
	rm -f $(BQos_BOOT_KERNEL)
clean-BQos: clean-BQos-OBJS clean-BQos-KERNELS
XALL_PHONY += clean-BQos-OBJS clean-BQos-KERNELS clean-BQos
#XALL_DEFAULTS += $(BQos_BOOT_KERNEL)
###############################################################################
BQos_ISO:= $(PROJECT_DST_DIR).iso
BQos_BOOT_GRUB := $(BQos_BOOT)/grub
BQos_BOOT_GRUB_CONFIG := $(BQos_BOOT_GRUB)/grub.cfg

$(BQos_ISO): $(BQos_BOOT_GRUB_CONFIG)
	grub-mkrescue -o $@ $(SYSROOT)

$(BQos_BOOT_GRUB_CONFIG): $(BQos_BOOT_KERNEL)
	@echo "########## $(@) ############"
	mkdir -p $(@D)
	echo "menuentry \"Operating System\" {\n  multiboot $(BQos_BOOT_KERNEL)\n }\n" >> $(BQos_BOOT_GRUB_CONFIG)
XALL_DEFAULTS += $(BQos_ISO)
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


.PHONY: $(XALL_PHONY)
all: $(XALL_DEFAULTS)