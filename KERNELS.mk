include COMMON.mk
KERNEL_CFLAGS :=	$(PROJECT_CFLAGS) \
					-fno-leading-underscore \
					-fcheck-new \
					-fno-use-cxa-atexit \
					-nostdlib \
					-fno-rtti \
					-fno-exceptions

# TARGET FILES
