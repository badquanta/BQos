CB_TARGET		 			:= i386-elf
CB_PREFIX 					:= $(shell pwd)/../BUILD
CB_DOWNLOADS 				:= $(CB_PREFIX)/downloads
CB_PATH   					:= $(CB_PREFIX)/bin:$(CB_PATH)
CB_PATH_Gpp					:= $(CB_PREFIX)/bin/${CB_TARGET}-g++
CB_PATH_Gas					:= $(CB_PREFIX)/bin/${CB_TARGET}-as
CB_SRC_DIR 					:= $(CB_PREFIX)/usr/src
CB_BUILD_DIR				:= $(CB_PREFIX)/build
CB_SYSROOT 					:= $(CB_PREFIX)/i386-elf/sys-root
CB_GCC_VERSION 				:= 9.2.0
CB_BINUTILS_VERSION	 		:= 2.33.1
CB_GCC_NAME_VERSION		 	:= gcc-$(CB_GCC_VERSION)
CB_BINUTILS_NAME_VERSION	:= binutils-$(CB_BINUTILS_VERSION)
CB_GCC_TAR_GZ 				:= $(CB_GCC_NAME_VERSION).tar.gz
CB_BINUTILS_TAR_GZ			:= $(CB_BINUTILS_NAME_VERSION).tar.gz
CB_GNU_MIRROR_URL			:= https://ftp.gnu.org/gnu
CB_GCC_DOWNLOAD_URL 		:= $(CB_GNU_MIRROR_URL)/gcc/$(CB_GCC_NAME_VERSION)/$(CB_GCC_TAR_GZ)
CB_BINUTILS_DOWNLOAD_URL	:= $(CB_GNU_MIRROR_URL)/binutils/$(CB_BINUTILS_TAR_GZ)
CB_GCC_DOWNLOAD_TO			:= $(CB_DOWNLOADS)/$(CB_GCC_TAR_GZ)
CB_BINUTILS_DOWNLOAD_TO		:= $(CB_DOWNLOADS)/$(CB_BINUTILS_TAR_GZ)
CB_GCC_SRC 					:= $(CB_SRC_DIR)/$(CB_GCC_NAME_VERSION)
CB_BINUTILS_SRC 			:= $(CB_SRC_DIR)/$(CB_BINUTILS_NAME_VERSION)
CB_BUILD_BINUTILS_DIR 		:= $(CB_BUILD_DIR)/binutils
CB_BUILD_GCC_DIR 			:= $(CB_BUILD_DIR)/gcc

CB_TAR_PARAMS				:= -m --keep-newer-files
#############################################################################################
cb-all: cb-get-sources cb-binutils env cb-gcc

$(CB_DOWNLOADS):
	mkdir -p $(CB_DOWNLOADS)

$(CB_SRC_DIR):
	mkdir -p $(CB_SRC_DIR)

$(CB_GCC_SRC): $(CB_DOWNLOADS) $(CB_SRC_DIR)
	cd $(CB_DOWNLOADS) && wget -N $(CB_GCC_DOWNLOAD_URL)
	cd $(CB_SRC_DIR) && tar $(CB_TAR_PARAMS) -xvf $(CB_GCC_DOWNLOAD_TO)

$(CB_BINUTILS_SRC): $(CB_DOWNLOADS) $(CB_SRC_DIR)
	cd $(CB_DOWNLOADS) && wget -N $(CB_BINUTILS_DOWNLOAD_URL)
	cd $(CB_SRC_DIR) && tar $(CB_TAR_PARAMS) -xvf $(CB_BINUTILS_DOWNLOAD_TO)

env: env.sh
	./env.sh

$(CB_BUILD_BINUTILS_DIR):
	mkdir -p $(CB_BUILD_BINUTILS_DIR)

cb-binutils: env $(CB_BUILD_BINUTILS_DIR) $(CB_DOWNLOADS)
	cd $(CB_BUILD_BINUTILS_DIR) && pwd && $(CB_BINUTILS_SRC)/configure \
		--target=$(CB_TARGET) \
		--prefix="$(CB_PREFIX)" \
		--with-sysroot \
		--disable-nls \
		--disable-werror
	cd $(CB_BUILD_BINUTILS_DIR) && make 
	cd $(CB_BUILD_BINUTILS_DIR) && make install

sysroot:
	mkdir -p $(CB_SYSROOT)
	rm -f ./SYSROOT
	ln -s $(CB_SYSROOT) ./SYSROOT

cb-get-sources: $(CB_BINUTILS_SRC) $(CB_GCC_SRC)
cb-headers:
	mkdir -p $(CB_SYSROOT)/usr/include
	
	cp -rf ./src/libc/* $(CB_SYSROOT)/usr/include
	
$(CB_BUILD_GCC_DIR): cb-headers
	mkdir -p $(CB_BUILD_GCC_DIR)
	

cb-gcc: env $(CB_BUILD_GCC_DIR) $(CB_DOWNLOADS) 
	
	./env.sh && cd $(CB_BUILD_GCC_DIR) && $(CB_GCC_SRC)/configure \
		--target=$(CB_TARGET) --prefix="$(CB_PREFIX)" --with-sysroot  \
		--with-sysroot-build=$(CB_TARGET) \
		--disable-nls \
		--disable-bootstrap \
		--disable-multilib \
		--enable-languages=c		
# TODO: Disabled multilibs; is this important?
	./env.sh && cd $(CB_BUILD_GCC_DIR) && make all -j 16
	./env.sh && cd $(CB_BUILD_GCC_DIR) && make all-target-libgcc 
	./env.sh && cd $(CB_BUILD_GCC_DIR) && make install-gcc 
	./env.sh && cd $(CB_BUILD_GCC_DIR) && make install-target-libgcc

$(CB_PATH_Gpp): cb-gcc

cb-clean: 
	rm -rf $(CB_BUILD_DIR) $(CB_PREFIX)/bin $(CB_PREFIX)/*-elf $(CB_PREFIX)/include $(CB_PREFIX)/lib $(CB_PREFIX)/libexec $(CB_PREFIX)/share $(CB_BINUTILS_SRC) $(CB_GCC_SRC)

