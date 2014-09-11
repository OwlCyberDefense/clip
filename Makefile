# Copyright (C) 2011-2012,2014 Tresys Technology, LLC
# Copyright (C) 2011-2012 Quark Security, Inc
# Copyright (C) 2013 Cubic Corporation
# 
# Authors: Spencer Shimko <sshimko@tresys.com>
#          Spencer Shimko <spencer@quarksecurity.com>
#	   John Feehley <jfeehley@quarksecurity.com>
#
# Typically a user of CLIP does not have to modify this file.
# See CONFIG_BUILD for configuration options
# See CONFIG_REPOS to setup yum repos


######################################################
# Import build config (version, release, repos, etc)
include CONFIG_BUILD

# This is the RHEL version supported by this release of CLIP.  Do not alter.
export RHEL_VER := 7

######################################################
# BEGIN MAGIC
ifneq ($(QUIET),y)
$(info Boot strapping build system...)
endif

# NOTE: DO NOT REMOVE THIS CHECK. RUNNING MOCK AS ROOT *WILL* BREAK THINGS.
ifeq ($(shell id -u),0)
$(error Never CLIP as root! It will break things!  Try again as an unprivileged user with sudo access.)
endif

# Unfortunately there is a package we need that isn't in RHEL/EPEL/Opt.
# Or they are packages from upstream we have to patch.
# So we will roll it ourselves inside of mock :)
HOST_REQD_PKGS := pungi livecd-tools

HOST_RPM_DEPS := rpm-build createrepo mock repoview lorax pungi

export ROOT_DIR ?= $(CURDIR)
export OUTPUT_DIR ?= $(ROOT_DIR)
export RPM_TMPDIR ?= $(ROOT_DIR)/tmp
export CONF_DIR ?= $(ROOT_DIR)/conf

# Config deps
CONFIG_BUILD_DEPS = $(ROOT_DIR)/CONFIG_BUILD $(ROOT_DIR)/CONFIG_REPOS $(ROOT_DIR)/Makefile $(CONF_DIR)/pkglist.blacklist

# MOCK_REL must be configured in MOCK_CONF_DIR/MOCK_REL.cfg
MOCK_REL := rhel-$(RHEL_VER)-$(TARGET_ARCH)

# This directory contains all of our packages we will be building.
PKG_DIR += $(CURDIR)/packages
PACKAGES := $(shell ls $(PKG_DIR) | grep -v examples)

# This is the directory that will contain all of our yum repos.
REPO_DIR := $(CURDIR)/repos

# This directory contains images files, the Makefiles, and other files needed for ISO generation
KICKSTART_DIR := $(CURDIR)/kickstart

# Files supporting the build process
SUPPORT_DIR := $(CURDIR)/support

# mock will be used to build the packages in a clean environment.
MOCK_CONF_DIR := $(CONF_DIR)/mock

# we need a yum.conf to use for repo querying (to determine appropriate package versions when multiple version are present)
YUM_CONF_FILE := $(CONF_DIR)/yum/yum.conf

# Pungi needs a comps.xml - why does every single yum front-end suck in different ways?
COMPS_FILE := $(CONF_DIR)/yum/comps.xml

export MOCK_YUM_CONF :=
export MY_REPO_DEPS :=
export setup_all_repos := setup-clip-repo
CLIP_REPO_DIRS :=

# These are the directories where we will put our custom copies of
# the yum repos.  These will be removed by "make bare".
CLIP_REPO_DIR := $(REPO_DIR)/clip-repo
CLIP_SRPM_REPO_DIR := $(REPO_DIR)/clip-srpms
export REPO_LINES := repo --name=clip-repo --baseurl=file://$(CLIP_REPO_DIR)\n

export SRPM_OUTPUT_DIR := $(CLIP_SRPM_REPO_DIR)

export LIVECD_CREATOR := /usr/bin/livecd-creator
export MAYFLOWER := $(SUPPORT_DIR)/mayflower

SED := /bin/sed
GREP := /bin/egrep
MOCK := /usr/bin/mock
REPO_LINK := /bin/ln -s
REPO_WGET := /usr/bin/wget
REPO_CREATE := /usr/bin/createrepo -d --workers $(shell /usr/bin/nproc) -c $(REPO_DIR)/yumcache
REPO_QUERY :=  repoquery -c $(YUM_CONF_FILE) --quiet -a --queryformat '%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}.rpm'
MOCK_ARGS += --resultdir=$(CLIP_REPO_DIR) -r $(MOCK_REL) --configdir=$(MOCK_CONF_DIR) --unpriv --rebuild

# This deps list gets propegated down to sub-makefiles
# Add to this list to pass deps down to SRPM creation
export SRPM_DEPS := $(CONFIG_BUILD_DEPS)

PKG_BLACKLIST := $(shell $(SED) -e 's/\(.*\)\#.*/\1/g' $(CONF_DIR)/pkglist.blacklist|$(SED) -e ':a;N;$$!ba;s/\n/ /g')

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
RPMS := $(addprefix $(CLIP_REPO_DIR)/,$(foreach PKG,$(PACKAGES),$(call RPM_FROM_PKG_NAME,$(strip $(PKG)))))
SRPMS := $(addprefix $(SRPM_OUTPUT_DIR)/,$(foreach RPM,$(RPMS),$(call SRPM_FROM_RPM,$(notdir $(RPM)))))

ifeq ($(QUIET),y)
	VERBOSE = @
endif

MKDIR = $(VERBOSE)test -d $(1) || mkdir -p $(1)

SYSTEMS := $(shell ls $(KICKSTART_DIR))

# These are targets supported by the kickstart/Makefile that will be used to generate LiveCD images.
LIVECDS := $(foreach SYSTEM,$(SYSTEMS),$(addsuffix -live-iso,$(SYSTEM)))

# These are targets supported by the kickstart/Makefile that will be used to generate installation ISOs.
INSTISOS := $(foreach SYSTEM,$(SYSTEMS),$(addsuffix -iso,$(SYSTEM)))

# Add a file to a repo by either downloading it (if http/ftp), or symlinking if local.
# TODO: add support for wget (problem with code below, running echo/GREP for each file instead of once for the whole repo
#@if ( echo "$(2)" | $(GREP) -i -q '^http[s]?://|^ftp://' ); then\
#	$(REPO_WGET) $(2)/$(1) -O $(3)/$(1);\
#else\
#	$(REPO_LINK) $(2)/$(1) $(3)/$(1);\
#fi
define REPO_ADD_FILE
	$(VERBOSE)[ -h $(3)/$(1) ] || $(REPO_LINK) $(2)/$(1) $(3)/$(1)
endef

define CHECK_DEPS
	@if ! rpm -q $(HOST_RPM_DEPS) 2>&1 >/dev/null; then echo "Please ensure the following RPMs are installed: $(HOST_RPM_DEPS)."; exit 1; fi
	@if [ x"`cat /sys/fs/selinux/enforce`" == "x1" ]; then echo -e "This is embarassing but due to a bug (bz #861281) you must do builds in permissive.\nhttps://bugzilla.redhat.com/show_bug.cgi?id=861281" && exit 1; fi
endef

define CHECK_MOCK
	@if ps -eo comm= | grep -q mock; then echo "ERROR: Another instance of mock is running.  Please hangup and try your build again later." && exit 1; fi
endef

define CHECK_LIVE_TOOLS
	if [ x"`rpm -q livecd-tools --queryformat '%{version}-%{release}\n'`" \
		!= x"$$( rpm --eval `sed -n -e 's/Release: \(.*\)/\1/p' -e 's/Version: \(.*\)/\1/p' \
		 packages/livecd-tools/livecd-tools.spec| sed 'N;s/\n/-/'` )" ]; then \
		echo "Error: you have to use our version of livecd-tools."; \
		echo "We will attempt to install them now.  Press ctrl-c to cancel."; \
		sudo yum remove livecd-tools python-imgcreate -y 2>&1 >/dev/null || true ; \
		$(MAKE) livecd-tools-rpm; \
		cd $(CLIP_REPO_DIR); \
		sudo yum localinstall livecd-tools*.noarch.rpm python-imgcreate* -y; \
	fi
endef

######################################################
# BEGIN RPM GENERATION RULES (BEWARE OF DRAGONS)
# This define directive is used to generate build rules.
define RPM_RULE_template
$(1): $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1))) $(MY_REPO_DEPS) $(MOCK_CONF_DIR)/$(MOCK_REL).cfg
	$(call CHECK_DEPS)
	$(call MKDIR,$(CLIP_REPO_DIR))
	$(call CHECK_MOCK)
	$(VERBOSE)$(MOCK) $(MOCK_ARGS) $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
	cd $(CLIP_REPO_DIR) && $(REPO_CREATE) .
ifeq ($(ENABLE_SIGNING),y)
	$(RPM) --addsign $(CLIP_REPO_DIR)/*
endif
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-rpm:  $(1)
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-nomock-rpm:  $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
	$(call CHECK_DEPS)
	$(call MKDIR,$(CLIP_REPO_DIR))
	$(VERBOSE)OUTPUT_DIR=$(CLIP_REPO_DIR) $(MAKE) -C $(PKG_DIR)/$(call PKG_NAME_FROM_RPM,$(notdir $(1))) rpm
	cd $(CLIP_REPO_DIR) && $(REPO_CREATE) .
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-srpm:  $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-clean:
	$(call CHECK_DEPS)
	$(RM) $(1)
	$(RM) $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
endef
# END RPM GENERATION RULES (BEWARE OF DRAGONS)
######################################################

GET_REPO_ID = $(strip $(shell echo "$(1)" | $(SED) -e 's/\(.*\)=.*/\1/'))
GET_REPO_PATH = $(strip $(shell echo "$(1)" | $(SED) -e 's/.*=\(.*\)/\1/'))
GET_REPO_URL = $(strip $(shell if `echo "$(1)" | $(GREP) -Eq '^\/.*$$'`; then echo "file://$(1)"; else echo "$(1)"; fi))

######################################################
# BEGIN REPO GENERATION RULES (BEWARE OF RMS)
# This define directive is used to generate rules for managing the yum repos.
# Since the user of the build system can customize the repos in CONFIG_REPOS
# we need to generate targets out of the contents of that file.  The previous
# implementation had static rules and required a lot of work to add/remove
# or otherwise customize the repos.
define REPO_RULE_template
$(eval REPO_ID := $(call GET_REPO_ID, $(1)))
ifneq ($(strip $(1)),)
$(eval REPO_PATH := $(call GET_REPO_PATH,$(1)))
# puts the url into clip-repo.cfg
$(eval REPO_URL := file://$(REPO_DIR)/$(REPO_ID)-repo)
$(eval setup_all_repos += setup-$(REPO_ID)-repo)

$(eval YUM_CONF := [$(REPO_ID)]\\nname=$(REPO_ID)\\nbaseurl=file://$(REPO_PATH)\\nenabled=1\\n\\nexclude=$(strip $(PKG_BLACKLIST))\\n)
$(eval MOCK_YUM_CONF := $(MOCK_YUM_CONF)[$(REPO_ID)]\\nname=$(REPO_ID)\\nbaseurl=$(REPO_URL)\\nenabled=1\\n\\nexclude=$(strip $(PKG_BLACKLIST))\\n)
$(eval MY_REPO_DEPS += $(REPO_DIR)/$(REPO_ID)-repo/last-updated)
$(eval REPO_LINES := $(REPO_LINES)repo --name=$(REPO_ID) --baseurl=file://$(REPO_DIR)/$(REPO_ID)-repo\n)

$(eval CLIP_REPO_DIRS += "$(REPO_DIR)/$(REPO_ID)-repo")
$(eval PKG_LISTS += "./$(shell basename $(CONF_DIR))/pkglist.$(REPO_ID)")

setup-$(REPO_ID)-repo:  $(REPO_DIR)/$(REPO_ID)-repo/last-updated $(CONFIG_BUILD_DEPS)

# This is the key target for managing yum repos.  If the pkg list for the repo
# is more recent then our private repo regen the repo by symlink'ing the packages into our repo.
$(REPO_DIR)/$(REPO_ID)-repo/last-updated: $(CONF_DIR)/pkglist.$(REPO_ID) $(CONFIG_BUILD_DEPS)
	@echo "Cleaning $(REPO_ID) yum repo, this could take a few minutes..."
	$(VERBOSE)$(RM) -r $(REPO_DIR)/$(REPO_ID)-repo
	@echo "Populating $(REPO_ID) yum repo, this could take a few minutes..."
	@if [ ! -d $(REPO_PATH) ]; then echo -e "\nError yum repo path doesn't exist: $(REPO_PATH)\n"; exit 1; fi
	@if [ ! -s $(CONF_DIR)/pkglist.$(REPO_ID) ]; then echo -e "\nError pkglist file is empty or does not exist: $(CONF_DIR)/pkglist.$(REPO_ID)\n"; exit 1; fi
	$(call MKDIR,$(REPO_DIR)/$(REPO_ID)-repo)
	$(VERBOSE)while read fil; do $(REPO_LINK) $(REPO_PATH)/$$$$fil $(REPO_DIR)/$(REPO_ID)-repo/$$$$fil; done < $(CONF_DIR)/pkglist.$(REPO_ID)
	@echo "Generating $(REPO_ID) yum repo metadata, this could take a few minutes..."
	$(VERBOSE)cd $(REPO_DIR)/$(REPO_ID)-repo && $(REPO_CREATE) .
	$(VERBOSE)touch $(REPO_DIR)/$(REPO_ID)-repo/last-updated

# If a pkglist is missing then assume we should generate one ourselves.
# Note that the recommended method here is to commit your pkglist file to your own dev repo.
# Then you can consistently rebuild an ISO using the exact same package versions as the last time.
# Effectively versioning the packages you use when rolling RPMs and ISOs.
$(CONF_DIR)/pkglist.$(REPO_ID) ./$(shell basename $(CONF_DIR))/pkglist.$(REPO_ID): $(filter-out $(ROOT_DIR)/CONFIG_BUILD,$(CONFIG_BUILD_DEPS))
	$(VERBOSE)$(RM) $(YUM_CONF_FILE)
	$(VERBOSE)$(RM) $(MOCK_CONF_DIR)/$(MOCK_REL).cfg
	@echo "Generating list of packages for $(call GET_REPO_ID,$(1))"
	$(VERBOSE)cat $(YUM_CONF_FILE).tmpl > $(YUM_CONF_FILE)
	echo -e $(YUM_CONF) >> $(YUM_CONF_FILE)
	$(VERBOSE)$(REPO_QUERY) --repoid=$(REPO_ID) |sort 1>$(CONF_DIR)/pkglist.$(REPO_ID)

endif
endef
# END REPO GENERATION RULES (BEWARE OF RMS)
######################################################

######################################################
# BEGIN RULES

help:
	$(call CHECK_DEPS)
	@echo "The following make targets are available for generating installable ISOs:"
	@echo "	all (roll all packages and generate all installation ISOs)"
	@for cd in $(INSTISOS); do echo "	$$cd"; done
	@echo
	@echo "The following make targets are available for generating Live CDs:"
	@echo "	all (generate all installation ISOs and Live CDs)"
	@for cd in $(LIVECDS); do echo "	$$cd"; done
	@echo
	@echo "	NOTE: if you need to debug a kickstart post script for Live CDs,"
	@echo "	      add LIVECD_ARGS='--shell' to the make command-line."
	@echo
	@echo "To burn a livecd image to a thumbdrive:"
	@echo "	iso-to-disk ISO_FILE=<isofilename> USB_DEV=<devname>"
	@echo "	iso-to-disk ISO_FILE=<isofilename> USB_DEV=<devname> OVERLAY_SIZE=<size in MB>"
	@echo "	iso-to-disk ISO_FILE=<isofilename> USB_DEV=<devname> OVERLAY_SIZE=<size in MB> OVERLAY_HOME_SIZE=<size in MB>"
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
	@echo "The following make targets are available for updating the package lists used for mock and ISO generation:"
	@for pkg in $(PKG_LISTS); do echo "	$$pkg"; done
	@echo
	@echo "The following make targets are available for generating yum repos used for mock and ISO generation:"
	@for repo in $(setup_all_repos); do echo "	$$repo"; done
	@echo
	@echo "The following make targets are available for cleaning:"
	@for pkg in $(PACKAGES); do echo "	$$pkg-clean (remove rpm and srpm)"; done
	@echo "	clean (cleans transient files)"
	@echo "	bare-repos (deletes local repos)"
	@echo "	clean-mock (deletes the yum and mock configuration we generate)"
	@echo "	bare (deletes everything except ISOs)"

all: create-repos $(INSTISOS)

# Generate custom targets for managing the yum repos.  We have to generate the rules since the user provides the set of repos.
$(foreach REPO,$(strip $(shell cat CONFIG_REPOS|$(GREP) -E '^[a-zA-Z].*=.*'|$(SED) -e 's/ \?= \?/=/')),$(eval $(call REPO_RULE_template,$(REPO))))

# The following line calls our RPM rule template defined above allowing us to build a proper dependency list.
$(foreach RPM,$(RPMS),$(eval $(call RPM_RULE_template,$(RPM))))

# We need some packages on the build host that aren't available in EPEL, RHEL, Opt.
SRPMS := $(SRPMS) $(addprefix $(SRPM_OUTPUT_DIR)/,$(foreach RPM,$(HOST_RPMS),$(call SRPM_FROM_RPM,$(notdir $(RPM)))))

create-repos: $(setup_all_repos)

setup-clip-repo: setup-pre-rolled-packages $(RPMS)
	$(call CHECK_DEPS)
	@echo "Generating yum repo metadata, this could take a few minutes..."
	$(VERBOSE)cd $(CLIP_REPO_DIR) && $(REPO_CREATE) -g $(COMPS_FILE) .

setup-pre-rolled-packages:
	$(call CHECK_DEPS)
	$(call MKDIR,$(CLIP_REPO_DIR))
	@set -e; for pkg in $(PRE_ROLLED_PACKAGES); do \
           [ -f "$$pkg" ] || ( echo "Failed to find pre-rolled package: $$pkg" && exit 1 );\
           [ -h $(CLIP_REPO_DIR)/`basename $$pkg` ] && rm -f $(CLIP_REPO_DIR)/`basename $$pkg`;\
              $(REPO_LINK) $$pkg $(CLIP_REPO_DIR)|| \
	      ( echo "Failed to find pre-rolled package $$pkg - check CONFIG_BUILD and make sure you use quotes around paths with spaces." && exit 1 );\
        done
	$(VERBOSE)cd $(CLIP_REPO_DIR) && $(REPO_CREATE) -g $(COMPS_FILE) .

rpms: $(RPMS)

srpms: $(SRPMS)

%.src.rpm:  FORCE
	$(call CHECK_DEPS)
	$(call MKDIR,$(SRPM_OUTPUT_DIR))
	$(MAKE) -C $(PKG_DIR)/$(call PKG_NAME_FROM_RPM,$(notdir $@)) srpm

$(LIVECDS):  $(BUILD_CONF_DEPS) create-repos $(RPMS)
	$(call CHECK_DEPS)
	$(call CHECK_LIVE_TOOLS)
	$(MAKE) -C $(KICKSTART_DIR)/"`echo '$(@)'|$(SED) -e 's/\(.*\)-live-iso/\1/'`" live-iso

$(INSTISOS):  $(BUILD_CONF_DEPS) create-repos $(RPMS)
	$(call CHECK_DEPS)
	$(MAKE) -C $(KICKSTART_DIR)/"`echo '$(@)'|$(SED) -e 's/\(.*\)-iso/\1/'`" iso

$(MOCK_CONF_DIR)/$(MOCK_REL).cfg:  $(MOCK_CONF_DIR)/$(MOCK_REL).cfg.tmpl $(CONF_DIR)/pkglist.blacklist
	$(call CHECK_DEPS)
	$(VERBOSE)cat $(MOCK_CONF_DIR)/$(MOCK_REL).cfg.tmpl > $@
	$(VERBOSE)echo -e $(MOCK_YUM_CONF) >> $@
	$(VERBOSE)echo '"""' >> $@

ifneq ($(OVERLAY_HOME_SIZE),)
OVERLAYS += --home-size-mb $(OVERLAY_HOME_SIZE)
endif
ifneq ($(OVERLAY_SIZE),)
OVERLAYS += --overlay-size-mb $(OVERLAY_SIZE)
endif

iso-to-disk:
	@if [ x"$(ISO_FILE)" = "x" -o x"$(USB_DEV)" = "x" ]; then echo "Error: set ISO_FILE=<filename> and USB_DEV=<dev> on command line to generate a bootable thumbdrive." && exit 1; fi
	@if echo "$(USB_DEV)" | $(GREP) -q "^.*[0-9]$$"; then echo "Error: it looks like you gave me a partition.  Set USB_DEV to a device root, eg /dev/sdb." && exit 1; fi
	@if [ ! -b $(USB_DEV) ]; then echo "Error: $(USB_DEV) doesn't exist or isn't a block device." && exit 1; fi
	@if `sudo mount | $(GREP) -q $(USB_DEV)`; then echo "Warning - device is currently mounted!  I will unmount it for you.  Press Ctrl-C to cancel or any other key to continue."; read; sudo umount $(USB_DEV)1 2>&1 > /dev/null; fi
	@if `sudo pvdisplay 2>/dev/null | $(GREP) -q $(USB_DEV)`; then echo "Warning - device is currently a a physical volume in an LVM configuration!  This usually means you're pointing me at your root filesystem instead of a thumbdrive. Try again or kill the LVM label with pvremove"; exit 1; fi
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
	$(VERBOSE)sudo /usr/bin/livecd-iso-to-disk $(OVERLAYS) --resetmbr $(ISO_FILE) $(USB_DEV)1
clean-mock: $(ROOT_DIR)/CONFIG_REPOS $(ROOT_DIR)/Makefile $(CONF_DIR)/pkglist.blacklist
	$(VERBOSE)$(RM) $(YUM_CONF_FILE)
	$(VERBOSE)$(RM) $(MOCK_CONF_DIR)/$(MOCK_REL).cfg
	$(VERBOSE)$(RM) -rf $(REPO_DIR)/yumcache

bare-repos: clean-mock
	$(VERBOSE)$(RM) -r $(CLIP_REPO_DIRS) $(CLIP_REPO_DIR)

clean:
	@sudo $(RM) -rf $(RPM_TMPDIR)
	@$(VERBOSE)for pkg in $(PACKAGES); do $(MAKE) -C $(PKG_DIR)/$$pkg $@; done

bare: bare-repos clean
	for pkg in $(PACKAGES); do $(MAKE) -C $(PKG_DIR)/$$pkg $@; done
	$(VERBOSE)$(RM) $(addprefix $(SRPM_OUTPUT_DIR),$(SRPMS))
	$(VERBOSE)$(RM) $(addprefix $(OUTPUT_DIR),$(RPMS))

FORCE:

# Unfortunately mock isn't exactly "parallel" friendly which sucks since we could roll a bunch of packages in parallel.
.NOTPARALLEL:

.PHONY:  all all-vm create-repos $(setup_all_repos) srpms rpms clean bare bare-repos $(addsuffix -rpm,$(PACKAGES)) $(addsuffix -srpm,$(PACKAGES)) $(addsuffix -nomock-rpm,$(PACKAGES)) $(addsuffix -clean,$(PACKAGES)) $(LIVECDS) $(INSTISOS) FORCE clean-mock


# END RULES
######################################################

