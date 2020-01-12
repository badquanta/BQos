# libk's config...
include LIBK.mk
##### how to make sysroot libk objects
$(LIBK_BUILD_DIR)/%.libk $(LIBK_BUILD_DIR)/%.d: $(LIBC_SRC_DIR)/%.c | $(XGCC) #$(SYS_INC)
	mkdir -p $(@D)
	$(XGPP) $(LIBK_GCFLAGS) -c $< -o $@ 
	@#$(UPDATE_STATUS)
	
##### how to make sysroot libk objects
$(LIBK_BUILD_DIR)/%.libk:  $(LIBC_SRC_DIR)/%.s |  $(XAS)
	mkdir -p $(@D)
	$(XAS) $(LIBC_GASFLAGS)  $< -o $@
	@#$(UPDATE_STATUS)

libk $(LIBK_DST): $(LIBK_OBJS) $(BQos_OBJS) $(XAR)
	mkdir -p $(@D)
	$(XAR) rcs $@ $(LIBK_OBJS) $(BQos_OBJS)
	$(UPDATE_STATUS)	
	
ALL_MOSTLYCLEAN += clean-libk-objs
clean-libk:
	$(CLEAN) $(LIBK_DST)
ALL_CLEAN += clean-libk
clean-libk-objs:
	$(CLEAN) $(LIBK_OBJS)
	

	
	
	