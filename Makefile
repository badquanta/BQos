include MAKE/goals.mk
include $(ALL_DEP_FILES)
CONFIG.mk: CONFIG.mk.IN config.status
	./config.status