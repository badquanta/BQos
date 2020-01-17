include MAKE/common.conf.mk
include MAKE/xbinutils.conf.mk
############################################################################# RULES:
#	git clone the binutils source
$(XBINUTILS_SRC_DIR): Makefile # $(CONFIG_STATUS)
	
	#$(GIT_SHALLOW) $(BINUTILS_GIT_BRANCH)  $(BINUTILS_GIT) $(XBINUTILS_SRC_DIR)  $(REDIRECT)
	git submodule init
	git submodule fetch
	#touch $(XBINUTILS_SRC_DIR)
	#	run `./configure` from the binutils src dir but within the build dir.		
xbinutils-configure $(XBINUTILS_CONFIGURE_TARGET): $(XBINUTILS_SRC_DIR)  
	$(CLEAN) $(XBINUTILS_CONFIGURE_TARGET)
	@mkdir -p $(XBUILD_BINUTILS)
	cd $(XBUILD_BINUTILS) && $(XBINUTILS_SRC_DIR)/configure $(XBINUTILS_CONFIGURE_PARAMS) $(REDIRECT) 
	$(REACHED) $(XBINUTILS_CONFIGURE_TARGET)
		@echo "XBINUTILS configured"
#	run `make` from within the binutils build dir.
xbinutils-make $(XBINUTILS_MAKE_TARGET): $(XBINUTILS_CONFIGURE_TARGET)
	$(CLEAN) $(XBINUTILS_MAKE_TARGET)
	@echo -n making $@...
	@cd $(XBUILD_BINUTILS) && make -j $(JOBS)  $(REDIRECT)	
	@echo done
	$(REACHED) $(XBINUTILS_MAKE_TARGET)
#	run `make install` from within the binutils build dir	
xbinutils-install $(XBINUTILS_INSTALL_TARGET): $(XBINUTILS_MAKE_TARGET)
	$(CLEAN) $(XBINUTILS_INSTALL_TARGET)
	@cd $(XBUILD_BINUTILS) && make install  $(REDIRECT)
	$(REACHED) $(XBINUTILS_INSTALL_TARGET)
	
