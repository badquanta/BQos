PREFIX :=$(shell pwd)
TARGET :=i386-elf
PATH   :=$(PREFIX)/bin:$(PATH)

all: $(BINUTILS_SRC) $(GCC_SRC) binutils gcc

downloads:
	mkdir -p downloads

GCC_VERSION := 9.2.0
GCC_DOWNLOAD_URL := https://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)/gcc-$(GCC_VERSION).tar.gz
GCC_DOWNLOAD_TO  := downloads/gcc.tar.gz

$(GCC_DOWNLOAD_TO): downloads
	wget -N $(GCC_DOWNLOAD_URL) -O $(GCC_DOWNLOAD_TO)

GCC_SRC := gcc-$(GCC_VERSION)
$(GCC_SRC): $(GCC_DOWNLOAD_TO)
	tar -xvf $(GCC_DOWNLOAD_TO)




BINUTILS_VERSION := 2.33.1
BINUTILS_DOWNLOAD_URL := https://ftp.gnu.org/gnu/binutils/binutils-$(BINUTILS_VERSION).tar.gz
BINUTILS_DOWNLOAD_TO := downloads/binutils.tar.gz

$(BINUTILS_DOWNLOAD_TO): downloads 
	wget -N $(BINUTILS_DOWNLOAD_URL) -O $(BINUTILS_DOWNLOAD_TO)
	
BINUTILS_SRC := binutils-$(BINUTILS_VERSION)

$(BINUTILS_SRC): $(BINUTILS_DOWNLOAD_TO)
	tar -xvf $(BINUTILS_DOWNLOAD_TO)



preparation: preparation.sh
	./preparation.sh
build/binutils:
	mkdir -p build/binutils

binutils: preparation build/binutils downloads	
	cd build/binutils && pwd && ../../$(BINUTILS_SRC)/configure --target=$(TARGET) --prefix="$(PREFIX)" --with-sysroot --disable-nls --disable-werror
	cd build/binutils && make -j 16
	cd build/binutils && make install


build/gcc:
	mkdir -p build/gcc
gcc: binutils preparation build/gcc downloads 
	
	./preparation.sh && cd build/gcc && ../../$(GCC_SRC)/configure --target=$(TARGET) --prefix="$(PREFIX)" --disable-nls --enable-languages=c,c++ --without-headers
	./preparation.sh && cd build/gcc && make all-gcc -j 16
	./preparation.sh && cd build/gcc && make all-target-libgcc -j 16
	./preparation.sh && cd build/gcc && make install-gcc
	./preparation.sh && cd build/gcc && make install-target-libgcc

clean: 
	rm -rf build downloads bin *-elf include lib libexec share $(BINUTILS_SRC) $(GCC_SRC)

