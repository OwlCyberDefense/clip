# Copyright (C) 2011-2012 Tresys Technology, LLC
#
# Authors: Spencer Shimko <sshimko@tresys.com>
#

######################################################
# BEGIN USER CONFIGURATION

# List of all RPM packages to build, must be in $(PKG_DIR).
# NOTE: The Makefile for each package must define VERSION, RELEASE, and ARCH.
PACKAGES := clip-puppet

# This list contains a list of system images we can generate out of kickstarts in kickstart/<sysname>/sysname.ks
SYSTEMS := clip-rhel5 clip-rhel6

# Import build configuration (production vs. debug, other configurables)
include BUILD_CONFIG

# Define version and release in the VERSION file
include VERSION

export BUILD_DATE ?= $(shell date +%m-%d-%y)

# These should be left alone, they only appear here for the simply expanded vars that follow
CONF_DIR := ./conf

# This variable can be leveraged by sub-makes (eg in the packages/foo/Makefile) if files at this top-level should trigger a rebuild
export ADDTL_DEPS := $(CURDIR)/VERSION

# TODO: All repo information should be extracted from the mock cfg/yum.conf
# A RHEL repo must be available. Can be a local path or an http/ftp location.
RHEL_REPO_DIR := /mnt/repos/rhel/rhel-5-6-i386/rhel-i386-server-5.6.z/getPackage
# Repo name.
RHEL_REPOID := rhel
# Where do we store a local, versioned list or packages from this repo.
RHEL_PKG_LIST_FILE := $(CONF_DIR)/pkglist.rhel

# A EPEL repo must be available. Can be a local path or an http/ftp location.
EPEL_REPO_DIR := /mnt/repos/other/EPEL-Pinned-Versions
# Repo name.
EPEL_REPOID := epel
# Where do we store a local, versioned list or packages from this repo.
EPEL_PKG_LIST_FILE := $(CONF_DIR)/pkglist.epel

# A groups repo must be available. Can be a local path or an http/ftp location.
BUILDGROUPS_REPO_DIR := /mnt/repos/buildgroups
# Repo name.
BUILDGROUPS_REPOID := groups
# Where do we store a local, versioned list or packages from this repo.
BUILDGROUPS_PKG_LIST_FILE := $(CONF_DIR)/pkglist.buildgroups

# MOCK_REL must be configured in MOCK_CONF_DIR/MOCK_REL.cfg
MOCK_REL := rhel-5-i386

# Set to "y" to disable the use of mock for building packages.
DISABLE_MOCK ?= n

# Enable signing of packages (must have RPM macros properly configured, see man page of RPM)
ENABLE_SIGNING ?= n

# Quiet down the build output a bit.
QUIET = n
# END USER CONFIGURATION
######################################################

######################################################
# A FOREWARNING - BEGIN MAGIC
$(info Boot strapping build system...)
export ROOT_DIR ?= $(CURDIR)
export OUTPUT_DIR ?= $(ROOT_DIR)
export RPM_TMPDIR ?= $(ROOT_DIR)/tmp

# This directory contains all of our packages we will be building.
PKG_DIR += $(CURDIR)/packages

# This is the directory that will contain all of our yum repos.
REPO_DIR := $(CURDIR)/repos

# This directory contains images files, the Makefiles, and other files needed for ISO generation
KICKSTART_DIR := $(CURDIR)/images

# Files supporting the build process
SUPPORT_DIR := $(CURDIR)/support

# mock will be used to build the packages in a clean environment.
MOCK_CONF_DIR := $(CONF_DIR)/mock

# we need a yum.conf to use for repo querying (to determine appropriate package versions when multiple version are present)
YUM_CONF_FILE := $(CONF_DIR)/yum/yum.conf

# These are the directories where we will put our custom copies of
# the yum repos.  These will be removed by "make bare".
MY_REPO_DIR := $(REPO_DIR)/my-repo
MY_RHEL_REPO_DIR := $(REPO_DIR)/my-rhel-repo
MY_EPEL_REPO_DIR := $(REPO_DIR)/my-epel-repo
MY_BUILDGROUPS_REPO_DIR := $(REPO_DIR)/my-buildgroups-repo
MY_SRPM_REPO_DIR := $(REPO_DIR)/my-srpm-repo
export REPO_LINES := $(shell echo 'repo --name=my-repo --baseurl=file://$(MY_REPO_DIR)\nrepo --name=my-rhel --baseurl=file://$(MY_RHEL_REPO_DIR)\nrepo --name=my-epel --baseurl=file://$(MY_EPEL_REPO_DIR)\n' )

export SRPM_OUTPUT_DIR ?= $(MY_SRPM_REPO_DIR)

export LIVECD_CREATOR := $(SUPPORT_DIR)/livecd-creator
export MAYFLOWER := $(SUPPORT_DIR)/mayflower

SED = /bin/sed
GREP = /bin/egrep
MOCK = /usr/bin/mock
REPO_LINK = /bin/ln -s
REPO_WGET = /usr/bin/wget
REPO_CREATE = /usr/bin/createrepo -d -c $(REPO_DIR)/yumcache
REPO_REFRESH = $(CURDIR)/support/yumnew.sh
REPO_QUERY =  repoquery -c $(YUM_CONF_FILE) --quiet -a --queryformat '%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}.rpm'
MOCK_ARGS += --resultdir=$(MY_REPO_DIR) -r $(MOCK_REL) --configdir=$(MOCK_CONF_DIR) --unpriv --rebuild

# Repos deps
MY_REPO_DEPS := $(MY_RHEL_REPO_DIR)/last-updated $(MY_EPEL_REPO_DIR)/last-updated $(MY_BUILDGROUPS_REPO_DIR)/last-updated

# Config deps
BUILD_CONFIG_DEPS := $(ROOT_DIR)/BUILD_CONFIG

# This deps list gets propegated down to sub-makefiles
# Add to this list to pass deps down to SRPM creation
export SRPM_DEPS := $(BUILD_CONFIG_DEPS)

# Macros to determine package info: version, release, arch.
PKG_VER = $(strip $(eval $(shell $(GREP) ^VERSION $(PKG_DIR)/$(1)/Makefile))$(VERSION))
PKG_REL = $(strip $(eval $(shell $(GREP) ^RELEASE $(PKG_DIR)/$(1)/Makefile))$(RELEASE))
PKG_ARCH = $(strip $(eval $(shell $(GREP) ^ARCH $(PKG_DIR)/$(1)/Makefile))$(ARCH))
# macros for converting between package name and file names
RPM_FROM_PKG_NAME = $(1)-$(call PKG_VER,$(1))-$(call PKG_REL,$(1)).$(call PKG_ARCH,$(1)).rpm
SRPM_FROM_PKG_NAME = $(1)-$(call PKG_VER,$(1))-$(call PKG_REL,$(1)).src.rpm
PKG_NAME_FROM_RPM = $(shell echo "$(1)" | $(SED) -r -e 's/^([^-]+[A-Za-z_-]?+)-.*$$/\1/')
SRPM_FROM_RPM = $(patsubst %.$(call PKG_ARCH,$(call PKG_NAME_FROM_RPM,$(1))).rpm,%.src.rpm,$(1))

# Create the list of RPMs based on package list.
RPMS := $(addprefix $(MY_REPO_DIR)/,$(foreach PKG,$(PACKAGES),$(call RPM_FROM_PKG_NAME,$(strip $(PKG)))))
SRPMS := $(addprefix $(SRPM_OUTPUT_DIR)/,$(foreach RPM,$(RPMS),$(call SRPM_FROM_RPM,$(notdir $(RPM)))))

ifeq ($(QUIET),y)
	VERBOSE = @
endif

MKDIR = $(VERBOSE)test -d $(1) || mkdir -p $(1)

# These are targets supported by the kickstart/Makefile that will be used to generate LiveCD images.
LIVECDS := $(addsuffix -livecd,$(SYSTEMS))

# These are targets supported by the kickstart/Makefile that will be used to generate installation ISOs.
INSTISOS := $(addsuffix -installation-iso,$(SYSTEMS))


# Add a file to a repo by either downloading it (if http/ftp), or symlinking if local.
# TODO: add support for wget (problem with code below, running echo/grep for each file instead of once for the whole repo
#@if ( echo "$(2)" | $(GREP) -i -q '^http[s]?://|^ftp://' ); then\
#	$(REPO_WGET) $(2)/$(1) -O $(3)/$(1);\
#else\
#	$(REPO_LINK) $(2)/$(1) $(3)/$(1);\
#fi
define REPO_ADD_FILE
	$(VERBOSE)[ -h $(3)/$(1) ] || $(REPO_LINK) $(2)/$(1) $(3)/$(1)
endef

# These macros are used to generate build rules.  This is an unfortunate consequence of not being able to do complex
# target name->dependency name munging, eg not being able to convert foo.<random arch>.rpm into foo.src.rpm.
define RPM_RULE_template
ifneq ($(DISABLE_MOCK),y)
$(1):   $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1))) $(MY_REPO_DEPS) $(MOCK_CONF_DIR)/$(MOCK_REL).cfg
	$(call MKDIR,$(MY_REPO_DIR))
	$(VERBOSE)$(MOCK) $(MOCK_ARGS) $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
else
$(1):   $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
	$(call MKDIR,$(MY_REPO_DIR))
	$(VERBOSE)OUTPUT_DIR=$(MY_REPO_DIR) $(MAKE) -C $(PKG_DIR)/$(call PKG_NAME_FROM_RPM,$(notdir $(1))) rpm
endif
ifeq ($(ENABLE_SIGNING),y)
	$(RPM) --addsign $(MY_REPO_DIR)/*
endif
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-rpm: $(1)
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-nomock-rpm: $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
	$(call MKDIR,$(MY_REPO_DIR))
	$(VERBOSE)OUTPUT_DIR=$(MY_REPO_DIR) $(MAKE) -C $(PKG_DIR)/$(call PKG_NAME_FROM_RPM,$(notdir $(1))) rpm
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-srpm: $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-clean:
	$(RM) $(1)
	$(RM) $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
endef

# END MAGIC
######################################################

######################################################
# BEGIN RULES
all: create-repos $(LIVECDS)

create-repos: setup-rhel-repo setup-epel-repo setup-buildgroups-repo setup-my-repo

setup-my-repo: $(RPMS)
	$(VERBOSE)for pkg in $(PREPACKAGED); do ln -s $$pkg $(MY_REPO_DIR); done
	@echo "Generating yum repo metadata, this could take a few minutes..."
	cd $(MY_REPO_DIR) && $(REPO_CREATE) .

setup-rhel-repo: $(MY_RHEL_REPO_DIR)/last-updated

setup-epel-repo: $(MY_EPEL_REPO_DIR)/last-updated

setup-buildgroups-repo: $(MY_BUILDGROUPS_REPO_DIR)/last-updated

$(MY_RHEL_REPO_DIR)/last-updated: $(RHEL_PKG_LIST_FILE)
	@echo "Cleaning RHEL yum repo, this could take a few minutes..."
	$(VERBOSE)$(RM) -r $(MY_RHEL_REPO_DIR)
	@echo "Populating RHEL yum repo, this could take a few minutes..."
	$(call MKDIR,$(MY_RHEL_REPO_DIR))
	$(VERBOSE)while read fil; do $(REPO_LINK) $(RHEL_REPO_DIR)/$$fil $(MY_RHEL_REPO_DIR)/$$fil; done < $(RHEL_PKG_LIST_FILE)
	@echo "Generating RHEL yum repo metadata, this could take a few minutes..."
	$(VERBOSE)cd $(MY_RHEL_REPO_DIR) && $(REPO_CREATE) .
	$(VERBOSE)touch $@

$(MY_EPEL_REPO_DIR)/last-updated: $(EPEL_PKG_LIST_FILE)
	@echo "Cleaning EPEL yum repo, this could take a few minutes..."
	$(VERBOSE)$(RM) -r $(MY_EPEL_REPO_DIR)
	@echo "Populating EPEL yum repo, this could take a few minutes..."
	$(call MKDIR,$(MY_EPEL_REPO_DIR))
	$(VERBOSE)while read fil; do $(REPO_LINK) $(EPEL_REPO_DIR)/$$fil $(MY_EPEL_REPO_DIR)/$$fil; done < $(EPEL_PKG_LIST_FILE)
	@echo "Generating EPEL yum repo metadata, this could take a few minutes..."
	$(VERBOSE)cd $(MY_EPEL_REPO_DIR) && $(REPO_CREATE) .
	$(VERBOSE)touch $@

$(MY_BUILDGROUPS_REPO_DIR)/last-updated: $(BUILDGROUPS_PKG_LIST_FILE)
	@echo "Cleaning Build Groups yum repo, this could take a few minutes..."
	$(VERBOSE)$(RM) -r $(MY_BUILDGROUPS_REPO_DIR)
	@echo "Populating Build Groups yum repo, this could take a few minutes..."
	$(call MKDIR,$(MY_BUILDGROUPS_REPO_DIR))
	$(VERBOSE)while read fil; do $(REPO_LINK) $(BUILDGROUPS_REPO_DIR)/$$fil $(MY_BUILDGROUPS_REPO_DIR)/$$fil; done < $(BUILDGROUPS_PKG_LIST_FILE)
	@echo "Generating Build Groups yum repo metadata, this could take a few minutes..."
	$(VERBOSE)cd $(MY_BUILDGROUPS_REPO_DIR) && $(REPO_CREATE) .
	$(VERBOSE)touch $@

rpms: $(RPMS)

# The following line calls our RPM rule template defined above allowing us to build a proper dependency list.
$(foreach RPM,$(RPMS),$(eval $(call RPM_RULE_template,$(RPM))))

srpms: $(SRPMS)

%.src.rpm: FORCE
	$(call MKDIR,$(SRPM_OUTPUT_DIR))
	$(MAKE) -C $(PKG_DIR)/$(call PKG_NAME_FROM_RPM,$(notdir $@)) srpm

$(LIVECDS): VERSION create-repos $(RPMS)
	$(MAKE) -C $(KICKSTART_DIR)/ $@

$(INSTISOS):
	$(MAKE) -C $(KICKSTART_DIR)/ $@

$(MOCK_CONF_DIR)/$(MOCK_REL).cfg: $(MOCK_CONF_DIR)/$(MOCK_REL).cfg.tmpl
	$(VERBOSE)sed -e 's:%%MY_RHEL_REPO_DIR%%:$(MY_RHEL_REPO_DIR):' -e 's:%%MY_EPEL_REPO_DIR%%:$(MY_EPEL_REPO_DIR):' \
	-e 's:%%MY_BUILDGROUPS_REPO_DIR%%:$(MY_BUILDGROUPS_REPO_DIR):' $(MOCK_CONF_DIR)/$(MOCK_REL).cfg.tmpl > $@

$(RHEL_PKG_LIST_FILE):
	$(VERBOSE)cat $(YUM_CONF_FILE).tmpl > $(YUM_CONF_FILE)
	echo -e "[$(RHEL_REPOID)]\nname=$(RHEL_REPOID)\nbaseurl=file://$(RHEL_REPO_DIR)\nenabled=1" >> $(YUM_CONF_FILE)
	$(VERBOSE)$(REPO_QUERY) --repoid=$(RHEL_REPOID) |sort 1>$(RHEL_PKG_LIST_FILE)

$(EPEL_PKG_LIST_FILE):
	$(VERBOSE)cat $(YUM_CONF_FILE).tmpl > $(YUM_CONF_FILE)
	echo -e "[$(EPEL_REPOID)]\nname=$(EPEL_REPOID)\nbaseurl=file://$(EPEL_REPO_DIR)\nenabled=1" >> $(YUM_CONF_FILE)
	$(VERBOSE)$(REPO_QUERY) --repoid=$(EPEL_REPOID) |sort 1>$(EPEL_PKG_LIST_FILE)

$(BUILDGROUPS_PKG_LIST_FILE):
	$(VERBOSE)cat $(YUM_CONF_FILE).tmpl > $(YUM_CONF_FILE)
	echo -e "[$(BUILDGROUPS_REPOID)]\nname=$(BUILDGROUPS_REPOID)\nbaseurl=file://$(BUILDGROUPS_REPO_DIR)\nenabled=1" >> $(YUM_CONF_FILE)
	$(VERBOSE)$(REPO_QUERY) --repoid=$(BUILDGROUPS_REPOID) |sort 1>$(BUILDGROUPS_PKG_LIST_FILE)

iso-to-disk:
	@if [ x"$(ISO_FILE)" = "x" -o x"$(USB_DEV)" = "x" ]; then echo "Error: set ISO_FILE=<filename> and USB_DEV=<dev> on command line to generate a bootable thumbdrive." && exit 1; fi
	@if echo "$(USB_DEV)" | egrep -q "^.*[0-9]$$"; then echo "Error: it looks like you gave me a partition.  Set USB_DEV to a device root, eg /dev/sdb." && exit 1; fi
	@if [ ! -b $(USB_DEV) ]; then echo "Error: $(USB_DEV) doesn't exist or isn't a block device." && exit 1; fi
	@if `sudo mount | grep -q $(USB_DEV)`; then echo "Warning - device is currently mounted!  I will unmount it for you.  Press Ctrl-C to cancel or any other key to continue."; read; sudo umount $(USB_DEV)1 2>&1 > /dev/null; fi
	@if `sudo pvdisplay 2>/dev/null | grep -q $(USB_DEV)`; then echo "Warning - device is currently a a physical volume in an LVM configuration!  This usually means you're pointing me at your root filesystem instead of a thumbdrive. Try again or kill the LVM label with pvremove"; exit 1; fi
	@echo -e "WARNING: This will destroy the contents of $(USB_DEV)!\nPress Ctrl-C to cancel or any other key to continue." && read
	@echo "Destroying MBR and partition table."
	$(VERBOSE)sudo dd if=/dev/zero of=$(USB_DEV) bs=512 count=1
	@echo "Creating partition..."
	$(VERBOSE)sudo sh -c "echo -e 'n\np\n1\n\n\n\nt\nb\na\n1\nw\n' | /sbin/fdisk $(USB_DEV)" || true
	@sleep 5
	$(VERBOSE)sudo umount $(USB_DEV)1 2>&1 > /dev/null || true
	@echo "Creating filesystem..."
	$(VERBOSE)sudo /sbin/mkdosfs -n CLIP $(USB_DEV)1
	$(VERBOSE)sudo umount $(USB_DEV)1 2>&1 > /dev/null || true
	@echo "Writing image..."
	$(VERBOSE)sudo $(CURDIR)/support/livecd-iso-to-disk --resetmbr $(ISO_FILE) $(USB_DEV)1

bare-repos:
	$(VERBOSE)$(RM) -r $(MY_RHEL_REPO_DIR)
	$(VERBOSE)$(RM) -r $(MY_EPEL_REPO_DIR)
	$(VERBOSE)$(RM) -r $(MY_REPO_DIR)
	$(VERBOSE)$(RM) -r $(MY_SRPM_REPO_DIR)
	$(VERBOSE)$(RM) $(MOCK_CONF_DIR)/$(MOCK_REL).cfg

clean:
	$(VERBOSE)for pkg in $(PACKAGES); do $(MAKE) -C $(PKG_DIR)/$$pkg $@; done
	$(RM) -r $(RPM_TMPDIR)

bare: bare-repos clean
	for pkg in $(PACKAGES); do $(MAKE) -C $(PKG_DIR)/$$pkg $@; done
	$(VERBOSE)$(RM) $(addprefix $(SRPM_OUTPUT_DIR),$(SRPMS))
	$(VERBOSE)$(RM) $(addprefix $(OUTPUT_DIR),$(RPMS))

FORCE:

.PHONY: all all-vm create-repos setup-my-repo setup-epel-repo setup-rhel-repo setup-buildgroups-repo srpms rpms clean bare bare-repos $(addsuffix -rpm,$(PACKAGES)) $(addsuffix -srpm,$(PACKAGES)) $(addsuffix -nomock-rpm,$(PACKAGES)) $(addsuffix -clean,$(PACKAGES)) $(LIVECDS) $(INSTISOS) FORCE

help:
	@echo "The following make targets are available for generating installable ISOs:"
	@echo "	all (generate all installation ISOs and Live CDs)"
	@for cd in $(INSTISOS); do echo "	$$cd"; done
	@echo
	@echo "The following make targets are available for generating Live CDs:"
	@echo "	all (generate all installation ISOs and Live CDs)"
	@for cd in $(LIVECDS); do echo "	$$cd"; done
	@echo
	@echo "The following make targets are available for generating RPMs in mock:"
	@echo "	rpms (generate all rpms in mock)"
	@for pkg in $(PACKAGES); do echo "	$$pkg-rpm"; done
	@echo
	@echo "The following make targets are available for generating RPMs without mock:"
	@for pkg in $(PACKAGES); do echo "	$$pkg-nomock-rpm"; done
	@echo
	@echo "The following make targets are available for generating SRPMS:"
	@echo "	srpms (generate all src rpms)"
	@for pkg in $(PACKAGES); do echo "	$$pkg-srpm"; done
	@echo
	@echo "To burn a livecd image to a thumbdrive:"
	@echo "	iso-to-disk ISO_FILE=<isofilename> USB_DEV=<devname>"
	@echo
	@echo "The following make targets are available for cleaning:"
	@for pkg in $(PACKAGES); do echo "	$$pkg-clean (remove rpm and srpm)"; done
	@echo "	clean (cleans transient files)"
	@echo "	bare-repos (deletes local repos)"
	@echo "	bare (deletes everything except ISOs)"
	@echo
	@echo "The following variables are useful for overriding settings from the command line:"
	@echo "	DISABLE_MOCK=<y/n> - If set to 'y' this variable will disable mock for generation of all RPMs"


# END RULES
######################################################
