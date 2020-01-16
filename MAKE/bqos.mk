include MAKE/all.conf.mk
include MAKE/bqos.conf.mk
status-bqos-objs:
	$(STATUS) "$(BQos_OBJS)"
status-bqos-includes:
	$(STATUS)"$(BQos_HPP_DST)"
status-bqos-includes-src:
	$(STATUS) "$(BQos_HPP_SRCS)"
status-bqos:
	$(STATUS) "$(BQos_CPP_SRC_DIR)" "cpp src"
	$(STATUS) "$(BQos_S_SRC_DIR)" "assembler src"
	$(STATUS) "$(BQos_HPP_SRC_DIR)" "hpp includes"
	$(STATUS) "$(BQos_HPP_DST_DIR)" "hpp install"
	$(STATUS) "$(BQos_DST_DIR)" "BQos install"
	$(STATUS) "$(BQos_BOOT)" "boot"
	$(STATUS) "$(BQos_BOOT_GRUB)" "grub config"
	$(STATUS) "$(BQos_BOOT_KERNEL)" "Kernel"
	
$(BQos_HPP_DST_DIR): $(BQos_HPP_DST)

$(BQos_HPP_DST_DIR)/%.hpp : $(BQos_HPP_SRC_DIR)/%.hpp
	@mkdir -p $(@D)
	@cp -fv $< $@
# src/**.cpp -> *.o
$(BQos_DST_DIR)/%.o : $(BQos_CPP_SRC_DIR)/%.cpp | $(XGPP) $(ALL_INCLUDES)
	@mkdir -p $(@D)
	@echo "XGPP $<"
	@$(XGPP) $(BQos_GCFLAGS) -o $@ -c $<


# src/**.s -> *.o
$(BQos_DST_DIR)/%.o : $(BQos_S_SRC_DIR)/%.s | $(XAS)
	@mkdir -p $(@D)
	@echo "XAS $<"
	@$(XAS) $(BQos_GASFLAGS) -o $@ $<
################################################################################ Boot Kernel/loader
$(BQos_BOOT_KERNEL): $(BQos_OBJS) $(LIBBQ_DST) $(LIBK_DST) | $(linker.ld)
	@mkdir -p $(@D)
	@echo "XGPP $<"
	@$(XGPP) $(BQos_KERNEL_LINK_FLAGS) -o $@ $^
	$(UPDATE_STATUS)
ALL_DEFAULTS += $(BQos_BOOT_KERNEL)

run-BQos-KERNEL: $(BQos_BOOT_KERNEL)
	qemu-system-i386 -kernel $<

run-BQos-iso: $(BQos_ISO)
	qemu-system-i386 -cdrom $(BQos_ISO)
	
clean-BQos-OBJS:
	$(CLEAN) $(BQos_OBJS)
	$(UPDATE_STATUS)
clean-BQos-KERNELS:
	$(CLEAN) $(BQos_BOOT_KERNEL)
	$(UPDATE_STATUS)
clean-BQos: clean-BQos-OBJS clean-BQos-KERNELS
	$(UPDATE_STATUS)
ALL_PHONY += clean-BQos-OBJS clean-BQos-KERNELS clean-BQos
clean: clean-BQos clean-libc clean-libk
#ALL_TARGETS += $(BQos_BOOT_KERNEL)
###############################################################################

BQos-iso $(BQos_ISO): $(BQos_BOOT_GRUB_CONFIG)
	grub-mkrescue -o $@ $(SYSROOT)

$(BQos_BOOT_GRUB_CONFIG): $(BQos_BOOT_KERNEL)
	@echo "########## $(@) ############"
	mkdir -p $(@D)
	echo "menuentry \"Operating System\" {\n  multiboot $(BQos_BOOT_KERNEL:$(SYSROOT)%=%)\n }\n" > $(BQos_BOOT_GRUB_CONFIG)
	$(UPDATE_STATUS)
	
