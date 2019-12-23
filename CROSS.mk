PREFIX			:= $(shell pwd)CROSS/
TARGET  		:= i386
CROSS_PATH		:=  CROSS/bin
export PATH:=$(CROSS_PATH):$(PATH)
Xi386_GPP		=  $(TARGET)-elf-g++
Xi386_GAS		=  $(TARGET)-elf-as
Xi386_LD        =  $(TARGET)-elf-ld
Xi386_INCLUDE   =  $(PREFIX)/lib/gcc/i386-elf/9.2.0/include
CROSS_Xi386:
	cd CROSS/ && make

CROSS:
	echo $$PATH
clean-cross:
	cd CROSS/ && make clean && make