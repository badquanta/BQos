#dirs.mk
#	Created on: Jan 11, 2020
#		Author: badquanta
############################################################ *CLEAN*
include ALL.mk # We'll define some extreme clean scenarios.
include DIRS.mk
$(SYS_INC) $(TARGETS):
	mkdir -p $@

clean-XSRC:
	$(CLEAN) $(XSRC_DIR)
ALL_CLOBBER	+= clean-XSRC
clean-XBUILD:
	$(CLEAN) $(XBUILD_DIR)
ALL_REAL_CLEAN	+= clean-XBUILD
clean-SYS_INC:
	$(CLEAN) $(SYS_INC)
ALL_MOSTLY_CLEAN+= clean-SYS_INC

status-dirs:
	./sh/status.sh $(XSRC_DIR)
	./sh/status.sh $(XBUILD_DIR)
	./sh/status.sh $(SYS_INC)