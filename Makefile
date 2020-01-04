PROJECT_SRC_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PROJECT_NAME    := BQos
LOGS_DIR := $(PROJECT_SRC_DIR)logs
include CONFIG.mk
XARCH     ?= i386-elf
all: status-config

PROJECT_DST_DIR ?= $(realpath $(PROJECT_SRC_DIR)..)/BUILD-$(PROJECT_NAME)


SYSROOT ?= $(PROJECT_DST_DIR)/$(XARCH)/sys-root

## Start Cross (X) Built Binutils, GAS, GCC, and G++
XPREFIX   := $(PROJECT_DST_DIR)

XPATH_DIR := $(XPREFIX)/bin
XBINUTILS_BUILD_DIR := $(XPREFIX)/xbinutils
XBINUTILS_SRC_DIR := $(XPREFIX)/usr/src/binutils
XBINUTILS_MAKEFILE := $(XBINUTILS_BUILD_DIR)/Makefile
BINUTILS_GIT := git://sourceware.org/git/binutils-gdb.git
BINUTILS_GIT_BRANCH := binutils-2_33_1
XBINUTILS_CONFIGURE_PARAMS:= \
		--target=$(XARCH) \
		--prefix="$(XPREFIX)" \
		--with-sysroot="$(SYSROOT)" \
		--disable-nls \
		--disable-werror
XAR				:= $(XPATH_DIR)/$(XARCH)-ar
XAS				:= $(XPATH_DIR)/$(XARCH)-as
GIT_SHALLOW		:= git clone --depth 1 --single-branch --branch
status-xbinutils:
	@echo BINUTILS_GIT $(BINUTILS_GIT)
	@echo BINUTILS_GIT_BRANCH $(BINUTILS_GIT_BRANCH)
	@echo XBINUTILS_BUILD_DIR $(XBINUTILS_BUILD_DIR)
	@echo XBINUTILS_SRC_DIR $(XBINUTILS_SRC_DIR)
	@echo XBINUTILS_MAKEFILE $(XBINUTILS_MAKEFILE)
	@echo XBINUTILS_CONFIGURE_PARAMS $(XBINUTILS_CONFIGURE_PARAMS)
	@echo XAR $(XAR)
	@echo XAS $(XAS)
$(XBINUTILS_SRC_DIR):
	$(GIT_SHALLOW) $(BINUTILS_GIT_BRANCH)  $(BINUTILS_GIT) $(XBINUTILS_SRC_DIR)
$(XBINUTILS_MAKEFILE):xbinutils-configure $(LOGS_DIR)
xbinutils-configure:$(XBINUTILS_BUILD_DIR) $(XBINUTILS_SRC_DIR) CONFIG.mk $(LOGS_DIR)
	cd $(XBINUTILS_BUILD_DIR) && $(XBINUTILS_SRC_DIR)/configure $(XBINUTILS_CONFIGURE_PARAMS) #> $(LOGS_DIR)/xbinutils-configure.log
	@echo "XBINUTILS configured"
xbinutils-make-install:$(XBINUTILS_MAKEFILE) $(LOGS_DIR)
	cd $(XBINUTILS_BUILD_DIR) && make -j $(XJOBS) #> $(LOGS_DIR)/xbinutils-make.log
	cd $(XBINUTILS_BUILD_DIR) && make install #> $(LOGS_DIR)/xbinutils-install.log
	@echo "XBINUTILS installed"
$(XAR) $(XAS): xbinutils-make-install

GCC_GIT := https://github.com/badquanta/gcc.git
GCC_BRANCH := gcc-9_2_0-release
XGCC_BUILD_DIR := $(XPREFIX)/xgcc
XGCC_SRC_DIR := $(XPREFIX)/usr/src/gcc
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

XGAS       := $(XPATH_DIR)/$(XARCH)-gas
XGPP       := $(XPATH_DIR)/$(XARCH)-gpp
XGCC       := $(XPATH_DIR)/$(XARCH)-gas
status-xgcc:
	@echo GCC_GIT $(GCC_GIT)
	@echo GCC_BRANCH $(GCC_BRANCH)
	@echo XGCC_BUILD_DIR $(XGCC_BUILD_DIR)
	@echo XGCC_SRC_DIR $(XGCC_SRC_DIR)
	@echo XGCC_CONFIGURE_PARAMS $(XGCC_CONFIGURE_PARAMS)
	@echo XGAS $(XGAS)
	@echo XGPP $(XGPP)
	@echo XGCC $(XGCC)

	@echo XBINUTILS_BUILD_DIR $(XBINUTILS_BUILD_DIR)
	@echo XBINUTILS_SRC_DIR $(XBINUTILS_SRC_DIR)
	@echo XBINUTILS_MAKEFILE $(XBINUTILS_MAKEFILE)
	@echo XBINUTILS_CONFIGURE_PARAMS $(XBINUTILS_CONFIGURE_PARAMS)
	@echo XAR $(XAR)
	@echo XAS $(XAS)

$(XGAS) $(XGPP) $(XGCC): xgcc-make-install

$(XGCC_SRC_DIR):
	$(GIT_SHALLOW) $(GCC_BRANCH) $(GCC_GIT) $(XGCC_SRC_DIR)
$(XGCC_MAKEFILE): xgcc-configure 
xgcc-configure: libc-dst-h $(XAS) $(XGCC_BUILD_DIR) $(XGCC_SRC_DIR) CONFIG.mk
	cd $(XGCC_BUILD_DIR) && $(XGCC_SRC_DIR)/configure $(XGCC_CONFIGURE_PARAMS) #> $(LOGS_DIR)/xgcc-configure.log
	@echo "XGCC Configured."
xgcc-make-install:  $(XGCC_MAKEFILE) 
	cd $(XGCC_BUILD_DIR) && make all-gcc -j $(XJOBS) #> $(LOGS_DIR)/xgcc-make.log
	cd $(XGCC_BUILD_DIR) && make all-target-libgcc -j $(XJOBS) #>> $(LOGS_DIR)/xgcc-make.log
	cd $(XGCC_BUILD_DIR) && make all-target-libstdc++-v3 -j $(XJOBS) #>> $(LOGS_DIR)/xgcc-make.log
	cd $(XGCC_BUILD_DIR) && make install-gcc #> $(LOGS_DIR)/xgcc-install.log
	cd $(XGCC_BUILD_DIR) && make install-target-libgcc #>> $(LOGS_DIR)/xgcc-install.log
	cd $(XGCC_BUILD_DIR) && make install-target-libstdc++-v3 #>> $(LOGS_DIR)/xgcc-install.log
	@echo "XGCC Installed."


## Start libC Make variables and rules

LIBC_DIR			:= $(PROJECT_SRC_DIR)libc
LIBC_SRC_DIR		:= $(LIBC_DIR)/src
LIBC_DST_DIR		:= $(SYSROOT)/lib
LIBC_INC_DIR		:= $(LIBC_DIR)/include
LIBC_INC_DST_DIR	:= $(SYSROOT)/usr/include
LIBC_C_SRCS			:= $(wildcard $(LIBC_SRC_DIR)/*.c)
LIBC_C_SRCS			+= $(wildcard $(LIBC_SRC_DIR)/*/*.c)
LIBC_S_SRCS			:= $(wildcard $(LIBC_SRC_DIR)/*.s)
LIBC_S_SRCS			+= $(wildcard $(LIBC_SRC_DIR)/*/*.s)
LIBC_H_SRCS			:= $(wildcard $(LIBC_INC_DIR)/*.h)
LIBC_H_SRCS			+= $(wildcard $(LIBC_INC_DIR)/*/*.h)
LIBC_OBJS			:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBC_DST_DIR)/%.o)
LIBK_OBJS			:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBC_DST_DIR)/%.libk)
LIBC_H_DST			:= $(LIBC_H_SRCS:$(LIBC_INC_DIR)/%.h=$(LIBC_INC_DST_DIR)/%.h)

status-libc:
	@./status.sh $(LIBC_DIR) LIBC_DIR
	@./status.sh $(LIBC_SRC_DIR) LIBC_SRC_DIR
	@./status.sh $(LIBC_DST_DIR) LIBC_DST_DIR
	@./status.sh $(LIBC_INC_DIR) LIBC_INC_DIR
	@./status.sh $(LIBC_INC_DST_DIR) LIBC_INC_DST_DIR
status-libc-src-c:
	@echo =================== LIBC_C_SRCS start
	@./status.sh "$(LIBC_C_SRCS)" 
	@echo =================== LIBC_C_SRCS end
status-libc-src-s:
	@echo =================== LIBC_S_SRCS start
	@./status.sh "$(LIBC_S_SRCS)"
	@echo =================== LIBC_S_SRCS end
status-libc-src-h:
	@echo =================== LIBC_H_SRCS start
	@./status.sh "$(LIBC_H_SRCS)"
	@echo =================== LIBC_H_SRCS end
status-libc-src-all: status-libc-src-c status-libc-src-s status-libc-src-h
status-libc-objs:
	@echo =================== LIBC_OBJS start
	@./status.sh "$(LIBC_OBJS)"
	@echo =================== LIBC_OBJS end
	@echo =================== LIBK_OBJS start
	@./status.sh "$(LIBK_OBJS)"
	@echo =================== LIBK_OBJS end
status-libc-dst-h:	
	@./status.sh "$(LIBC_H_DST)"

libc-dst-h: $(LIBC_H_DST) status-libc-dst-h	
	

$(LIBC_INC_DST_DIR)/%.h : $(LIBC_INC_DIR)/%.h
	@mkdir -p $(@D)
	cp -f $< $@

$(LIB_BUILD_DIR)/libc.a: $(LIBC_OBJS)
  #$(XAR) rcs $@ $(LIBC_OBJS)
$(LIB_BUILD_DIR)/libk.a: $(LIBK_OBJS)
  #$(XAR) rcs $@ $(LIBK_OBJS)

$(LOGS_DIR) $(PROJECT_DST_DIR) $(SYSROOT) $(LIBC_INC_DST_DIR) $(XGCC_BUILD_DIR) $(XBINUTILS_BUILD_DIR):
	mkdir -p $@
    
clean-all:
	rm -rf $(PROJECT_DST_DIR) $(LOGS_DIR)
status-config:
	@echo XJOBS: $(XJOBS)
	@echo "PROJECT_NAME:" $(PROJECT_NAME)
	@echo PROJECT_SRC_DIR: $(PROJECT_SRC_DIR)
	@echo PROJECT_DST_DIR: $(PROJECT_DST_DIR)
	@echo SYSROOT: $(SYSROOT)
	@echo XPREFIX: $(XPREFIX)
	@echo XPATH_DIR: $(XPATH_DIR)
	@echo XGCC_SRC_DIR: $(XGCC_SRC_DIR)
	@echo XARCH: $(XARCH)
	@echo XGAS: $(XGAS)
	@echo XGCC: $(XGCC)
	@echo "XG++:" $(XGPP)
	@echo LIBC_DIR: $(LIBC_DIR)
	@#@echo LIBC_H_SRCS: $(LIBC_H_SRCS)
	@#@echo LIBC_H_DST: $(LIBC_H_DST)
  