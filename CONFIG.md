# Explaining/documenting Config.mk

This makefile include sets all the variables used by the makefile rules.  The intent is to give a one-stop shop for tweaking the build system; it may be broken up into sub-includes soon.

##### PROJECT_NAME

Self explanitory setting(s).

## XARCH

A pretty important variable; defines the target environment for both BQos & the GCC/Binutils cross build utils.

#### XJOBS

This controls how many async jobs each sub-make step is allowed to do... though it is assumed this makefile will not be run asyncronously; and it's dependencies are pretty linear. 

## *_GIT_*

- BINUTILS_GIT
- BINUTILS_GIT_BRANCH
- GCC_GIT
- GCC_GIT_BRANCH


simply defines where to get the source for GNU's binutils & gcc.  I've started a fork of each with a BQos target and that's what it is set to fetch.

##### XALL_SUFFIXES

A collection that'll gather the suffixes this makefile will handle.
This will be used to define `.SUFFIXES: $(XALL_SUFFIXES)` in the makefile.

## PROJECT_SRC_DIR

Set to the same directory this `Makefile` is found within; AKA: `./` from within this repository.

## TARGETS
