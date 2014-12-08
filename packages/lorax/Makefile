# Copyright (C) 2011 Tresys Technology, LLC
# Copyright (C) 2014 QuarkSecurity, Inc
#
# Authors: Spencer Shimko <sshimko@tresys.com>
# Authors: Spencer Shimko <spencer@quarksecurity.com>
#

# The name of the package
PKGNAME := lorax

# This is the version number of the RPM that will be
# generated.  Typically you bump this for delivery.
VERSION := 19.6.45

# bump this if creating multiple releases from the same
# version (think about this... why are you doing this?)
RELEASE := 4.el7

PKG := $(PKGNAME)-$(VERSION)

# snag the architecture, hard code an arch if cross-compiling or going noarch
ARCH := x86_64
TARBALL = $(RPM_TOPDIR)/SOURCES/$(PKG).tar.gz

RPM_DEPS := tarball $(RPM_SPEC) Makefile

PACKAGER := Tresys Technology

####################################################
## things below this line should rarely change
ROOT_DIR ?= $(CURDIR)
OUTPUT_DIR ?= $(ROOT_DIR)
RPM_TMPDIR ?= $(ROOT_DIR)/tmp
RPM_TOPDIR ?= $(RPM_TMPDIR)/src/redhat
RPM_BUILDROOT ?= $(RPM_TMPDIR)/rpm-buildroot
SRPM_OUTPUT_DIR ?= $(ROOT_DIR)

RPM := $(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm
SRPM := $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm

RPM_SPEC := $(CURDIR)/$(PKGNAME).spec

MKDIR = test -d $(1) || mkdir -p $(1)

RPMBUILD_ARGS := --define '_topdir $(RPM_TOPDIR)'  \
	--define '_tmppath $(RPM_TMPDIR)' \
	--define 'pkgname $(PKGNAME)' \
	--define '_sysconfdir /etc' \
	--define 'version $(VERSION)' \
	--define 'release $(RELEASE)' \
	--define 'packager $(PACKAGER)\n'

define rpm-prep
	$(call MKDIR,$(RPM_TOPDIR)/SOURCES);\
$(call MKDIR,$(RPM_TOPDIR)/SPECS);\
$(call MKDIR,$(RPM_TOPDIR)/BUILD);\
$(call MKDIR,$(RPM_TOPDIR)/RPMS/$(ARCH));\
$(call MKDIR,$(RPM_TOPDIR)/SRPMS);
endef

all: tarball srpm rpm

rpm: srpm $(PKGNAME)-rpm

tarball: $(PKGNAME)-tarball
	$(call rpm-prep)

	# create source tar and copy into the SOURCES dir
	tar -czf $(PKG).tar.gz $(PKG)
	mv $(PKG).tar.gz $(TARBALL)

srpm: $(PKGNAME)-srpm tarball
	@echo "Copying the SPEC file to proper location..."
	cat $(RPM_SPEC) > $(RPM_TOPDIR)/SPECS/$(notdir $(RPM_SPEC))
	@echo "Building $(PKGNAME) SRPM..."
	cd $(RPM_TOPDIR) && rpmbuild $(RPMBUILD_ARGS) --target=$(ARCH) -bs SPECS/$(notdir $(RPM_SPEC)) --nodeps
	cp $(RPM_TOPDIR)/SRPMS/* $(SRPM_OUTPUT_DIR)

$(PKGNAME)-rpm: $(OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm

$(PKGNAME)-srpm: srpm

$(OUTPUT_DIR)/$(RPM): $(SRPM)
	@echo "Building $(PKGNAME) RPM..."
	$(call rpm-prep)
	cd $(RPM_TOPDIR)/SRPMS && rpmbuild --rebuild $(RPMBUILD_ARGS) --buildroot $(RPM_BUILDROOT) -bb $<
	mv  $(RPM_TOPDIR)/RPMS/$(ARCH)/$(PKGNAME)-$(VERSION)-$(RELEASE)*.rpm $(OUTPUT_DIR)

$(SRPM): $(SRC_SRPM)
	if [ ! "$(SRPM_OUTPUT_DIR)" -ef "$(RPM_TOPDIR)/SRPMS" ]; then\
		$(call rpm-prep)\
	fi

$(RPM_SPEC): $(SRC_SRPM)
	$(call MKDIR,$(RPM_TMPDIR))
	( cd $(RPM_TMPDIR); rpm2cpio $< | cpio --quiet -i ${PKGNAME}.spec ) 2>&1 >/dev/null

clean:
	$(RM) -r $(RPM_TMPDIR)

# This is slightly undesirable, but in order to cleanup *all& RONs peroperly we need
# to query the spec file, so in the bare target we have to extract the spec file :(
bare: $(RPM_SPEC) FORCE
	$(RM) -r $(RPM_TMPDIR)
	$(RM) -f $(RPM) $(SRPM)

FORCE:

.PHONY: all $(PKGNAME)-rpm $(PKGNAME)-srpm $(PKGNAME)-tarball clean bare rpm srpm FORCE
