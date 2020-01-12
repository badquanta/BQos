include LIBBQ.mk

status-libbq-includes:
	@echo "LibBQ Includes"
	$(STATUS) "$(libBQ_HPP_SRCS)" "libBQ HPP"

status-install-libbq-includes:
	@echo "LibBQ Install Includes:"
	$(STATUS) "$(libBQ_HPP_DST)" "libBQ SYSROOT INCLUDE"

install-libbq-includes $(libBQ_HPP_DST_DIR): $(libBQ_HPP_DST)

clean-libbq-includes: 
	$(CLEAN) $(libBQ_HPP_DST)

$(libBQ_HPP_DST_DIR)/%.hpp : $(libBQ_HPP_SRC_DIR)/%.hpp
	@mkdir -p $(@D)
	$(info "making $@...")
	@cp -fv $< $@

$(libBQ_DST_DIR)/%.o : $(libBQ_CPP_SRC_DIR)/%.cpp | $(XGPP) install-libbq-includes
	$(XGPP) $(libBQ_GPPFLAGS) -c $< -o $@
	
$(libBQ_DST_DIR)/%.o : $(libBQ_CPP_SRC_DIR)/%.c | $(XGPP) install-libbq-includes
	$(XGPP) $(libBQ_GPPFLAGS) -c $< -o $@	

libbq $(libBQ_DST): $(libBQ_OBJS) $(LIBK_DST) $(XAR)
	@mkdir -p $(@D)
	$(XAR) rcs $@ $(libBQ_OBJS)