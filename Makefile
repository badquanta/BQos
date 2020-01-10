default: all

include CONFIG.mk

Makefile: CONFIG.mk

$(XBINUTILS_SRC_DIR): CONFIG.mk
	$(GIT_SHALLOW) $(BINUTILS_GIT_BRANCH)  $(BINUTILS_GIT) $(XBINUTILS_SRC_DIR) >> $(TARGETS)/build.log 2>&1 || cd $(XBINUTILS_SRC_DIR) && git pull
	touch $(XBINUTILS_SRC_DIR)
	$(UPDATE_STATUS)

xbinutils-configure $(XBINUTILS_CONFIGURE_TARGET) $(XBINUTILS_MAKEFILE): $(XBINUTILS_SRC_DIR)  
	rm -f $(XBINUTILS_CONFIGURE_TARGET)
	mkdir -p $(XBUILD_BINUTILS)
	cd $(XBUILD_BINUTILS) && $(XBINUTILS_SRC_DIR)/configure $(XBINUTILS_CONFIGURE_PARAMS) #$(REDIRECT)$(XBINUTILS_CONFIGURE_TARGET) >> $(TARGETS)/build.log 2>&1
	$(UPDATE_STATUS)
	@echo "XBINUTILS configured"
xbinutils-make $(XBINUTILS_MAKE_TARGET): $(XBINUTILS_MAKEFILE)
	rm -f $(XBINUTILS_MAKE_TARGET)
	cd $(XBUILD_BINUTILS) && make -j $(XJOBS) >> $(TARGETS)/build.log 2>&1
	touch $(XBINUTILS_MAKE_TARGET)
# $(REDIRECT)   $(XBINUTILS_MAKE_TARGET)
	$(UPDATE_STATUS)
xbinutils-install $(XBINUTILS_INSTALL_TARGET): $(XBINUTILS_MAKE_TARGET)
	cd $(XBUILD_BINUTILS) && make install >> $(TARGETS)/build.log 2>&1
# $(REDIRECT)  $(XBINUTILS_INSTALL_TARGET)
	touch $(XBINUTILS_INSTALL_TARGET)
	$(UPDATE_STATUS)
	@echo "XBINUTILS installed"
$(XBINUTILS_TARGETS): $(XBINUTILS_INSTALL_TARGET)

$(XGCC_TARGETS): $(XGCC_MAKE_INSTALL_TARGET)
$(XGPP_TARGETS): $(XGPP_MAKE_INSTALL_TARGET)

$(XGCC_SRC_DIR): 
	$(GIT_SHALLOW) $(GCC_BRANCH) $(GCC_GIT) $(XGCC_SRC_DIR) >> $(TARGETS)/build.log 2>&1
	$(UPDATE_STATUS)

xgcc-configure $(XGCC_MAKEFILE) $(XGCC_CONFIGURE_TARGET):$(SYS_INCLUDES) $(XBINUTILS_INSTALL_TARGET) $(XGCC_SRC_DIR) 
	rm -f $(XGCC_CONFIGURE_TARGET)
	mkdir -p $(XBUILD_GCC)
	cd $(XBUILD_GCC) && $(XGCC_SRC_DIR)/configure $(XGCC_CONFIGURE_PARAMS)>> $(TARGETS)/build.log 2>&1
# $(REDIRECT)  $(XGCC_CONFIGURE_TARGET)
	$(UPDATE_STATUS)
	@echo "XGCC Configured."

xgcc-make-install $(XGCC_MAKE_INSTALL_TARGET):$(XGCC_MAKEFILE)
	rm -f $(XGCC_MAKE_INSTALL_TARGET)
	cd $(XBUILD_GCC) && make all-gcc -j $(XJOBS)>> $(TARGETS)/build.log 2>&1
	cd $(XBUILD_GCC) && make install-gcc>> $(TARGETS)/build.log 2>&1
	cd $(XBUILD_GCC) && make all-target-libgcc -j $(XJOBS)>> $(TARGETS)/build.log 2>&1
	cd $(XBUILD_GCC) && make install-target-libgcc>> $(TARGETS)/build.log 2>&1
	$(UPDATE_STATUS)
	touch $(XGCC_MAKE_INSTALL_TARGET)
	@echo "XGCC Built."

xgpp-make-install  $(XGPP_MAKE_INSTALL_TARGET): $(LIBC_DST)
	rm -f $(XGPP_MAKE_INSTALL_TARGET)
	cd $(XBUILD_GCC) && make all-target-libstdc++-v3 -j $(XJOBS) >> $(TARGETS)/build.log 2>&1
	cd $(XBUILD_GCC) && make install-target-libstdc++-v3 #$(REDIRECT)$(XGPP_MAKE_INSTALL_TARGET)	>> $(TARGETS)/build.log 2>&1
	touch $(XGPP_MAKE_INSTALL_TARGET)
	$(UPDATE_STATUS)
	@echo "XGCC Installed."

#


##### how to make sysroot libc headers


libc-h-dst: $(LIBC_H_DST)
	@./status.sh "$(LIBC_H_DST)"
clean-libc-h-dst:
	@rm -f $(LIBC_H_DST)
	@./status.sh "$(LIBC_H_DST)"
	
$(SYS_USR_INC)/%.h : $(LIBC_INC_DIR)/%.h 
	mkdir -p $(@D)
	cp -fv $< $@
$(BQos_HPP_DST_DIR): $(BQos_HPP_DST)

$(BQos_HPP_DST_DIR)/%.hpp : $(BQos_HPP_SRC_DIR)/%.hpp
	mkdir -p $(@D)
	cp -fv $< $@
$(libBQ_HPP_DST_DIR): $(libBQ_HPP_DST)

$(libBQ_HPP_DST_DIR)/%.hpp : $(libBQ_HPP_SRC_DIR)/%.hpp
	mkdir -p $(@D)
	cp -fv $< $@	
##### how to make sysroot libc objects
$(LIBC_BUILD_DIR)/%.o:  $(LIBC_SRC_DIR)/%.c | $(XGCC) #$(SYS_USR_INC)
	mkdir -p $(@D)
	$(XGCC) $(LIBC_GCFLAGS) -c $< -o $@
	@#$(UPDATE_STATUS)
##### how to make sysroot libk objects
$(LIBK_BUILD_DIR)/%.libk $(LIBK_BUILD_DIR)/%.d: $(LIBC_SRC_DIR)/%.c | $(XGCC) #$(SYS_USR_INC)
	mkdir -p $(@D)
	$(XGPP) $(LIBK_GCFLAGS) -c $< -o $@ 
	@#$(UPDATE_STATUS)
	
$(LIBC_TST_DIR)/%.t: $(LIBC_SRC_DIR)/%.c | $(XGCC)
	mkdir -p $(@D)
	$(XGCC) $(LIBC_TEST_FLAGS) $< -o $@
##### how to make libc test executables
$(LIBC_TST_DIR)/%_TEST: $(LIBC_SRC_DIR)/%.c $(LIBC_DST) | $(XGCC)
	mkdir -p $(@D)
	$(XGCC) $(LIBC_TEST_FLAGS) -DTEST $< $(LIBC_DST) -o $@
	

libc-tests: $(LIBC_TESTS)
	@#@echo "########## CHECK ############"
	@rc=0; count=0; \
	for file in $(LIBC_TESTS); do \
		echo "TST		$$file"; ./$$file; \
		rc=`expr $$rc +$$?`; count=`expr $$count + 1`; \
		done; \
		echo; echo "Test executed: $$count		Tests failed: $$rc"

#XALL_DEFAULTS += libc-tests	
##### how to make sysroot libc objects
$(LIBC_BUILD_DIR)/%.o:  $(LIBC_SRC_DIR)/%.s |  $(XAS)
	mkdir -p $(@D)
	$(XAS) $(LIBC_GASFLAGS)  $< -o $@
	@#$(UPDATE_STATUS)
##### how to make sysroot libk objects
$(LIBK_BUILD_DIR)/%.libk:  $(LIBC_SRC_DIR)/%.s |  $(XAS)
	mkdir -p $(@D)
	$(XAS) $(LIBC_GASFLAGS)  $< -o $@
	@#$(UPDATE_STATUS)

libc: $(LIBC_DST)
	$(UPDATE_STATUS)
libk: $(LIBK_DST) 
	$(UPDATE_STATUS)

XALL_PHONY += libc libk
#XALL_DEFAULTS += libc libk

$(LIBC_DST): $(LIBC_OBJS) $(XAR)
	mkdir -p $(@D)
	$(XAR) rcs $@ $(LIBC_OBJS)
	$(UPDATE_STATUS)

$(LIBK_DST): $(LIBK_OBJS) $(BQos_OBJS) $(XAR)
	mkdir -p $(@D)
	$(XAR) rcs $@ $(LIBK_OBJS) $(BQos_OBJS)
	$(UPDATE_STATUS)
clean-libk:
	rm -f $(LIBK_DST) $(LIBK_OBJS)
clean-libc:
	rm -f $(LIBC_DST) $(LIBC_OBJS)
$(TARGETS) $(XPREFIX) $(SYSROOT) $(XBUILD_GCC) $(XBUILD_BINUTILS):
	mkdir -p $@

clean-all:
	mkdir -p $(TARGETS)
	rm -rf $(XPREFIX) $(TARGETS)/*.log $(SYSROOT)
	@#$(UPDATE_STATUS)
XALL_PHONY += clean-all

# src/**.cpp -> *.o
$(BQos_DST_DIR)/%.o : $(BQos_CPP_SRC_DIR)/%.cpp | $(XGPP) 
	mkdir -p $(@D)
	$(XGPP) $(BQos_GCFLAGS) -o $@ -c $<
# src/**.s -> *.o
$(BQos_DST_DIR)/%.o : $(BQos_S_SRC_DIR)/%.s | $(XAS)
	mkdir -p $(@D)
	$(XAS) $(BQos_GASFLAGS) -o $@ $<
################################################################################ Boot Kernel/loader
$(BQos_BOOT_KERNEL): $(BQos_OBJS) $(LIBK_DST) | $(linker.ld)
	mkdir -p $(@D)
	$(XGPP) $(BQos_KERNEL_LINK_FLAGS) -o $@ $^
	$(UPDATE_STATUS)

run-BQos-KERNEL: $(BQos_BOOT_KERNEL)
	qemu-system-i386 -kernel $<

run-BQos-iso: $(BQos_ISO)
	qemu-system-i386 -cdrom $(BQos_ISO)
	
clean-BQos-OBJS:
	rm -f $(BQos_OBJS)
	$(UPDATE_STATUS)
clean-BQos-KERNELS:
	rm -f $(BQos_BOOT_KERNEL)
	$(UPDATE_STATUS)
clean-BQos: clean-BQos-OBJS clean-BQos-KERNELS
	$(UPDATE_STATUS)
XALL_PHONY += clean-BQos-OBJS clean-BQos-KERNELS clean-BQos
clean: clean-BQos clean-libc clean-libk
#XALL_DEFAULTS += $(BQos_BOOT_KERNEL)
###############################################################################

BQos-iso $(BQos_ISO): $(BQos_BOOT_GRUB_CONFIG)
	grub-mkrescue -o $@ $(SYSROOT)

$(BQos_BOOT_GRUB_CONFIG): $(BQos_BOOT_KERNEL)
	@echo "########## $(@) ############"
	mkdir -p $(@D)
	echo "menuentry \"Operating System\" {\n  multiboot $(BQos_BOOT_KERNEL:$(SYSROOT)%=%)\n }\n" > $(BQos_BOOT_GRUB_CONFIG)
	$(UPDATE_STATUS)
	
XALL_DEFAULTS += $(BQos_ISO)
include STATUS.mk
include $(XALL_DS)
update-status-svg: 
	@rm -f make.status.svg
	@make -nd | \
	tee make.Bnd | \
	make2graph |\
	unflatten |\
	tee make.status.dot |\
	dot -y -T svg -o make.status.svg
	@cat make.Bnd | make2graph  -fx > make.status.gexf

XALL_PHONY+=update-status-svg
XALL_SUFFIXES+= .svg

.PHONY: $(XALL_PHONY)
all: $(XALL_DEFAULTS)
SHELL = /bin/sh
.SUFFIXES:
.SUFFIXES: $(XALL_SUFFIXES)