# Copyright (C) 2010 Tresys Technology, LLC
#      This program is free software; you can redistribute it and/or
#      modify it under the terms of the GNU General Public License as
#      published by the Free Software Foundation, version 2.
#
# Authors: Spencer Shimko <sshimko@tresys.com>
# 	   Ed Sealing <esealing@tresys.com>
#	   Ryan Haggerty <rhaggerty@tresys.com>
#

######################################################################
# This block  includes the project specific build settings

VERSION := $(shell sed -n 's/VERSION='\''\(.*\)'\''/\1/p' src/bin/secstate)
export VERSION
RELEASE := 1
export RELEASE
PYTHON := /usr/bin/env python
PY_LIB := $(shell python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")
PY_VER := python$(shell python -c "import sys; print sys.version[:3]")

PKG = secstate
DIST := $(CWD)dist
SPEC := $(PKG).spec
SOURCE := $(PKG)-$(VERSION).tar.gz

CLIP_DIR := $(CWD)../

RPM_PACKAGER := Tresys Technology, LLC
QUIET ?= 0

MODULE_LIST = file_perms pam ifdefined

# Add additional subdirs for Make recursion here.
# The all, clean, and bare targets will be called on these directories
SUBDIRS := 

## END IPTABLES SPECIFICS
######################################################################

######################################################################
## START COMMON
# This block includes the common build system configuration - it should not change across projects
# DO NOT MODIFY ANYTHING BELOW THIS LINE

ARCH := $(shell uname -i)
CWD := $(shell pwd)
ROOT_DIR := $(CWD)
SOURCE_DIR := $(CLIP_DIR)/sources
OUTPUT_DIR ?= $(ROOT_DIR)
RPM_TMPDIR := $(ROOT_DIR)/tmp
RPM_INSTALLROOT := $(RPM_TMPDIR)/rpm-installroot
export RPM_TOPDIR ?= $(RPM_TMPDIR)/src/redhat
RPM_SPECDIR := $(RPM_TOPDIR)/SPECS
INSTALL := /usr/bin/install -c
GZIP := /usr/bin/gzip
TAR := /bin/tar
DESTDIR :=
SYSCONFDIR := $(DESTDIR)/etc
DATADIR := $(DESTDIR)/var/lib
SHAREDIR := $(DESTDIR)/usr/share
SECSTATE_DATADIR := $(DATADIR)/secstate
BENCHDIR := $(SECSTATE_DATADIR)/benchmarks
BENCHCONFDIR := $(SECSTATE_DATADIR)/configs
OVALDIR := $(SECSTATE_DATADIR)/oval
BINDIR := $(DESTDIR)/usr/sbin
MANDIR := $(DESTDIR)/usr/share/man
LIBEXECDIR := $(DESTDIR)/usr/libexec
PYTHON_LIB := $(DESTDIR)$(PY_LIB)
PYTHON_LIB_SECSTATE := $(PYTHON_LIB)/$(PKG)
TRANSFORMDIR := $(SHAREDIR)/$(PKG)/transforms
RPM_BUILD = rpmbuild --define '_topdir $(RPM_TOPDIR)' \
			--define '_tmppath $(RPM_TMPDIR)' \
			--define '_packager $(RPM_PACKAGER)' \

MODE_DIR = -m 755
MODE_EXEC = -m 755
MODE_REG = -m 644

override BIN_OR_ALL = a
ifeq ($(BUILDSRC),n)
	override BIN_OR_ALL = b
endif


# If QUIET is requested set the verbose flag to disable echoing of commands
ifneq ($(QUIET),)
ifneq ($(QUIET),0)
        export verbose := @
	export QUIET = y
endif
endif

# Create the necessary directory structure to build RPMs
# $(call rpm-prep)
define rpm-prep
	$(verbose)test -d $(RPM_INSTALLROOT) || mkdir -p $(RPM_INSTALLROOT)
	$(verbose)test -d $(RPM_TOPDIR)/SPECS/ || mkdir -p $(RPM_TOPDIR)/SPECS/
	$(verbose)test -d $(RPM_TOPDIR)/SOURCES/ || mkdir -p $(RPM_TOPDIR)/SOURCES/
	$(verbose)test -d $(RPM_TOPDIR)/BUILD || mkdir -p $(RPM_TOPDIR)/BUILD/
	$(verbose)test -d $(RPM_TOPDIR)/RPMS/noarch || mkdir -p $(RPM_TOPDIR)/RPMS/noarch
	$(verbose)test -d $(RPM_TOPDIR)/RPMS/$(ARCH) || mkdir -p $(RPM_TOPDIR)/RPMS/$(ARCH)
	$(verbose)test -d $(RPM_TOPDIR)/SRPMS || mkdir -p $(RPM_TOPDIR)/SRPMS
endef

## END COMMON
######################################################################

######################################################################
## START TARGETS 

build:
	@echo 'Nothing to do'

all-rpms: $(PKG)-rpm

install:
	$(verbose)test -d $(SYSCONFDIR)/$(PKG) || $(INSTALL) $(MODE_DIR) -d $(SYSCONFDIR)/$(PKG)
	$(verbose)test -d $(BINDIR) || $(INSTALL) $(MODE_DIR) -d $(BINDIR)
	$(verbose)test -d $(LIBEXECDIR)/$(PKG) || $(INSTALL) $(MODE_DIR) -d $(LIBEXECDIR)/$(PKG)
	$(verbose)test -d $(MANDIR)/man8 || $(INSTALL) $(MODE_DIR) -d $(MANDIR)/man8
	$(verbose)test -d $(MANDIR)/man5 || $(INSTALL) $(MODE_DIR) -d $(MANDIR)/man5
	$(verbose)test -d $(PYTHON_LIB) || $(INSTALL) $(MODE_DIR) -d $(PYTHON_LIB)
	$(verbose)test -d $(PYTHON_LIB_SECSTATE) || $(INSTALL) $(MODE_DIR) -d $(PYTHON_LIB_SECSTATE)
	$(verbose)test -d $(TRANSFORMDIR) || $(INSTALL) $(MODE_DIR) -d $(TRANSFORMDIR)
	$(verbose)$(GZIP) -c docs/secstate.8 > docs/secstate.8.gz
	$(verbose)$(GZIP) -c docs/secstate.conf.5 > docs/secstate.conf.5.gz
	$(verbose)$(INSTALL) $(MODE_REG) docs/secstate.8.gz $(MANDIR)/man8/secstate.8.gz
	$(verbose)$(INSTALL) $(MODE_REG) docs/secstate.conf.5.gz $(MANDIR)/man5/secstate.conf.5.gz
	$(verbose)$(INSTALL) $(MODE_EXEC) src/bin/$(PKG) $(BINDIR)/$(PKG)
	$(verbose)$(INSTALL) $(MODE_REG) src/secstate/*.py $(PYTHON_LIB_SECSTATE)
	$(verbose)$(INSTALL) $(MODE_REG) src/etc/$(PKG).conf $(SYSCONFDIR)/$(PKG)/$(PKG).conf
	$(verbose)test -d $(SECSTATE_DATADIR) || $(INSTALL) $(MODE_DIR) -d $(SECSTATE_DATADIR)
	$(verbose)test -d $(BENCHDIR) || $(INSTALL) $(MODE_DIR) -d $(BENCHDIR)
	$(verbose)test -d $(BENCHCONFDIR) || $(INSTALL) $(MODE_DIR) -d $(BENCHCONFDIR)
	$(verbose)test -d $(OVALDIR) || $(INSTALL) $(MODE_DIR) -d $(OVALDIR)
	$(verbose)cp -a src/share/transforms/* $(TRANSFORMDIR)

uninstall:
	rm -rf $(SYSCONFDIR)/$(PKG)
	rm -rf $(SHAREDIR)/$(PKG)
	rm -f $(BINDIR)/$(PKG)
	rm -rf $(SECSTATE_DATADIR)
	rm -f $(PYTHON_LIB)/secstate_package.py*
	rm -f $(MANDIR)/man8/secstate.8.gz
	rm -f $(MANDIR)/man5/secstate.conf.5.gz

runtests:
	cd testing; ./tests.py $(TESTS); 

fixtests:
	cd testing; ./tests.py --fix $(TESTS);

rpm: $(PKG)-rpm

$(PKG)-rpm:
	$(call rpm-prep)
	$(verbose)cp $(ROOT_DIR)/$(DIST)/$(SPEC) $(RPM_SPECDIR)
	$(verbose)sed -i "s/#VERSION_PLACEHOLDER/%define version $(VERSION)/" $(RPM_SPECDIR)/$(SPEC)
	$(verbose)$(TAR) -czf $(RPM_TOPDIR)/SOURCES/$(SOURCE) --exclude tmp --exclude .gitignore --exclude .git --exclude '*.rpm' ./
	$(verbose)$(RPM_BUILD) -b$(BIN_OR_ALL) $(RPM_SPECDIR)/$(SPEC)
	$(verbose)cp $(RPM_TOPDIR)/RPMS/noarch/$(PKG)-$(VERSION)-$(RELEASE)*.noarch.rpm $(OUTPUT_DIR)
	$(verbose)cp $(RPM_TOPDIR)/SOURCES/$(SOURCE) $(OUTPUT_DIR)
ifeq ($(BIN_OR_ALL),a)
	$(verbose)cp  $(RPM_TOPDIR)/SRPMS/$(PKG)-$(VERSION)-$(RELEASE)*.src.rpm $(OUTPUT_DIR)
endif

help:
	@echo "============================================================="
	@echo "+ \`make rpm' - Make the SecState RPM"
	@echo "+ \`make install' - Install SecState onto the system"
	@echo "+ \`make uninstall' - Remove SecState from the system"
	@echo "+ \`make clean' - Clean the source directory of unneeded files"
	@echo "============================================================="

clean:
	$(verbose)if [ x"$(SUBDIRS)" != "x" ]; then for c in $(SUBDIRS); do $(MAKE) -C../$$c $@; done; fi;
	$(verbose)rm -rf $(RPM_TMPDIR)
	$(verbose)rm -f $(SOURCE)
	$(verbose)rm -f docs/secstate.8.gz
	$(verbose)rm -f docs/secstate.conf.5.gz
	$(verbose)rm -f $(PKG)-$(VERSION)-$(RELEASE)*.noarch.rpm
	$(verbose)rm -f $(PKG)-$(VERSION)-$(RELEASE)*.src.rpm

bare: clean
	$(verbose)if [ x"$(SUBDIRS)" != "x" ]; then for c in $(SUBDIRS); do $(MAKE) -C../$$c/build $@; done; fi;

.PHONY: all all-rpms clean bare $(PKG)-rpm check runtests fixtests

## END TARGETS 
######################################################################

