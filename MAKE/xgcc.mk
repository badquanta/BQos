include MAKE/xgcc.conf.mk
include MAKE/libc.conf.mk
#xgcc.mk
#	Created on: Jan 11, 2020
#		Author: badquanta

# AS, LD, etc... connect the executables to how they are generated
$(XBINUTILS_TARGETS): $(XBINUTILS_INSTALL_TARGET)
#	clone GCC using `GCC_GIT` at `GCC_BRANCH` into 
$(XGCC_SRC_DIR): 
	#$(GIT_SHALLOW) $(GCC_BRANCH) $(GCC_GIT) $(XGCC_SRC_DIR)  $(REDIRECT)
	git submodule init
	git submodule fetch
	

xgcc-configure $(XGCC_CONFIGURE_TARGET):$(LIBC_INSTALL_INCLUDES_TARGET) $(XBINUTILS_INSTALL_TARGET) $(XGCC_SRC_DIR) 
	$(CLEAN) $(XGCC_CONFIGURE_TARGET)
	@mkdir -p $(XGCC_BUILD_DIR)
	cd $(XGCC_BUILD_DIR) && $(XGCC_SRC_DIR)/configure $(XGCC_CONFIGURE_PARAMS) $(REDIRECT)
	$(UPDATE_STATUS)
	$(REACHED) $(XGCC_CONFIGURE_TARGET)
	@echo "XGCC Configured."

xgcc-make-shell:
	cd $(XGCC_BUILD_DIR) && bash

xgcc-make-install $(XGCC_MAKE_INSTALL_TARGET):$(XGCC_CONFIGURE_TARGET)
	$(CLEAN) $(XGCC_MAKE_INSTALL_TARGET)
	@echo -n "making $@..."
	cd $(XGCC_BUILD_DIR) && make all-gcc -j $(JOBS) $(REDIRECT)
	cd $(XGCC_BUILD_DIR) && make install-gcc $(REDIRECT)
	cd $(XGCC_BUILD_DIR) && make all-target-libgcc -j $(JOBS) $(REDIRECT)
	cd $(XGCC_BUILD_DIR) && make install-target-libgcc $(REDIRECT)
	@echo done
	$(UPDATE_STATUS)
	$(REACHED) $(XGCC_MAKE_INSTALL_TARGET)
	@echo "XGCC Built."

clean-xgcc clean-xgpp: 
	cd $(XGCC_BUILD_DIR) && make uninstall
	$(CLEAN) $(XGCC_MAKE_INSTALL_TARGET)
	$(CLEAN) $(XGPP_MAKE_INSTALL_TARGET)

xgpp-make-install  $(XGPP_MAKE_INSTALL_TARGET): $(LIBC_DST)
	$(CLEAN) $(XGPP_MAKE_INSTALL_TARGET)
	cd $(XGCC_BUILD_DIR) && make all-target-libstdc++-v3 -j $(JOBS)  $(REDIRECT)
	cd $(XGCC_BUILD_DIR) && make install-target-libstdc++-v3  $(REDIRECT)
	$(REACHED) $(XGPP_MAKE_INSTALL_TARGET)
	$(UPDATE_STATUS)
	@echo "XGCC Installed."
ALL_INSTALL+=xgpp-make-install
#

