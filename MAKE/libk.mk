# libk's config...
include MAKE/libk.conf.mk
status-libk:
	@echo "LIBK_GCFLAGS" $(LIBK_GCFLAGS)
	$(STATUS) $(LIBK_DST)
status-libk-nm:	
	$(XNM) $(LIBK_DST)
status-libk-objs:
	$(STATUS) "$(LIBK_OBJS)"
status-libk-all: status-libk status-libk-objs
	@echo LIBK_GCFLAGS $(LIBK_GCFLAGS)
##### how to make sysroot libk objects
$(LIBK_BUILD_DIR)/%.libk $(LIBK_BUILD_DIR)/%.d: $(LIBC_SRC_DIR)/%.c | $(XGCC) #$(SYS_INC)
	@mkdir -p $(@D)
	@echo LIBK XGPP $< -> $@
	@$(XGPP) $(LIBK_GCFLAGS) -c $< -o $@ 
	@#	
##### how to make sysroot libk objects
$(LIBK_BUILD_DIR)/%.libk:  $(LIBC_SRC_DIR)/%.s |  $(XAS)
	@mkdir -p $(@D)
	@echo LIBK XAS $< -> $@
	@$(XAS) $(LIBK_GASFLAGS)  $< -o $@
	@#
libk $(LIBK_DST): $(LIBK_OBJS) $(BQos_OBJS) $(XAR)
	@mkdir -p $(@D)
	@$(XAR) rcs $@ $(LIBK_OBJS) $(BQos_OBJS)
	@$(UPDATE_STATUS)	
	
ALL_MOSTLYCLEAN += clean-libk-objs
clean-libk: clean-libk-objs
	@$(CLEAN) $(LIBK_DST)
ALL_CLEAN += clean-libk
clean-libk-objs:
	@$(CLEAN) $(LIBK_OBJS)
	

	
	
	