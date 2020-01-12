include LIBC.mk
libc-h-dst: $(LIBC_H_DST)
	@./status.sh "$(LIBC_H_DST)"
clean-libc-h-dst:
	@rm -f $(LIBC_H_DST)
	@./status.sh "$(LIBC_H_DST)"
$(SYS_INC)/%.h : $(LIBC_INC_DIR)/%.h 
	mkdir -p $(@D)
	cp -fv $< $@
# LIBC depends on XGCC being installed.
include XGCC.mk
$(LIBC_BUILD_DIR)/%.o:  $(LIBC_SRC_DIR)/%.c | $(XGCC) #$(SYS_INC)
	mkdir -p $(@D)
	$(XGCC) $(LIBC_GCFLAGS) -c $< -o $@
	@#$(UPDATE_STATUS)
#ALL_TARGETS += libc-tests	
##### how to make sysroot libc objects
$(LIBC_BUILD_DIR)/%.o:  $(LIBC_SRC_DIR)/%.s |  $(XAS)
	mkdir -p $(@D)
	$(XAS) $(LIBC_GASFLAGS)  $< -o $@
	@#$(UPDATE_STATUS)


$(LIBC_DST): $(LIBC_OBJS) $(XAR)
	mkdir -p $(@D)
	$(XAR) rcs $@ $(LIBC_OBJS)
	$(UPDATE_STATUS)
clean-libc:
	$(CLEAN) $(LIBC_DST)
ALL_MOSTLYCLEAN	+= clean-libc
ALL_PHONY 		+= clean-libc
###################################################################
clean-libc-objs:
	$(CLEAN) $(LIBC_OBJS)
ALL_CLEAN += clean-libc-objs
ALL_PHONY += clean-libc-objs

############################################# *.t
# TODO: LIBC_TST_OBJS		:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBC_TST_DIR)/%.t)
# TODO: ALL_SUFFIXES		+= .t
# TODO: LIBC_TESTS			:= $(LIBC_C_SRCS:$(LIBC_SRC_DIR)/%.c=$(LIBC_TST_DIR)/%_TEST)
# TODO: ALL_SUFFIXES				+= _TEST
############################################################## RULES

	
# TODO: $(LIBC_TST_DIR)/%.t: $(LIBC_SRC_DIR)/%.c | $(XGCC)
#	mkdir -p $(@D)
#	$(XGCC) $(LIBC_TEST_FLAGS) $< -o $@

# TODO: ##### how to make libc test executables
#$(LIBC_TST_DIR)/%_TEST: $(LIBC_SRC_DIR)/%.c $(LIBC_DST) | $(XGCC)
#	mkdir -p $(@D)
#	$(XGCC) $(LIBC_TEST_FLAGS) -DTEST $< $(LIBC_DST) -o $@
# TODO:libc-tests: $(LIBC_TESTS)
#	@#@echo "########## CHECK ############"
#	@rc=0; count=0; \
	for file in $(LIBC_TESTS); do \
		echo "TST		$$file"; ./$$file; \
		rc=`expr $$rc +$$?`; count=`expr $$count + 1`; \
		done; \
		echo; echo "Test executed: $$count		Tests failed: $$rc"

	

