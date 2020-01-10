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

xgcc-configure $(XGCC_MAKEFILE) $(XGCC_CONFIGURE_TARGET):$(LIBC_INC_DST_DIR) $(XBINUTILS_INSTALL_TARGET) $(XGCC_SRC_DIR) 
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

xstdcpp-make-install  $(XGPP_MAKE_INSTALL_TARGET): $(LIBC_DST)
	rm -f $(XGPP_MAKE_INSTALL_TARGET)
	cd $(XBUILD_GCC) && make all-target-libstdc++-v3 -j $(XJOBS) >> $(TARGETS)/build.log 2>&1
	cd $(XBUILD_GCC) && make install-target-libstdc++-v3 #$(REDIRECT)$(XGPP_MAKE_INSTALL_TARGET)	>> $(TARGETS)/build.log 2>&1
	touch $(XGPP_MAKE_INSTALL_TARGET)
	$(UPDATE_STATUS)
	@echo "XGCC Installed."

#


##### how to make sysroot libc headers
$(LIBC_INC_DST_DIR): $(LIBC_H_DST) 
	touch $@
	$(UPDATE_STATUS)


libc-h-dst: $(LIBC_H_DST)
	@./status.sh "$(LIBC_H_DST)"
clean-libc-h-dst:
	@rm -f $(LIBC_H_DST)
	@./status.sh "$(LIBC_H_DST)"
$(LIBC_INC_DST_DIR)/%.h : $(LIBC_INC_DIR)/%.h 
	mkdir -p $(@D)
	cp -fv $< $@
	
##### how to make sysroot libc objects
$(LIBC_BUILD_DIR)/%.o:  $(LIBC_SRC_DIR)/%.c | $(XGCC) #$(LIBC_INC_DST_DIR)
	mkdir -p $(@D)
	$(XGCC) $(LIBC_GCFLAGS) -c $< -o $@
	@#$(UPDATE_STATUS)
##### how to make sysroot libk objects
$(LIBK_BUILD_DIR)/%.libk: $(LIBC_SRC_DIR)/%.c | $(XGCC) #$(LIBC_INC_DST_DIR)
	mkdir -p $(@D)
	$(XGCC) $(LIBC_GCFLAGS) -c $< -o $@
	@#$(UPDATE_STATUS)
	
$(LIBC_TST_DIR)/%.t: $(LIBC_SRC_DIR)/%.c | $(XGCC)
	mkdir -p $(@D)
	$(XGCC) $(LIBC_TEST_FLAGS) $< -o $@
##### how to make libc test executables
$(LIBC_TST_DIR)/%_TEST: $(LIBC_SRC_DIR)/%.c $(LIBC_DST) | $(XGCC)
	mkdir -p $(@D)
	$(XGCC) $(LIBC_TEST_FLAGS) -DTEST $< $(LIBC_DST) -o $@
	$@

libc-tests: $(LIBC_TESTS)
	@#@echo "########## CHECK ############"
	@#-@rc=0; count=0; \
	#for file in $(LIBC_TESTS); do \
	#	echo "TST		$$file"; ./$$file; \
	#	rc=`expr $$rc +$$?`; count=`expr $$count + 1`; \
	#	done; \
	#	echo; echo "Test executed: $$count		Tests failed: $$rc"

XALL_DEFAULTS += libc-tests	
##### how to make sysroot libc objects
$(LIBC_BUILD_DIR)/%.o:  $(LIBC_SRC_DIR)/%.s |  $(XAS)
	mkdir -p $(@D)
	$(XAS) $(LIBC_GASFLAGS)  $< -o $@
	@#$(UPDATE_STATUS)
##### how to make sysroot libk objects
$(LIBK_BUILD_DIR)/%.libk: $(LIBC_SRC_DIR)/%.s |  $(XAS)
	mkdir -p $(@D)
	$(XAS) $(LIBC_GASFLAGS)  $< -o $@
	@#$(UPDATE_STATUS)

libc: $(LIBC_DST)
	$(UPDATE_STATUS)
libk: $(LIBK_DST) 
#	$(UPDATE_STATUS)

XALL_PHONY += libc libk
#XALL_DEFAULTS += libc libk

$(LIBC_DST): $(LIBC_OBJS) $(XAR)
	mkdir -p $(@D)
	$(XAR) rcs $@ $(LIBC_OBJS)
	$(UPDATE_STATUS)

$(LIBK_DST): $(LIBK_OBJS) $(XAR)
	mkdir -p $(@D)
	$(XAR) rcs $@ $(LIBK_OBJS)
	$(UPDATE_STATUS)

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

run-BQos-KERNEL: $(BQos_BOOT_KERNEL)
	qemu-system-i386 -kernel $<


clean-BQos-OBJS:
	rm -f $(BQos_OBJS)
clean-BQos-KERNELS:
	rm -f $(BQos_BOOT_KERNEL)
clean-BQos: clean-BQos-OBJS clean-BQos-KERNELS
XALL_PHONY += clean-BQos-OBJS clean-BQos-KERNELS clean-BQos
#XALL_DEFAULTS += $(BQos_BOOT_KERNEL)
###############################################################################

$(BQos_ISO): $(BQos_BOOT_GRUB_CONFIG)
	grub-mkrescue -o $@ $(SYSROOT)

$(BQos_BOOT_GRUB_CONFIG): $(BQos_BOOT_KERNEL)
	@echo "########## $(@) ############"
	mkdir -p $(@D)
	echo "menuentry \"Operating System\" {\n  multiboot $(BQos_BOOT_KERNEL)\n }\n" >> $(BQos_BOOT_GRUB_CONFIG)
XALL_DEFAULTS += $(BQos_ISO)
include STATUS.mk

update-status-svg: 
	@rm -f make.status.svg
	@make -nd | \
	tee make.Bnd | \
	make2graph |\
	unflatten |\
	sed "s@$(SYSROOT)@S@g" |\
	sed "s@$(XPREFIX)@X@g" |\
	sed "s@$(PROJECT_SRC_DIR)@./@g" |\
	sed "s@$(HOME)/Work/@@g" |\
	tee make.status.dot |\
	dot -y -T svg -o make.status.svg
	@cat make.Bnd | makefile2graph  -f L
XALL_PHONY+=update-status-svg
XALL_SUFFIXES+= .svg

.PHONY: $(XALL_PHONY)
all: $(XALL_DEFAULTS)
SHELL = /bin/sh
.SUFFIXES:
.SUFFIXES: $(XALL_SUFFIXES)