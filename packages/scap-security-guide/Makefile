# Copyright (C) 2012 Tresys Technology, LLC
#
# Authors: Spencer Shimko <sshimko@tresys.com>
#

# The name of the package
PKGNAME := scap-security-guide

# This is the version number of the RPM that will be
# generated.  Typically you bump this for delivery.
VERSION := 1.0

# Bump this if creating multiple releases from the same
# version.
RELEASE := git.4d28ff3

# The name of the Vendor
VENDOR := SCAP Security Guide

# The name of the Packager
PACKAGER ?= Tresys Technology, LLC

# Snag the architecture.  Assume host arch.
# Hard code an arch if cross-compiling or going noarch.
ARCH := noarch

# This file will be created by tar'ing up $(PKGNAME)/
TARBALL = $(SRPM_OUTPUT_DIR)/scap-security-guide-$(VERSION).tar.gz
PATCHES = ssg-fix-fixes-tags.patch replace-pam-cracklib-with-pam-passwdqc.patch ldap-dependency-checking.patch postfix-package-dependency-checking.patch httpd-dependency-checking.patch sysctl-module-dependency-checking.patch add-dcid-profile.patch add-manual-profile.patch

# All sources for the package.

# Spec file name
RPM_SPEC := $(PKGNAME).spec

####################################################
## things below this line should rarely change
ROOT_DIR ?= $(CURDIR)
OUTPUT_DIR ?= $(ROOT_DIR)
SRPM_OUTPUT_DIR ?= $(OUTPUT_DIR)

# exhaustive list of deps for the RPM, used to determine if RPM needs to be rebuilt
TAR_DEPS := $(wildcard $(PKGNAME)/*)
RPM_DEPS := $(TARBALL) $(RPM_SPEC) Makefile $(PATCHES)

RPM_TMPDIR ?= $(ROOT_DIR)/tmp
RPM_TOPDIR ?= $(RPM_TMPDIR)/src/redhat
RPM_BUILDROOT ?= $(RPM_TMPDIR)/rpm-buildroot

MKDIR = test -d $(1) || mkdir -p $(1)

RPMBUILD_ARGS := --define '_topdir $(RPM_TOPDIR)'  --define '_tmppath $(RPM_TMPDIR)'

RPMQ_DEFS := --query --define 'pkgname $(PKGNAME)' --define '_sysconfdir /etc' --define 'version $(VERSION)' --define 'release $(RELEASE)' --define 'vendor $(VENDOR)' --define 'packager $(PACKAGER)' --qf '%{NAME}\n'

define rpm-prep
	$(call MKDIR,$(RPM_TOPDIR)/SOURCES)
	$(call MKDIR,$(RPM_TOPDIR)/SPECS)
	$(call MKDIR,$(RPM_TOPDIR)/BUILD)
	$(call MKDIR,$(RPM_TOPDIR)/RPMS/$(ARCH))
	$(call MKDIR,$(RPM_TOPDIR)/SRPMS)
endef

all: $(PKGNAME)-rpm $(PKGNAME)-srpm

$(TARBALL): $(TAR_DEPS)
	tar -czf $@ $(PKGNAME)

rpm: $(PKGNAME)-rpm

srpm: $(PKGNAME)-srpm

$(PKGNAME)-rpm: $(OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm

$(PKGNAME)-srpm: $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm

$(OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm: $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm
	@echo "Building $(PKGNAME) RPM..."
	$(call rpm-prep)
	cd $(RPM_TOPDIR)/SRPMS && rpmbuild --rebuild --target=$(ARCH) $(RPMBUILD_ARGS) --buildroot $(RPM_BUILDROOT) -bb $<
	mv  $(RPM_TOPDIR)/RPMS/$(ARCH)/$(PKGNAME)-$(VERSION)-$(RELEASE)*.rpm $(OUTPUT_DIR)

$(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm: $(RPM_DEPS)
	@echo "Building $(PKGNAME) SRPM..."
	$(call rpm-prep)
	cp $(TARBALL) $(RPM_TOPDIR)/SOURCES/
	cp $(PATCHES) $(RPM_TOPDIR)/SOURCES/
	echo -e "%define pkgname $(PKGNAME)\n%define _sysconfdir /etc\n%define version $(VERSION)\n%define release $(RELEASE)\n%define vendor $(VENDOR)\n%define packager $(PACKAGER)" > $(RPM_TOPDIR)/SPECS/$(notdir $(RPM_SPEC))
	cat $(RPM_SPEC) >> $(RPM_TOPDIR)/SPECS/$(notdir $(RPM_SPEC))
	cd $(RPM_TOPDIR) && rpmbuild $(RPMBUILD_ARGS) -bs SPECS/$(notdir $(RPM_SPEC)) --nodeps
	mv  $(RPM_TOPDIR)/SRPMS/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm $(SRPM_OUTPUT_DIR)

clean:
	$(RM) -r $(RPM_TMPDIR)

bare: clean
	$(foreach f,$(shell rpm $(RPMQ_DEFS) --specfile $(RPM_SPEC)),$(RM) $(OUTPUT_DIR)/$(f)*.rpm;)
	$(RM) $(TARBALL) $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm

.PHONY: all rpm srpm $(PKGNAME)-rpm $(PKGNAME)-srpm clean bare
