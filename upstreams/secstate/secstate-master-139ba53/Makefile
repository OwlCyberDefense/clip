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
SECSTATE_PUPPETDIR := $(DATADIR)/secstate/puppet
BENCHDIR := $(SECSTATE_DATADIR)/benchmarks
BENCHCONFDIR := $(SECSTATE_DATADIR)/configs
OVALDIR := $(SECSTATE_DATADIR)/oval
BINDIR := $(DESTDIR)/usr/bin
MANDIR := $(DESTDIR)/usr/share/man
LIBEXECDIR := $(DESTDIR)/usr/libexec
PYTHON_LIB := $(DESTDIR)$(PY_LIB)
PYTHON_LIB_SECSTATE := $(PYTHON_LIB)/$(PKG)
PUPPET_MODULEDIR := $(DESTDIR)/usr/share/puppet/modules
TRANSFORMDIR := $(SHAREDIR)/$(PKG)/transforms
RPM_BUILD = rpmbuild --define '_topdir $(RPM_TOPDIR)' \
			--define '_tmppath $(RPM_TMPDIR)' \
			--define '_sysconfdir $(SYSCONFDIR)' \
			--define '_build_dir $(RPM_INSTALLROOT)' \
			--define '_packager $(RPM_PACKAGER)' \
			--define '_version $(VERSION)' \

TEST_DIR := testing/tests
TESTS = import_xccdf_tgz \
import_xccdf_tar \
import_xccdf_bz2 \
import_xccdf_benchmark \
import_oval_definition \
import_passreqs \
profile_selections \
show_xccdf_benchmark_bad_parameters \
show_xccdf_benchmark \
list_xccdf_recursive_bad_parameters \
list_xccdf \
list_xccdf_recursive \
list_multiple_xccdf \
list_multiple_xccdf_recursive \
deselect_passreqs_recursive \
deselect_benchmark_bad_parameters \
deselect_benchmark \
deselect_benchmark_recursive \
deselect_group \
deselect_group_recursive \
deselect_rule \
select_benchmark_recursive_bad_parameters \
select_benchmark \
select_benchmark_recursive \
select_group \
select_group_recursive \
select_rule \
audit_passreqs_all_fail \
audit_passreqs_all_fail_bad_parameters \
audit_all_deselected_benchmark \
audit_all_recursively_deselected_benchmark \
audit_all_deselected_group \
audit_all_recursively_deselected_group \
audit_selected_rule \
audit_deselected_benchmark \
audit_deselected_group \
audit_recursively_deselected_benchmark \
audit_recursively_deselected_group \
search_xccdf_benchmark \
search_reverse_oval \
remediate_etc_passwd \
remediate_etc_passwd_bad_parameters \
remediate_root_uid \
remediate_shells_exist \
remediate_home_dirs \
remediate_no_suid \
remediate_password_complexity \
remediate_clip_sample_all_selected \
remediate_clip_sample_benchmark_deselected \
remediate_clip_sample_group_deselected \
remediate_clip_sample_rule_deselected \
manpage_installed

TEST_PATHS := $(foreach TEST,$(TESTS),$(TEST_DIR)/$(TEST)) 
MODE_DIR = -m 755
MODE_EXEC = -m 755
MODE_REG = -m 644

override BIN_OR_ALL = b
ifeq ($(BUILDSRC),y)
	override BIN_OR_ALL = a
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
	$(verbose)test -d $(MANDIR)/man1 || $(INSTALL) $(MODE_DIR) -d $(MANDIR)/man1
	$(verbose)test -d $(PYTHON_LIB) || $(INSTALL) $(MODE_DIR) -d $(PYTHON_LIB)
	$(verbose)test -d $(PYTHON_LIB_SECSTATE) || $(INSTALL) $(MODE_DIR) -d $(PYTHON_LIB_SECSTATE)
	$(verbose)test -d $(TRANSFORMDIR) || $(INSTALL) $(MODE_DIR) -d $(TRANSFORMDIR)
	$(verbose)test -d $(SECSTATE_PUPPETDIR) || $(INSTALL) $(MODE_DIR) -d $(SECSTATE_PUPPETDIR)
	$(verbose)$(GZIP) -c docs/secstate.1 > docs/secstate.1.gz
	$(verbose)$(INSTALL) $(MODE_REG) docs/secstate.1.gz $(MANDIR)/man1/secstate.1.gz
	$(verbose)$(INSTALL) $(MODE_EXEC) src/bin/$(PKG) $(BINDIR)/$(PKG)
	$(verbose)$(INSTALL) $(MODE_EXEC) src/bin/secstate_external_node $(LIBEXECDIR)/$(PKG)/secstate_external_node
	$(verbose)$(INSTALL) $(MODE_REG) src/secstate/*.py $(PYTHON_LIB_SECSTATE)
	$(verbose)$(INSTALL) $(MODE_REG) src/etc/$(PKG).conf $(SYSCONFDIR)/$(PKG)/$(PKG).conf
	$(verbose)test -d $(SECSTATE_DATADIR) || $(INSTALL) $(MODE_DIR) -d $(SECSTATE_DATADIR)
	$(verbose)test -d $(BENCHDIR) || $(INSTALL) $(MODE_DIR) -d $(BENCHDIR)
	$(verbose)test -d $(BENCHCONFDIR) || $(INSTALL) $(MODE_DIR) -d $(BENCHCONFDIR)
	$(verbose)test -d $(OVALDIR) || $(INSTALL) $(MODE_DIR) -d $(OVALDIR)
	$(verbose)test -d $(PUPPET_MODULEDIR) || $(INSTALL) $(MODE_DIR) -d $(PUPPET_MODULEDIR)
	$(foreach module, $(MODULE_LIST), $(verbose)cp -r remediation/puppet-modules/${module} $(PUPPET_MODULEDIR);)
	$(verbose)cp -a src/share/transforms/* $(TRANSFORMDIR)
	$(verbose)cp -a src/puppet/* $(SECSTATE_PUPPETDIR)

uninstall:
	rm -rf $(SYSCONFDIR)/$(PKG)
	rm -rf $(SHAREDIR)/$(PKG)
	rm -f $(BINDIR)/$(PKG)
	rm -rf $(SECSTATE_DATADIR)
	rm -f $(PYTHON_LIB)/secstate_package.py*
	rm -f $(MANDIR)/man1/secstate.1.gz

runtests:
	testing/harness/run_tests.py --chroot testing/chroot $(TEST_PATHS)

rpm: $(PKG)-rpm

$(PKG)-rpm:
	$(call rpm-prep)
	$(verbose)cp $(ROOT_DIR)/$(DIST)/$(SPEC) $(RPM_SPECDIR)
	$(verbose)$(TAR) -czf $(RPM_TOPDIR)/SOURCES/$(SOURCE) --exclude tmp --exclude .git --exclude '*.rpm' ./
	$(verbose)$(RPM_BUILD) -b$(BIN_OR_ALL) $(RPM_SPECDIR)/$(SPEC)
	$(verbose)cp $(RPM_TOPDIR)/RPMS/noarch/$(PKG)-$(VERSION)-$(RELEASE)*.noarch.rpm $(OUTPUT_DIR)
ifeq ($(BIN_OR_ALL),a)
	$(verbose)cp  $(RPM_TOPDIR)/SRPMS/$(PKG)-$(VERSION)-$(RELEASE)*.src.rpm $(OUTPUT_DIR)
endif

help:
	@echo "============================================================="
	@echo "+ \`make rpm' - Make the SecState RPM"
	@echo "+ \`make install' - Install SecState onto the system"
	@echo "+ \`make unisntall' - Remove SecState from the system"
	@echo "+ \`make clean' - Clean the source directory of unneeded files"
	@echo "============================================================="

clean:
	$(verbose)if [ x"$(SUBDIRS)" != "x" ]; then for c in $(SUBDIRS); do $(MAKE) -C../$$c $@; done; fi;
	$(verbose)rm -rf $(RPM_TMPDIR)
	$(verbose)rm -f $(SOURCE)

bare: clean
	$(verbose)if [ x"$(SUBDIRS)" != "x" ]; then for c in $(SUBDIRS); do $(MAKE) -C../$$c/build $@; done; fi;

.PHONY: all all-rpms clean bare $(PKG)-rpm check runtests

## END TARGETS 
######################################################################

