include MAKE/goals.mk
include $(ALL_DEP_FILES)
MAKE/*.conf.mk: MAKE/config.mk 
MAKE/BQos.conf.mk: MAKE/dirs.conf.mk MAKE/kernels.conf.mk
MAKE/BQos.mk: MAKE/BQos.conf.mk MAKE/all.conf.mk
MAKE/common.conf.mk: MAKE/dirs.conf.mk
MAKE/dirs.conf.mk: MAKE/config.mk
MAKE/dirs.mk: MAKE/dirs.conf.mk MAKE/all.conf.mk
MAKE/goals.mk: MAKE/all.conf.mk MAKE/dirs.mk MAKE/xbinutils.mk MAKE/xgcc.mk MAKE/libc.mk MAKE/libk.mk MAKE/libbq.mk MAKE/BQos.mk MAKE/status-all.mk
MAKE/kernels.conf.mk: MAKE/common.conf.mk
MAKE/libbq.conf.mk: MAKE/dirs.conf.mk MAKE/common.conf.mk MAKE/all.conf.mk MAKE/kernels.conf.mk
MAKE/libbq.mk: MAKE/libbq.conf.mk
MAKE/libk.conf.mk: MAKE/libc.conf.mk MAKE/kernels.conf.mk
MAKE/libk.mk: MAKE/libk.conf.mk
MAKE/libc.conf.mk: MAKE/all.conf.mk MAKE/dirs.conf.mk 
MAKE/libc.mk: MAKE/libc.conf.mk MAKE/xgcc.conf.mk
MAKE/xbinutils.conf.mk: MAKE/dirs.conf.mk MAKE/config.mk
MAKE/xbinutils.mk: MAKE/common.conf.mk MAKE/xbinutils.conf.mk
MAKE/xgcc.conf.mk: MAKE/dirs.conf.mk MAKE/config.mk
MAKE/xgcc.mk: MAKE/xgcc.conf.mk MAKE/libc.conf.mk

MAKE/config.mk: MAKE/config.in.mk config.status
	./config.status
Makefile: MAKE/goals.mk $(ALL_DEP_FILES)
