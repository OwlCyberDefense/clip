# Copyright (C) 2011-2012 Tresys Technology, LLC
# Copyright (C) 2013 Cubic Corporation
#
# Authors: Spencer Shimko <sshimko@tresys.com>
#          Spencer Shimko <spencer@quarksecurity.com>
#          John Feehley <jfeehley@quarksecurity.com>

# The name of the package
PKGNAME := webpageexample

# This is the version number of the RPM that will be
# generated.  Typically you bump this for delivery.
VERSION := 1

# bump this if creating multiple releases from the same
# version (think about this... why are you doing this?)
RELEASE := 1

# The name of the Vendor
VENDOR := Quark Security Inc

# The name of the Packager
PACKAGER ?= Quark Security Inc

# snag the architecture, hard code an arch if cross-compiling or going noarch
ARCH ?= noarch

# the filename of the tarball
TARBALL = $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION).tgz

# spec file name
RPM_SPEC = $(CURDIR)/$(PKGNAME).spec

####################################################
## things below this line should rarely change
ROOT_DIR ?= $(CURDIR)
OUTPUT_DIR ?= $(ROOT_DIR)
SRPM_OUTPUT_DIR ?= $(OUTPUT_DIR)

# exhaustive list of deps for the RPM, used to determine if RPM needs to be rebuilt
TAR_DEPS := $(wildcard $(PKGNAME)/*)
RPM_DEPS := $(TARBALL) $(RPM_SPEC) $(CURDIR)/Makefile

RPM_TMPDIR ?= $(ROOT_DIR)/tmp
RPM_TOPDIR ?= $(RPM_TMPDIR)/src/redhat
RPM_BUILDROOT ?= $(RPM_TMPDIR)/rpm-buildroot

MKDIR = test -d $(1) || mkdir -p $(1)

RPMBUILD_ARGS := --define '_topdir $(RPM_TOPDIR)'  --define '_tmppath $(RPM_TMPDIR)' --buildroot $(RPM_BUILDROOT)

define rpm-prep
	$(call MKDIR,$(RPM_TOPDIR)/SOURCES)
	$(call MKDIR,$(RPM_TOPDIR)/SPECS)
	$(call MKDIR,$(RPM_TOPDIR)/BUILD)
	$(call MKDIR,$(RPM_TOPDIR)/RPMS/$(ARCH))
	$(call MKDIR,$(RPM_TOPDIR)/SRPMS)
	cp $(TARBALL) $(RPM_TOPDIR)/SOURCES/
endef

all: $(PKGNAME)-rpm $(PKGNAME)-srpm

tarball: $(TARBALL)

rpm: $(PKGNAME)-rpm

srpm: $(PKGNAME)-srpm

$(PKGNAME)-rpm: $(OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm

$(PKGNAME)-srpm: $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm

# Note: if you're carrying a tarball already (e.g., you are using an officially released tarball), just copy it from here to $(TARBALL)
#      	Something like this should work: "cp $@ $(RPM_TOPDIR)/SOURCES/"
$(TARBALL): $(TAR_DEPS)
	@echo "Building $(PKGNAME) source tarball..."
	tar -czf $@ $(PKGNAME)/

$(OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm: $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm
	@echo "Building $(PKGNAME) RPM..."
	$(call rpm-prep)
	cd $(RPM_TOPDIR)/SRPMS && rpmbuild --rebuild $(RPMBUILD_ARGS) -bb $<
	mv  $(RPM_TOPDIR)/RPMS/$(ARCH)/$(PKGNAME)-$(VERSION)-$(RELEASE)*.rpm $(OUTPUT_DIR)

$(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm: $(RPM_DEPS)
	@echo "Building $(PKGNAME) SRPM..."
	$(call rpm-prep)
	echo -e "%define pkgname $(PKGNAME)\n%define _sysconfdir /etc\n%define version $(VERSION)\n%define release $(RELEASE)\n%define vendor $(VENDOR)\n%define packager $(PACKAGER)\nBuildArch: $(ARCH)\n"> $(RPM_TOPDIR)/SPECS/$(notdir $(RPM_SPEC))
	cat $(RPM_SPEC) >> $(RPM_TOPDIR)/SPECS/$(notdir $(RPM_SPEC))
	cd $(RPM_TOPDIR) && rpmbuild $(RPMBUILD_ARGS) -bs SPECS/$(notdir $(RPM_SPEC)) --nodeps
	mv  $(RPM_TOPDIR)/SRPMS/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm $(SRPM_OUTPUT_DIR)

clean:
	$(RM) -r $(RPM_TMPDIR)

bare: clean
	$(RM) $(OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm $(OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm
	$(RM) $(TARBALL)

.PHONY: all rpm srpm tarball $(PKGNAME)-rpm $(PKGNAME)-srpm clean bare
