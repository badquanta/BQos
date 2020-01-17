include MAKE/libbq.conf.mk
status-libbq:
	@echo GPPFLAGS $(LIBBQ_GPPFLAGS)
	@echo HPP path "$(LIBBQ_HPP_SRC_DIR)"
	@echo CPP path $(LIBBQ_CPP_SRC_DIR)
	@$(STATUS) "$(LIBBQ_CPP_SRCS)" "libbq CPP sources"
	$(STATUS) "$(LIBBQ_C_SRCS)" "libbq C sources"
	$(STATUS) $(LIBBQ_DST)
status-libbq-nm:
	$(XNM) $(LIBBQ_DST)
status-libbq-includes:
	@echo "LibBQ Includes"
	$(STATUS) "$(LIBBQ_HPP_SRCS)" "libbq HPP"
status-libbq-objs:
	$(STATUS) "$(LIBBQ_OBJS)" "libbq Objects"

status-install-libbq-includes:
	@echo "LibBQ Install Includes:"
	$(STATUS) "$(LIBBQ_HPP_DST)" "libbq SYSROOT INCLUDE"

install-libbq-includes $(LIBBQ_HPP_DST_DIR): $(LIBBQ_HPP_DST)

clean-libbq-includes: 
	$(CLEAN) $(LIBBQ_HPP_DST)
clean-libbq-objs:
	$(CLEAN) $(LIBBQ_OBJS)
clean-libbq: clean-libbq-objs
	$(CLEAN) $(LIBBQ_DST)
ALL_CLEAN += clean-libbq
ALL_MOSTLYCLEAN += clean-libbq-includes 
$(LIBBQ_HPP_DST_DIR)/%.hpp : $(LIBBQ_HPP_SRC_DIR)/%.hpp
	@mkdir -p $(@D)
	$(info "making $@...")
	@cp -fv $< $@

$(LIBBQ_DST_DIR)/%.o : $(LIBBQ_CPP_SRC_DIR)/%.cpp | $(XGPP) # install-libbq-includes
	@mkdir -p $(@D)
	@echo "XGPP $<"
	@$(XGPP) $(LIBBQ_GPPFLAGS) -c $< -o $@
	
$(LIBBQ_DST_DIR)/%.o : $(LIBBQ_CPP_SRC_DIR)/%.c | $(XGPP) # install-libbq-includes
	@mkdir -p $(@D)
	@echo "XGPP $<"
	@$(XGPP) $(LIBBQ_GPPFLAGS) -c $< -o $@	

libbq $(LIBBQ_DST): $(LIBBQ_OBJS) $(XAR)
	@mkdir -p $(@D)
	$(XAR) rcs $@ $(LIBBQ_OBJS)