include CROSS.mk
## GNU C++ Compiler parameters
GPP_FLAGS:=     	\
					-Wall\
					-static\
					-Wfatal-errors\
					-Isrc\
					-Wextra\
					-pedantic\
					-Wshadow\
					-Wpointer-arith\
					-Wcast-align\
					-Wwrite-strings -Wmissing-declarations\
					-Wredundant-decls -Winline -Wno-long-long\
					-Wconversion\
					-m32\
					-fcheck-new\
					-fno-omit-frame-pointer\
					-fno-use-cxa-atexit\
					-nostdlib\
					-fno-rtti\
					-fno-exceptions\
					-fno-leading-underscore\
					-Wno-write-strings\
					-I$(Xi386_INCLUDE)
## GNU Assembler Parameters:
GAS_FLAGS:=			--32		

##
LINK_FLAGS:=		-T linker.ld -m32 -O2 -lgcc -nostdlib -ffreestanding