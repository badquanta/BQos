status-xbinutils:
	@echo BINUTILS_GIT $(BINUTILS_GIT)
	@echo BINUTILS_GIT_BRANCH $(BINUTILS_GIT_BRANCH)
	@echo XBINUTILS_BUILD_DIR $(XBINUTILS_BUILD_DIR)
	@echo XBINUTILS_SRC_DIR $(XBINUTILS_SRC_DIR)
	@echo XBINUTILS_MAKEFILE $(XBINUTILS_MAKEFILE)
	@echo XBINUTILS_CONFIGURE_PARAMS $(XBINUTILS_CONFIGURE_PARAMS)
	@echo XAR $(XAR)
	@echo XAS $(XAS)

status-xgcc:
	@echo GCC_GIT $(GCC_GIT)
	@echo GCC_BRANCH $(GCC_BRANCH)
	@echo XGCC_BUILD_DIR $(XGCC_BUILD_DIR)
	@echo XGCC_SRC_DIR $(XGCC_SRC_DIR)
	@echo XGCC_CONFIGURE_PARAMS $(XGCC_CONFIGURE_PARAMS)
	@echo XAS $(XAS)
	@echo XGPP $(XGPP)
	@echo XGCC $(XGCC)

	@echo XBINUTILS_BUILD_DIR $(XBINUTILS_BUILD_DIR)
	@echo XBINUTILS_SRC_DIR $(XBINUTILS_SRC_DIR)
	@echo XBINUTILS_MAKEFILE $(XBINUTILS_MAKEFILE)
	@echo XBINUTILS_CONFIGURE_PARAMS $(XBINUTILS_CONFIGURE_PARAMS)
	@echo XAR $(XAR)
	@echo XAS $(XAS)
status-libc:
	@./status.sh $(LIBC_DIR) LIBC_DIR
	@./status.sh $(LIBC_SRC_DIR) LIBC_SRC_DIR
	@./status.sh $(LIBC_BUILD_DIR) LIBK_BUILD_DIR
	@./status.sh $(LIBK_BUILD_DIR) LIBC_BUILD_DIR
	@./status.sh $(LIBC_INC_DIR) LIBC_INC_DIR
	@./status.sh $(LIBC_INC_DST_DIR) LIBC_INC_DST_DIR
	@./status.sh $(LIBC_DST) LIBC
	@./status.sh $(LIBK_DST) LIBK
status-libc-src-c:
	@echo =================== LIBC_C_SRCS start
	@./status.sh "$(LIBC_C_SRCS)" 
	@echo =================== LIBC_C_SRCS end
status-libc-src-s:
	@echo =================== LIBC_S_SRCS start
	@./status.sh "$(LIBC_S_SRCS)"
	@echo =================== LIBC_S_SRCS end
status-libc-src-h:
	@echo =================== LIBC_H_SRCS start
	@./status.sh "$(LIBC_H_SRCS)"
	@echo =================== LIBC_H_SRCS end
status-libc-src-all: status-libc-src-c status-libc-src-s status-libc-src-h
status-libc-objs:
	@echo =================== LIBC_OBJS start
	@./status.sh "$(LIBC_OBJS)"
	@echo =================== LIBC_OBJS end
status-libk-objs:
	@echo =================== LIBK_OBJS start
	@./status.sh "$(LIBK_OBJS)"
	@echo =================== LIBK_OBJS end
status-libc-dst-h:	
	@./status.sh "$(LIBC_H_DST)"

status-BQos:
	@echo BQos_CPP_SRC_DIR "$(BQos_CPP_SRC_DIR)" 
	@./status.sh "$(BQos_CPP_SRCS)" BQos_CPP_SRCS
	@./status.sh "$(BQos_OBJS)" BQos_OBJS

status-config:
	@echo XJOBS: $(XJOBS)
	@echo PATH: $$PATH
	@echo "PROJECT_NAME:" $(PROJECT_NAME)
	@echo PROJECT_SRC_DIR: $(PROJECT_SRC_DIR)
	@echo XPREFIX: $(XPREFIX)
	@echo SYSROOT: $(SYSROOT)
	@echo XPREFIX: $(XPREFIX)
	@echo XPATH_DIR: $(XPATH_DIR)
	@echo XGCC_SRC_DIR: $(XGCC_SRC_DIR)
	@echo XARCH: $(XARCH)
	@echo XAS: $(XAS)
	@echo XGCC: $(XGCC)
	@echo "XG++:" $(XGPP)
	@echo LIBC_DIR: $(LIBC_DIR)
	@#@echo LIBC_H_SRCS: $(LIBC_H_SRCS)
	@#@echo LIBC_H_DST: $(LIBC_H_DST)
status-env:
	@env

status: status-config
	
