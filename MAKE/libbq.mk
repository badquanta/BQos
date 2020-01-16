include MAKE/libbq.conf.mk
status-libbq:
	$(STATUS) $(LIBBQ_DST)


status-libbq-includes:
	@echo "LibBQ Includes"
	$(STATUS) "$(LIBBQ_HPP_SRCS)" "libBQ HPP"

status-install-libbq-includes:
	@echo "LibBQ Install Includes:"
	$(STATUS) "$(LIBBQ_HPP_DST)" "libBQ SYSROOT INCLUDE"

install-libbq-includes $(LIBBQ_HPP_DST_DIR): $(LIBBQ_HPP_DST)

clean-libbq-includes: 
	$(CLEAN) $(LIBBQ_HPP_DST)
clean-libbq-objs:
	$(CLEAN) $(LIBBQ_OBJS)
clean-libbq: clean-libbq-includes clean-libbq-objs
	$(CLEAN) $(LIBBQ_DST)

$(LIBBQ_HPP_DST_DIR)/%.hpp : $(LIBBQ_HPP_SRC_DIR)/%.hpp
	@mkdir -p $(@D)
	$(info "making $@...")
	@cp -fv $< $@

$(LIBBQ_DST_DIR)/%.o : $(LIBBQ_CPP_SRC_DIR)/%.cpp | $(XGPP) install-libbq-includes
	@echo "XGPP $<"
	@$(XGPP) $(LIBBQ_GPPFLAGS) -c $< -o $@
	
$(LIBBQ_DST_DIR)/%.o : $(LIBBQ_CPP_SRC_DIR)/%.c | $(XGPP) install-libbq-includes
	@echo "XGPP $<"
	@$(XGPP) $(LIBBQ_GPPFLAGS) -c $< -o $@	

libbq $(LIBBQ_DST): $(LIBBQ_OBJS) $(XAR)
	@mkdir -p $(@D)
	$(XAR) rcs $@ $(LIBBQ_OBJS)