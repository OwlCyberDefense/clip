# Copyright (C) 2012 Tresys Technology, LLC
# Copyright (C) 2013 Cubic Corporation
#
# Authors: Spencer Shimko <sshimko@tresys.com>
#          Spencer Shimko <spencer@quarksecurity.com>
#

# The name of the package
PKGNAME := livecd-tools

# This is the version number of the RPM that will be
# generated.  Typically you bump this for delivery.
VERSION := 13.4.4

# Bump this if creating multiple releases from the same
# version.
RELEASE := 99.el6

# The name of the Vendor
VENDOR := null

# The name of the Packager
PACKAGER ?= null

# Snag the architecture.  Assume host arch.
# Hard code an arch if cross-compiling or going noarch.
ARCH := noarch

SOURCES := $(PKGNAME)-$(VERSION).tar.bz2 *.patch

# Spec file name
RPM_SPEC := $(PKGNAME).spec

####################################################
## things below this line should rarely change
ROOT_DIR ?= $(CURDIR)
OUTPUT_DIR ?= $(ROOT_DIR)
SRPM_OUTPUT_DIR ?= $(OUTPUT_DIR)

# exhaustive list of deps for the RPM, used to determine if RPM needs to be rebuilt
RPM_DEPS := $(SOURCES) $(RPM_SPEC) Makefile

RPM_TMPDIR ?= $(ROOT_DIR)/tmp
RPM_TOPDIR ?= $(RPM_TMPDIR)/src/redhat
RPM_BUILDROOT ?= $(RPM_TMPDIR)/rpm-buildroot

RPMQ_DEFS := --query --define 'pkgname $(PKGNAME)' --define '_sysconfdir /etc' --define 'version $(VERSION)' --define 'release $(RELEASE)' --define 'vendor $(VENDOR)' --define 'packager $(PACKAGER)' --qf '%{NAME}\n'

MKDIR = test -d $(1) || mkdir -p $(1)

RPMBUILD_ARGS := --define '_topdir $(RPM_TOPDIR)'  --define '_tmppath $(RPM_TMPDIR)'

define rpm-prep
	$(call MKDIR,$(RPM_TOPDIR)/SOURCES)
	$(call MKDIR,$(RPM_TOPDIR)/SPECS)
	$(call MKDIR,$(RPM_TOPDIR)/BUILD)
	$(call MKDIR,$(RPM_TOPDIR)/RPMS/$(ARCH))
	$(call MKDIR,$(RPM_TOPDIR)/SRPMS)
endef

all: $(PKGNAME)-rpm $(PKGNAME)-srpm

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
	cp $(SOURCES) $(RPM_TOPDIR)/SOURCES/
	echo -e "%define pkgname $(PKGNAME)\n%define _sysconfdir /etc\n%define version $(VERSION)\n%define release $(RELEASE)\n%define vendor $(VENDOR)\n%define packager $(PACKAGER)\nBuildArch: $(ARCH)\n" > $(RPM_TOPDIR)/SPECS/$(notdir $(RPM_SPEC))
	cat $(RPM_SPEC) >> $(RPM_TOPDIR)/SPECS/$(notdir $(RPM_SPEC))
	cd $(RPM_TOPDIR) && rpmbuild $(RPMBUILD_ARGS) -bs SPECS/$(notdir $(RPM_SPEC)) --nodeps
	mv  $(RPM_TOPDIR)/SRPMS/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm $(SRPM_OUTPUT_DIR)

patchy: $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm
	@echo "Prepping environment for patching existing sources..."
	@# rpmbuild can't do a -bp on a srpm so we will need to install it into our tmp/
	$(VERBOSE)mv $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm $(RPM_TOPDIR)/SRPMS
	$(VERBOSE)cd $(RPM_TOPDIR)/SRPMS && rpm $(RPMBUILD_ARGS) -ivh $(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm
	@# %patch lines w/ a -b create backup files that screw up diffs between a and b.  There doesn't appear to be an rpmbuild args to avoid it.
	$(VERBOSE)sed -i -e 's/^\(%patch.*\) -b [^s\.]\(.*\)/\1 \2/' $(RPM_TOPDIR)/SPECS/$(RPM_SPEC)
	@# rpmbuild build prep this thing
	$(VERBOSE)cd $(RPM_TOPDIR)/SPECS && rpmbuild $(RPMBUILD_ARGS) --buildroot $(RPM_BUILDROOT) -bp $(RPM_SPEC)
	$(VERBOSE)cp -r $(RPM_TOPDIR)/BUILD/$(PKGNAME)-$(VERSION) $(CURDIR)/a
	$(VERBOSE)cp -r $(CURDIR)/a $(CURDIR)/b
	@echo -e "\n\nAll done!  Your two patch trees are a/ and b/"
	@echo -e "When you're finished, 'diff -purN a b > [meaningful_name].patch'.\nThen add it to $(RPM_SPEC)."

clean:
	$(RM) -r $(RPM_TMPDIR)

bare: clean
	$(foreach f,$(shell rpm $(RPMQ_DEFS) --specfile $(RPM_SPEC)),$(RM) $(OUTPUT_DIR)/$(f)*.rpm;)
	$(RM) $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm
	$(RM) -r a b

.PHONY: all rpm srpm $(PKGNAME)-rpm $(PKGNAME)-srpm clean bare
