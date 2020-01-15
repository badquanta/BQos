include MAKE/goals.mk

CONFIG.mk: CONFIG.mk.IN config.status
	./config.status