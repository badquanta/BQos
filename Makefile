include MAKE/goals.mk
include $(ALL_DEP_FILES)
MAKE/*.conf.mk: MAKE/config.mk 
MAKE/BQos.conf.mk: MAKE/dirs.conf.mk MAKE/kernels.conf.mk
MAKE/goals.mk: MAKE/all.conf.mk MAKE/dirs.mk MAKE/xbinutils.mk MAKE/xgcc.mk MAKE/libc.mk MAKE/libk.mk MAKE/libbq.mk MAKE/BQos.mk MAKE/status-all.mk
Makefile: MAKE/goals.mk

MAKE/config.mk: MAKE/config.in.mk config.status
	./config.status