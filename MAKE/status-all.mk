#status-all.mk
#	Created on: Jan 11, 2020
#		Author: badquanta
status-all-suffixes:
	@echo All Suffixes: $(ALL_SUFFIXES)
status-all-includes:
	$(STATUS) "$(ALL_INCLUDES)" "All Includes: "
status-all-defaults:
	@echo ALL Defaults: $(ALL_DEFAULTS)
status-all-phony:
	@echo ALL Phony: $(ALL_PHONY)
	
status-all-dep-files:
	@echo ALL Dep Files: $(ALL_DEP_FILES)
status-all-objs:
	$(STATUS) "$(ALL_OBJS)" All Objects
status-all-clean:
	@echo All clean: $(ALL_CLEAN)
	
status-config:
	@echo Brand: $(BRAND)
	@echo Arch: $(ARCH)
	@echo Jobs: $(JOBS)
	$(STATUS) "$(BINDIR)" "bin"
	$(STATUS) "$(DATADIR)" "data"
	$(STATUS) "$(DATAROOTDIR)" "data root"
	$(STATUS) "$(DOCDIR)" "doc"
	$(STATUS) "$(EXECPREFIX)" "exec prefix"
	$(STATUS) "$(INFODIR)" "info"
	$(STATUS) "$(LIBEXECDIR)" "lib exec"
	$(STATUS) "$(LOCALSTATEDIR)" "local state"
	$(STATUS) "$(OLDINCLUDEDIR)" "old include"
	$(STATUS) "$(PREFIX)" "prefix"
	$(STATUS) "$(RUNSTATEDIR)" "run state"
	$(STATUS) "$(SBINDIR)" "sbin"
	$(STATUS) "$(SYSCONFDIR)" "sysconf"
	$(STATUS) "$(SYSROOT)" "sysroot"