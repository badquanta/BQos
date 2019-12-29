-.PHONY: default all clean clean-all testdrivers todolist
default: all
	@echo "########## $(@) ############"
include BUILD.mk
#####################################################################
clean:
	@echo "########## $(@) ############"
	rm -rf $(DIST_ALL_OBJS) $(TARGET).iso
#####################################################################
clean-all: clean
	@echo "########## $(@) ############"
	rm -rf $(TARGET_DIR)
#####################################################################
$(DIST_CPP_OBJS)			: 	$(BQos_CPP_SRCS) $(BQos_HPP_SRCS)
$(DIST_LIBC_OBJS)		    :   $(LIBC_C_SRCS)
#####################################################################
$(DIST_GAS_OBJS)			:	$(BQos_GAS_S)
#####################################################################
$(DIST_OBJ_DIR)/%.o			:	src/%.cpp
	@echo "########## $(@) FROM $< ############"
	@mkdir -p $(@D)
	$(CB_PATH_Gpp) $(GPP_FLAGS) -o $@ -c $<

$(DIST_OBJ_DIR)/%.o			:	src/%.c 
	@mkdir -p $(@D)
	$(CB_PATH_Gpp) $(GPP_FLAGS) -o $@ -c $<
#####################################################################
$(DIST_OBJ_DIR)/%_TEST: $(src)%.cpp Makefile $(DIST_BOOT_KERNEL)
	@echo "########## $(@) ############"
	mkdir -p $(@D)
	$(CB_PATH_Gpp) $(GPP_FLAGS) -DTEST $< $(DIST_BOOT_KERNEL) -o $@
#####################################################################
$(DIST_OBJ_DIR)/%.o			:	src/%.s Makefile *.mk
	@echo "########## $(@) ############"
	mkdir -p $(@D)
	$(CB_PATH_Gas) $(GAS_FLAGS) -o $@ $<
#####################################################################
$(DIST_BOOT_KERNEL): $(DIST_ALL_OBJS) | $(linker.ld) 
	@echo "########## $(@) ############"
	mkdir -p $(@D)
	echo $(BQos_CPP_S)
	echo $(DIST_ALL_OBJS)
	$(CB_PATH_Gpp) $(LINK_FLAGS) -o $@ $^
#####################################################################
$(DIST_BOOT_GRUB_CONFIG): $(DIST_BOOT_KERNEL)
	@echo "########## $(@) ############"
	mkdir -p $(@D)
	echo "menuentry \"Operating System\" {\n  multiboot /boot/$(TARGET).kernel\n }\n" >> $(DIST_BOOT_GRUB_CONFIG)
#####################################################################	
$(DIST_INCLUDE_DIR):
	@echo "########## $(@) ############"
	mkdir -p $(@D)/
	cp -rfav $(BQos_HPP_S) $(DIST_INCLUDE_DIR)
#####################################################################	
$(DIST_SOURCES_DIR):
	@echo "########## $(@) ############"
	mkdir -p $(@D)/
	cp -rfav $(BQos__DIR)/ $(DIST_SOURCES_DIR)	
#####################################################################	
$(DIST_DOCS_DIR): $(BQos_CPP_SRCS) $(BQos_HPP_SRCS)
	@echo "########## $(@) ############"
	mkdir -p $(@)/
	doxygen
#####################################################################	
$(TARGET_DIR).iso:  $(DIST_BOOT_GRUB_CONFIG) 
	@echo "########## $(@) ############"
	grub-mkrescue -o $@ $(TARGET_DIR)
#####################################################################
all: $(TARGET_DIR).iso
	@echo "########## $(@) ############"
#####################################################################
is-multiboot-kernel: $(DIST_BOOT_KERNEL)
	@echo "########## IS-MULTIBOOT-KERNEL? ############"
	grub-file --is-x86-multiboot $(DIST_BOOT_KERNEL) || exit 1 "Not Multiboot Kernel."
#####################################################################
run-kernel: $(DIST_BOOT_KERNEL) is-multiboot-kernel
	@echo "########## RUN-KERNEL ############"
	qemu-system-i386 -kernel $(DIST_BOOT_KERNEL) 
#####################################################################
run-iso: $(TARGET_DIR).iso
	@echo "########## RUN-ISO ############"
	qemu-system-i386 -cdrom ../BQos-$(TARGET).iso
#####################################################################
check: testdrivers
	@echo "########## CHECK ############"
	-@rc=0; count=0; \
	for file in $(DIST_TST_OBJS); do \
		echo "TST		$$file"; ./$$file; \
		rc=`expr $$rc +$$?`; count=`expr $$count + 1`; \
		done; \
		echo; echo "Test executed: $$count		Tests failed: $$rc"
#####################################################################
testdrivers: $(DIST_TST_OBJS)
	@echo "########## TESTDRIVERS ############"
	echo $(BQos__DIR)
	echo $(BQos_CPP_S)
	echo $(DIST_CPP_OBJS)
	echo $(DIST_TST_OBJS)

#####################################################################
todolist:
	-@for file in $(ALLFILES:Makefile=); do fgrep -H -e TODO -e FIXME $$file; done; true
#####################################################################
build-deps:
	sudo apt-get install build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev libisl-dev texinfo doxygen graphviz xorriso -y
run-deps:
	sudo apt-get install qemu-system-x86 -y
docs:
	doxygen