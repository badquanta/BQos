PREFIX			:= $(shell pwd)
CROSS_PATH		:=  CROSS/bin


Xi386_GPP		:=	echo $$PATH && i386-elf-g++
Xi386_GAS		:=	CROSS/bin/i386-elf-as
Xi386_LD        :=  CROSS/bin/i386-elf-ld
Xi386_INCLUDE   :=  CROSS/bin/i386-elf/9.2.0/include
CROSS_Xi386:

	cd CROSS/ && make

CROSS:
	echo $$PATH
clean-cross:
	cd CROSS/ && make clean && make