PREFIX 					:= $(shell pwd)
DOWNLOADS 				:= $(PREFIX)/downloads
PATH   					:= $(PREFIX)/bin:$(PATH)
SRC_DIR 				:= $(PREFIX)/src
TARGET		 			:= i386-elf
GCC_VERSION 			:= 9.2.0
BINUTILS_VERSION	 	:= 2.33.1
GCC_NAME_VERSION		 	:= gcc-$(GCC_VERSION)
BINUTILS_NAME_VERSION		:= binutils-$(BINUTILS_VERSION)
GCC_TAR_GZ 				:= $(GCC_NAME_VERSION).tar.gz
BINUTILS_TAR_GZ			:= $(BINUTILS_NAME_VERSION).tar.gz

GNU_MIRROR_URL			:= https://ftp.gnu.org/gnu
GCC_DOWNLOAD_URL 		:= $(GNU_MIRROR_URL)/gcc/$(GCC_NAME_VERSION)/$(GCC_TAR_GZ)
BINUTILS_DOWNLOAD_URL := $(GNU_MIRROR_URL)/binutils/$(BINUTILS_TAR_GZ)

GCC_DOWNLOAD_TO		:= $(DOWNLOADS)/$(GCC_TAR_GZ)
BINUTILS_DOWNLOAD_TO:= $(DOWNLOADS)/$(BINUTILS_TAR_GZ)

GCC_SRC 			:= $(SRC_DIR)/$(GCC_NAME_VERSION)
BINUTILS_SRC 		:= $(SRC_DIR)/$(BINUTILS_NAME_VERSION)

#############################################################################################
all: unpack-all binutils env build/gcc downloads binutils gcc

$(DOWNLOADS):
	mkdir -p $(DOWNLOADS)

$(SRC_DIR):
	mkdir -p $(SRC_DIR)
$(GCC_SRC): $(DOWNLOADS) $(SRC_DIR)
	cd $(DOWNLOADS) && wget -N $(GCC_DOWNLOAD_URL)
	cd $(SRC_DIR) && tar -xvf $(GCC_DOWNLOAD_TO)

$(BINUTILS_SRC): $(DOWNLOADS) $(SRC_DIR)
	cd $(DOWNLOADS) && wget -N $(BINUTILS_DOWNLOAD_URL)
	cd $(SRC_DIR) && tar -xvf $(BINUTILS_DOWNLOAD_TO)

env: env.sh
	./env.sh
build/binutils:
	mkdir -p build/binutils

binutils: env build/binutils downloads	
	cd build/binutils && pwd && $(BINUTILS_SRC)/configure --target=$(TARGET) --prefix="$(PREFIX)" --with-sysroot --disable-nls --disable-werror
	cd build/binutils && make -j 16
	cd build/binutils && make install



unpack-all: $(BINUTILS_SRC) $(GCC_SRC)

build/gcc:
	mkdir -p build/gcc
gcc: env build/gcc downloads 
	
	./env.sh && cd build/gcc && $(GCC_SRC)/configure --target=$(TARGET) --prefix="$(PREFIX)" --disable-nls --enable-languages=c,c++ --without-headers
	./env.sh && cd build/gcc && make all-gcc -j 16
	./env.sh && cd build/gcc && make all-target-libgcc -j 16
	./env.sh && cd build/gcc && make install-gcc
	./env.sh && cd build/gcc && make install-target-libgcc

clean: 
	rm -rf build downloads bin *-elf include lib libexec share $(BINUTILS_SRC) $(GCC_SRC)

