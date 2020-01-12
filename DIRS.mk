######################################################################
# DIRS.mk should define the directories CONFIG.mk doesn't explicitly.#
######################################################################
# Get the current CONFIG##############################################
include CONFIG.mk #and start adding to it...##########################
######################################################################
######################################################## DIRECTORIES #
# 	like where is the repository where are working from?
#REPO_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
VPATH	 := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
#	and within that; where are ALL the sources?
REPO_SRC := $(REPO_DIR)src
#	and where are ALL the include (AKA:header) files?
REPO_INC := $(REPO_DIR)include
# where progress is tracked
TARGETS := $(PREFIX)/targets
# TODO: Should this be elsewhere?
export PATH		:= $(BINDIR):$(PATH)

# Where do we put sources (mostly that we download)
XSRC_DIR		:= $(PREFIX)/$(ARCH)/src

XBUILD_DIR		:= $(PREFIX)/$(ARCH)/build

SYS_INC			:= $(SYSROOT)/usr/include
