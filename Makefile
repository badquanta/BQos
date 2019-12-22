
default: all
include FLAGS.mk
#include CROSS.mk

include SOURCES.mk
export PATH:=$(CROSS_PATH):$(PATH)
TARGET  		:= i386
DIST_DIR		:= dist

DIST_OBJ_DIR	:= $(DIST_DIR)/lib-$(TARGET)
DIST_CPP_OBJS	:= $(CPP_SOURCES:src/%.cpp=$(DIST_OBJ_DIR)/%.o)
DIST_GAS_OBJS	:= $(GAS_SOURCES:src/%.s=$(DIST_OBJ_DIR)/%.o)
DIST_ALL_OBJS	:= $(DIST_CPP_OBJS)
DIST_ALL_OBJS 	+= $(DIST_GAS_OBJS)
DIST_BOOT_DIR := $(DIST_DIR)/boot
DIST_BOOT_KERNEL:= $(DIST_BOOT_DIR)/$(TARGET).kernel
DIST_BOOT_GRUB_DIR := $(DIST_BOOT_DIR)/grub
DIST_BOOT_GRUB_CONFIG := $(DIST_BOOT_GRUB_DIR)/grub.cfg
DIST_INCLUDE_DIR := $(DIST_DIR)/include
DIST_SOURCES_DIR := $(DIST_DIR)/src
#
.PHONY: default clean clean-all

clean:
	rm -rf $(DIST_ALL_OBJS) $(TARGET).iso
clean-all: clean
	rm -rf $(DIST_DIR)
## START OF RULES
$(DIST_CPP_OBJS)			: 	$(CPP_SOURCES) $(HPP_SOURCES)
$(DIST_GAS_OBJS)			:	$(GAS_SOURCES)
$(DIST_OBJ_DIR)/%.o			:	src/%.cpp | CROSS
	mkdir -p $(@D)
	$(Xi386_GPP) $(GPP_FLAGS) -o $@ -c $<

$(DIST_OBJ_DIR)/%.o			:	src/%.s
	mkdir -p $(@D)
	$(Xi386_GAS) $(GAS_FLAGS) -o $@ $<

$(DIST_BOOT_KERNEL): $(DIST_ALL_OBJS) | $(linker.ld) 
	mkdir -p $(@D)
	echo $(DIST_ALL_OBJS)
	$(Xi386_GPP) $(LINK_FLAGS) -o $@ $^

$(DIST_BOOT_GRUB_CONFIG): $(DIST_BOOT_KERNEL)
	mkdir -p $(@D)
	echo "menuentry \"Operating System\" {\n  multiboot /boot/$(TARGET).kernel\n }\n" >> $(DIST_BOOT_GRUB_CONFIG)
$(DIST_INCLUDE_DIR):
	mkdir -p $(@D)/
	cp -rfav $(HPP_SOURCES) $(DIST_INCLUDE_DIR)
$(DIST_SOURCES_DIR):
	mkdir -p $(@D)/
	cp -rfav $(SOURCE_DIR)/ $(DIST_SOURCES_DIR)	
$(DIST_DOCS_DIR): $(CPP_SOURCES) $(HPP_SOURCES)
	mkdir -p $(@)/
	doxygen
$(TARGET).iso:  $(DIST_BOOT_GRUB_CONFIG) 
	grub-mkrescue -o $@ $(DIST_DIR)
all: $(TARGET).iso

is-multiboot-kernel: $(DIST_BOOT_KERNEL)
	grub-file --is-x86-multiboot $(DIST_BOOT_KERNEL) || exit 1 "Not Multiboot Kernel."

run-kernel: $(DIST_BOOT_KERNEL) is-multiboot-kernel
	qemu-system-$(TARGET) -kernel $(DIST_BOOT_KERNEL) 
	


run-iso: $(TARGET).iso
	qemu-system-$(TARGET) -cdrom $(TARGET).iso