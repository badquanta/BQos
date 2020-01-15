include MAKE/common.conf.mk
KERNEL_CFLAGS :=	$(CFLAGS) \
					-fno-leading-underscore \
					-fcheck-new \
					-fno-use-cxa-atexit \
					-nostdlib \
					-fno-rtti \
					-fno-exceptions

# TARGET FILES
