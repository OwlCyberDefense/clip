# Copyright (C) 2011 Tresys Technology, LLC
# Copyright (C) 2014 QuarkSecurity, Inc
#
# Authors: Spencer Shimko <sshimko@tresys.com>
# Authors: Spencer Shimko <spencer@quarksecurity.com>
#

# The name of the package
PKGNAME := cacti

# This is the version number of the RPM that will be
# generated.  Typically you bump this for delivery.
VERSION := 0.8.8b

# bump this if creating multiple releases from the same
# version (think about this... why are you doing this?)
RELEASE := 1.el6

# snag the architecture, hard code an arch if cross-compiling or going noarch
ARCH ?= $(shell uname -i)


PACKAGER := Quark Security, Inc

# srpm file name
SRPM := cacti-0.8.8b-1.rf.src.rpm
RPM := $(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm

####################################################
## things below this line should rarely change
ROOT_DIR ?= $(CURDIR)
OUTPUT_DIR ?= $(ROOT_DIR)
SRPM_OUTPUT_DIR ?= $(OUTPUT_DIR)

# Exhaustive list of deps for the RPM, used to determine if RPM needs to be rebuilt
# The filter-out function is called to drop a circular dep when doing non-mock builds (ie SRPM_OUTPUT_DIR = CURDIR)
RPM_DEPS :=  $(strip $(filter-out $(SRPM_OUTPUT_DIR)/$(SRPM),$(shell /bin/readlink -f $(SRPM))))

RPM_TMPDIR ?= $(ROOT_DIR)/tmp
RPM_TOPDIR ?= $(RPM_TMPDIR)/src/redhat
RPM_BUILDROOT ?= $(RPM_TMPDIR)/rpm-buildroot

RPMQ_DEFS := --query --define 'pkgname $(PKGNAME)' --define '_sysconfdir /etc' --define 'version $(VERSION)' --define 'release $(RELEASE)' --define 'packager $(PACKAGER)' --qf '%{NAME}\n'

RPM_SPEC := $(RPM_TMPDIR)/$(PKGNAME).spec

MKDIR = test -d $(1) || mkdir -p $(1)

RPMBUILD_ARGS := --define '_topdir $(RPM_TOPDIR)'  --define '_tmppath $(RPM_TMPDIR)' --buildroot $(RPM_BUILDROOT)

define rpm-prep
	$(call MKDIR,$(RPM_TOPDIR)/SOURCES);\
$(call MKDIR,$(RPM_TOPDIR)/SPECS);\
$(call MKDIR,$(RPM_TOPDIR)/BUILD);\
$(call MKDIR,$(RPM_TOPDIR)/RPMS/$(ARCH));\
$(call MKDIR,$(RPM_TOPDIR)/SRPMS);
endef

all: $(PKGNAME)-rpm $(PKGNAME)-srpm

Makefile: Makefile.tmpl $(CURDIR)/$(SRPM)
	$(CURDIR)/gen-makefile-from-src-rpm.sh $(SRPM)
	@echo "$(CURDIR)/Makefile has been updated.  Please re-run 'make'" && exit 1

rpm: $(PKGNAME)-rpm

srpm: $(PKGNAME)-srpm

$(PKGNAME)-rpm: $(OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).$(ARCH).rpm

$(PKGNAME)-srpm: $(SRPM_OUTPUT_DIR)/$(SRPM)

$(OUTPUT_DIR)/$(RPM): $(SRPM_OUTPUT_DIR)/$(PKGNAME)-$(VERSION)-$(RELEASE).src.rpm
	@echo "Building $(PKGNAME) RPM..."
	$(call rpm-prep)
	cd $(RPM_TOPDIR)/SRPMS && rpmbuild --rebuild $(RPMBUILD_ARGS) -bb $<
	mv  $(RPM_TOPDIR)/RPMS/$(ARCH)/$(PKGNAME)-$(VERSION)-$(RELEASE)*.rpm $(OUTPUT_DIR)

$(SRPM_OUTPUT_DIR)/$(SRPM): $(filter-out $(CURDIR)/$(SRPM),$(RPM_DEPS))
	@if [ ! "$@" -ef "$(CURDIR)/$(SRPM)" ]; then\
		echo "Copying SRPM into place...";\
		$(call rpm-prep)\
		cp  $(CURDIR)/$(SRPM) $(SRPM_OUTPUT_DIR) 2>&1 1>/dev/null;\
	fi

$(RPM_SPEC): $(CURDIR)/$(SRPM)
	$(call MKDIR,$(RPM_TMPDIR))
	( cd $(RPM_TMPDIR); rpm2cpio $< | cpio --quiet -i ${PKGNAME}.spec ) 2>&1 >/dev/null

clean:
	$(RM) -r $(RPM_TMPDIR)

# This is slightly undesirable, but in order to cleanup *all& RONs peroperly we need
# to query the spec file, so in the bare target we have to extract the spec file :(
bare: $(RPM_SPEC) FORCE
	$(foreach f,$(shell rpm $(RPMQ_DEFS) --specfile $(RPM_SPEC)),export GLOBIGNORE='$(CURDIR)/$(SRPM)'; $(RM) $(OUTPUT_DIR)/$(f)*.rpm;)
	$(RM) -r $(RPM_TMPDIR)

FORCE:

.PHONY: all $(PKGNAME)-rpm $(PKGNAME)-srpm clean bare rpm srpm FORCE
