# The collections with here we will use
include MAKE/all.conf.mk 
# but each (should) be added too by the following includes
include MAKE/dirs.mk
include MAKE/xbinutils.mk
include MAKE/xgcc.mk
include MAKE/libc.mk
include MAKE/libk.mk
include MAKE/libbq.mk
include MAKE/BQos.mk
include MAKE/status-all.mk

shell: 
	export PS1="make$$ " 
	bash
#####################################################################
#	Compile the entire program. This should be the default target. This target need not rebuild any documentation files; Info files should normally be included in the distribution, and DVI (and other documentation format) files should be made only when explicitly asked for.
#	By default, the Make rules should compile and link with ‘-g’, so that executable programs have debugging symbols. Otherwise, you are essentially helpless in the face of a crash, and it is often far from easy to reproduce with a fresh build.
#####################################################################
all: $(ALL_DEFAULTS)
	@echo Finished ALL
#####################################################################
#			GNU SAYS:Delete all files in the current directory that are normally created by building the program. Also delete files in other directories if they are created by this makefile. However, don’t delete the files that record the configuration. Also preserve files that could be made by building, but normally aren’t because the distribution comes with them. There is no need to delete parent directories that were created with ‘mkdir -p’, since they could have existed anyway.	Delete .dvi files here if they are not part of the distribution.
# But by this we just mean a "quick-clean" which for now is just the kernel(s) I think... but that'll cause the rebuild of subsequent thigns like ISOs & etc.
#####################################################################
clean: $(ALL_CLEAN)
clean-objs:
	$(CLEAN) $(ALL_OBJS)
#####################################################################
#	Like ‘clean’, but may refrain from deleting a few files that people normally don’t want to recompile. For example, the ‘mostlyclean’ target for GCC does not delete libgcc.a, because recompiling it is rarely necessary and takes a lot of time.
#####################################################################
mostlyclean: $(ALL_MOSTLYCLEAN)
#####################################################################
#	Delete almost everything that can be reconstructed with this Makefile. This typically includes everything deleted by distclean, plus more: C source files produced by Bison, tags tables, Info files, and so on.
#	The reason we say “almost everything” is that running the command ‘make maintainer-clean’ should not delete configure even if configure can be remade using a rule in the Makefile. More generally, ‘make maintainer-clean’ should not delete anything that needs to exist in order to run configure and then begin to build the program. Also, there is no need to delete parent directories that were created with ‘mkdir -p’, since they could have existed anyway. These are the only exceptions; maintainer-clean should delete everything else that can be rebuilt.
#	The ‘maintainer-clean’ target is intended to be used by a maintainer of the package, not by ordinary users. You may need special tools to reconstruct some of the files that ‘make maintainer-clean’ deletes. Since these files are normally included in the distribution, we don’t take care to make them easy to reconstruct. If you find you need to unpack the full distribution again, don’t blame us.
#	To help make users aware of this, the commands for the special maintainer-clean target should start with these two:
#		@echo 'This command is intended for maintainers to use; it'
#		@echo 'deletes files that may need special tools to rebuild.'
#####################################################################
maintainer-clean: $(ALL_MAINTAINER_CLEAN)
#####################################################################
#	Delete all files in the current directory (or created by this makefile) that are created by configuring or building the program. If you have unpacked the source and built the program without creating any other files, ‘make distclean’ should leave only the files that were in the distribution. However, there is no need to delete parent directories that were created with ‘mkdir -p’, since they could have existed anyway.
#####################################################################
distclean: $(ALL_DIST_CLEAN)
#####################################################################
# 
#####################################################################
realclean: $(ALL_REAL_CLEAN)
#####################################################################
#####################################################################
clobber: $(ALL_CLOBBER)
#####################################################################
#	Compile the program and copy the executables, libraries, and so on to the file names where they should reside for actual use. If there is a simple test to verify that a program is properly installed, this target should run that test.
#	Do not strip executables when installing them. This helps eventual debugging that may be needed later, and nowadays disk space is cheap and dynamic loaders typically ensure debug sections are not loaded during normal execution. Users that need stripped binaries may invoke the install-strip target to do that.
#	If possible, write the install target rule so that it does not modify anything in the directory where the program was built, provided ‘make all’ has just been done. This is convenient for building the program under one user name and installing it under another.
#	The commands should create all the directories in which files are to be installed, if they don’t already exist. This includes the directories specified as the values of the variables prefix and exec_prefix, as well as all subdirectories that are needed. One way to do this is by means of an installdirs target as described below.
#	Use ‘-’ before any command for installing a man page, so that make will ignore any errors. This is in case there are systems that don’t have the Unix man page documentation system installed.
#	The way to install Info files is to copy them into $(infodir) with $(INSTALL_DATA) (see Command Variables), and then run the install-info program if it is present. install-info is a program that edits the Info dir file to add or update the menu entry for the given Info file; it is part of the Texinfo package.
#####################################################################
install: $(ALL_INSTALL)
	@echo -n Todo: $@...
#####################################################################
#	These targets install documentation in formats other than Info; they’re intended to be called explicitly by the person installing the package, if that format is desired. GNU prefers Info files, so these must be installed by the install target.
#	When you have many documentation files to install, we recommend that you avoid collisions and clutter by arranging for these targets to install in subdirectories of the appropriate installation directory, such as htmldir. As one example, if your package has multiple manuals, and you wish to install HTML documentation with many files (such as the “split” mode output by makeinfo --html), you’ll certainly want to use subdirectories, or two nodes with the same name in different manuals will overwrite each other.
#	Please make these install-format targets invoke the commands for the format target, for example, by making format a dependency.		
#####################################################################
install-html install-dvi install-pdf install-ps:
	@echo -n TODO: $@...
#####################################################################
#	Delete all the installed files—the copies that the ‘install’ and ‘install-*’ targets create.
#	This rule should not modify the directories where compilation is done, only the directories where files are installed.
#	The uninstallation commands are divided into three categories, just like the installation commands. See Install Command Categories.
#####################################################################
uninstall:
	@echo -n Todo: $@...
#####################################################################
#	Like install, but strip the executable files while installing them. In simple cases, this target can use the install target in a simple way:
#	But if the package installs scripts as well as real executables, the install-strip target can’t just refer to the install target; it has to strip the executables but not the scripts.
#	install-strip should not strip the executables in the build directory which are being copied for installation. It should only strip the copies that are installed.
#	Normally we do not recommend stripping an executable unless you are sure the program has no bugs. However, it can be reasonable to install a stripped executable for actual execution while saving the unstripped executable elsewhere in case there is	a bug.
#####################################################################
install-strip:
	$(MAKE) INSTALL_PROGRAM='$(INSTALL_PROGRAM) -s' \
	
##########################################################################################################################################
installcheck:
	@echo -n Todo: $@...
#####################################################################
#	It’s useful to add a target named ‘installdirs’ to create the directories where files are installed, and their parent directories. There is a script called mkinstalldirs which is convenient for this; you can find it in the Gnulib package. You can use a rule like this:
#		# Make sure all installation directories (e.g. $(bindir))
# actually exist by making them if necessary.
#		installdirs: mkinstalldirs
#		        $(srcdir)/mkinstalldirs $(bindir) $(datadir) \
#		                                $(libdir) $(infodir) \
#		                                $(mandir)
#	or, if you wish to support DESTDIR (strongly encouraged),
#		# Make sure all installation directories (e.g. $(bindir))
#		# actually exist by making them if necessary.
#		installdirs: mkinstalldirs
#		        $(srcdir)/mkinstalldirs \
#		            $(DESTDIR)$(bindir) $(DESTDIR)$(datadir) \
#		            $(DESTDIR)$(libdir) $(DESTDIR)$(infodir) \
#		            $(DESTDIR)$(mandir)
#	This rule should not modify the directories where compilation is done. It should do nothing but create installation directories.
#####################################################################
installdirs:
	@echo -n Todo: $@...
#####################################################################
#####################################################################
print:
	@echo -n Todo: $@...
#####################################################################
#####################################################################
tar:
	@echo -n Todo: $@...
#####################################################################
#####################################################################
shar:
	@echo -n Todo: $@...

#####################################################################
#	Create a distribution tar file for this program. The tar file should be set up so that the file names in the tar file start with a subdirectory name which is the name of the package it is a distribution for. This name can include the version number.
#	For example, the distribution tar file of GCC version 1.40 unpacks into a subdirectory named gcc-1.40.
#	The easiest way to do this is to create a subdirectory appropriately named, use ln or cp to install the proper files in it, and then tar that subdirectory.
#	Compress the tar file with gzip. For example, the actual distribution file for GCC version 1.40 is called gcc-1.40.tar.gz. It is ok to support other free compression formats as well.
#	The dist target should explicitly depend on all non-source files that are in the distribution, to make sure they are up to date in the distribution. See Making Releases in GNU Coding Standards.
#####################################################################
dist:
	@echo -n Todo: $@...

#####################################################################
#	Update a tags table for this program.
#	TODO: I have no idea what TAGS are.
#####################################################################
TAGS:
	@echo -n Todo: $@...

#####################################################################
#	Perform self-tests (if any). The user must build the program before running the tests, but need not install the program; you should write the self-tests so that they work when the program is built but not installed.
#####################################################################
check:
	@echo -n Todo: $@...

#####################################################################
#####################################################################
test:
	@echo -n Todo: $@...
#####################################################################
#	Generate any Info files needed. The best way to write the rules is as follows:
#		
#		info: foo.info
#		
#		foo.info: foo.texi chap1.texi chap2.texi
#		        $(MAKEINFO) $(srcdir)/foo.texi
#	You must define the variable MAKEINFO in the Makefile. It should run the makeinfo program, which is part of the Texinfo distribution.
#	Normally a GNU distribution comes with Info files, and that means the Info files are present in the source directory. Therefore, the Make rule for an info file should update it in the source directory. When users build the package, ordinarily Make will not update the Info files because they will already be up to date.
#####################################################################
info:
	@echo TODO: $@
#####################################################################
#	Generate documentation files in the given format. These targets should always exist, but any or all can be a no-op if the given output format cannot be generated. These targets should not be dependencies of the all target; the user must manually invoke them.
#	
#	Here’s an example rule for generating DVI files from Texinfo:
#	
#		dvi: foo.dvi
#		
#		foo.dvi: foo.texi chap1.texi chap2.texi
#		        $(TEXI2DVI) $(srcdir)/foo.texi
#	You must define the variable TEXI2DVI in the Makefile. It should run the program texi2dvi, which is part of the Texinfo distribution. (texi2dvi uses TeX to do the real work of formatting. TeX is not distributed with Texinfo.) Alternatively, write only the dependencies, and allow GNU make to provide the command.
#		
#		Here’s another example, this one for generating HTML from Texinfo:
#		
#		html: foo.html
#		
#		foo.html: foo.texi chap1.texi chap2.texi
#		        $(TEXI2HTML) $(srcdir)/foo.texi
#	Again, you would define the variable TEXI2HTML in the Makefile; for example, it might run makeinfo --no-split --html (makeinfo is part of the Texinfo distribution).
#####################################################################
dvi html pdf ps:
	@echo TODO: $@