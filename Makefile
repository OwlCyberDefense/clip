# Copyright (C) 2011-2012 Tresys Technology, LLC
#
# Authors: Spencer Shimko <sshimko@tresys.com>
#

######################################################
# See BUILD_CONFIG for configuration options
# Import build config (version, release, repos, etc)
include BUILD_CONFIG
# See REPOS_CONFIG to setup yum repos
######################################################

######################################################
# BEGIN MAGIC
$(info Boot strapping build system...)
export ROOT_DIR ?= $(CURDIR)
export OUTPUT_DIR ?= $(ROOT_DIR)
export RPM_TMPDIR ?= $(ROOT_DIR)/tmp
export CONF_DIR ?= $(ROOT_DIR)/conf

BUILD_DATE := $(shell date +%m-%d-%y)

# This the system image type.  This should be a valid directory in kickstart/$(SYSTEM)
SYSTEM := clip-rhel$(RHEL_VER)

# Config deps
BUILD_CONFIG_DEPS = $(ROOT_DIR)/BUILD_CONFIG $(ROOT_DIR)/REPOS_CONFIG $(ROOT_DIR)/Makefile

# Typically we are rolling builds on the target arch.  Changing this may have dire consequences
# (read -> hasn't be tested at all and may result in broken builds and ultimately the end of the universe as we know it).
ARCH := $(shell uname -i)

# MOCK_REL must be configured in MOCK_CONF_DIR/MOCK_REL.cfg
MOCK_REL := rhel-$(RHEL_VER)-$(ARCH)

# This directory contains all of our packages we will be building.
PKG_DIR += $(CURDIR)/packages

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

export MOCK_YUM_CONF :=
export MY_REPO_DEPS :=
export setup_all_repos := setup-my-repo

# These are the directories where we will put our custom copies of
# the yum repos.  These will be removed by "make bare".
MY_REPO_DIR := $(REPO_DIR)/my-repo
MY_SRPM_REPO_DIR := $(REPO_DIR)/my-srpm-repo
export REPO_LINES := repo --name=my-repo --baseurl=file://$(MY_REPO_DIR)\n

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
LIVECDS := $(addsuffix -livecd,$(SYSTEM))

# These are targets supported by the kickstart/Makefile that will be used to generate installation ISOs.
INSTISOS := $(addsuffix -installation-iso,$(SYSTEM))

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

######################################################
# BEGIN RPM GENERATION RULES (BEWARE OF DRAGONS)
# This define directive is used to generate build rules.
# This is an unfortunate consequence of not being able to do complex
# target name->dependency name munging, eg not being able to convert foo.<random arch>.rpm into foo.src.rpm.
define RPM_RULE_template
ifneq ($(DISABLE_MOCK),y)
$(1):   $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1))) $(MY_REPO_DEPS) $(MOCK_CONF_DIR)/$(MOCK_REL).cfg
	$(call MKDIR,$(MY_REPO_DIR))
	$(VERBOSE)$(MOCK) $(MOCK_ARGS) $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
	cd $(MY_REPO_DIR) && $(REPO_CREATE) .
else
$(1):   $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
	$(call MKDIR,$(MY_REPO_DIR))
	$(VERBOSE)OUTPUT_DIR=$(MY_REPO_DIR) $(MAKE) -C $(PKG_DIR)/$(call PKG_NAME_FROM_RPM,$(notdir $(1))) rpm
	cd $(MY_REPO_DIR) && $(REPO_CREATE) .
endif
ifeq ($(ENABLE_SIGNING),y)
	$(RPM) --addsign $(MY_REPO_DIR)/*
endif
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-rpm: $(1)
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-nomock-rpm: $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
	$(call MKDIR,$(MY_REPO_DIR))
	$(VERBOSE)OUTPUT_DIR=$(MY_REPO_DIR) $(MAKE) -C $(PKG_DIR)/$(call PKG_NAME_FROM_RPM,$(notdir $(1))) rpm
	cd $(MY_REPO_DIR) && $(REPO_CREATE) .
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-srpm: $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
$(call PKG_NAME_FROM_RPM,$(notdir $(1)))-clean:
	$(RM) $(1)
	$(RM) $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1)))
endef
# END RPM GENERATION RULES (BEWARE OF DRAGONS)
######################################################

GET_REPO_ID = $(strip $(shell echo "$(1)" | sed -e 's/\(.*\)=.*/\1/'))
GET_REPO_PATH = $(strip $(shell echo "$(1)" | sed -e 's/.*=\(.*\)/\1/'))
GET_REPO_URL = $(strip $(shell if `echo "$(1)" | grep -Eq '^\/.*$$'`; then echo "file://$(1)"; else echo "$(1)"; fi))

######################################################
# BEGIN REPO GENERATION RULES (BEWARE OF RMS)
# This define directive is used to generate rules for managing the yum repos.
# Since the user of the build system can customize the repos in REPOS_CONFIG
# we need to generate targets out of the contents of that file.  The previous
# implementation had static rules and required a lot of work to add/remove
# or otherwise customize the repos.
define REPO_RULE_template
$(eval REPO_ID := $(call GET_REPO_ID, $(1)))
ifneq ($(strip $(1)),)
$(eval REPO_PATH := $(call GET_REPO_PATH,$(1)))
$(eval REPO_URL := $(call GET_REPO_URL,$(call GET_REPO_PATH,$(1))))

$(eval setup_all_repos += setup-$(REPO_ID)$(RHEL_VER)-repo)

$(eval YUM_CONF := [$(REPO_ID)$(RHEL_VER)]\\nname=$(REPO_ID)$(RHEL_VER)\\nbaseurl=$(REPO_URL)\\nenabled=1\\n)
$(eval MOCK_YUM_CONF := $(MOCK_YUM_CONF)$(YUM_CONF))
$(eval MY_REPO_DEPS += $(REPO_DIR)/my-$(REPO_ID)$(RHEL_VER)-repo/last-updated)
$(eval REPO_LINES := $(REPO_LINES)repo --name=my-$(REPO_ID)$(RHEL_VER) --baseurl=file://$(REPO_DIR)/my-$(REPO_ID)$(RHEL_VER)-repo\n)

$(info Generating rules baed on configured repo ID="$(REPO_ID)" PATH=$(REPO_PATH))

setup-$(REPO_ID)$(RHEL_VER)-repo: $(REPO_DIR)/my-$(REPO_ID)$(RHEL_VER)-repo/last-updated $(BUILD_CONFIG_DEPS)

$(REPO_DIR)/my-$(REPO_ID)$(RHEL_VER)-repo/last-updated: $(CONF_DIR)/pkglist.$(REPO_ID)$(RHEL_VER) $(BUILD_CONFIG_DEPS)
	@echo "Cleaning $(REPO_ID) yum repo, this could take a few minutes..."
	$(VERBOSE)$(RM) -r $(REPO_DIR)/my-$(REPO_ID)$(RHEL_VER)-repo
	@echo "Populating $(REPO_ID) yum repo, this could take a few minutes..."
	$(call MKDIR,$(REPO_DIR)/my-$(REPO_ID)$(RHEL_VER)-repo)
	$(VERBOSE)while read fil; do $(REPO_LINK) $(REPO_PATH)/$$$$fil $(REPO_DIR)/my-$(REPO_ID)$(RHEL_VER)-repo/$$$$fil; done < $(CONF_DIR)/pkglist.$(REPO_ID)$(RHEL_VER)
	@echo "Generating $(REPO_ID) yum repo metadata, this could take a few minutes..."
	$(VERBOSE)cd $(REPO_DIR)/my-$(REPO_ID)$(RHEL_VER)-repo && $(REPO_CREATE) .
	$(VERBOSE)touch $(REPO_DIR)/my-$(REPO_ID)$(RHEL_VER)-repo/last-updated


$(CONF_DIR)/pkglist.$(REPO_ID)$(RHEL_VER): $(BUILD_CONFIG_DEPS)
	@echo "Generating list of packages for $(call GET_REPO_ID,$(1))$(RHEL_VER)"
	$(VERBOSE)cat $(YUM_CONF_FILE).tmpl > $(YUM_CONF_FILE)
	echo -e $(YUM_CONF) >> $(YUM_CONF_FILE)
	$(VERBOSE)$(REPO_QUERY) --repoid=$(REPO_ID)$(RHEL_VER) |sort 1>$(CONF_DIR)/pkglist.$(REPO_ID)$(RHEL_VER)

endif
endef
# END REPO GENERATION RULES (BEWARE OF RMS)
######################################################

######################################################
# BEGIN RULES
all: create-repos $(LIVECDS)

# Generate custom targets for managing the yum repos.  We have to generate the rules since the user provides the set of repos.
$(foreach REPO,$(strip $(shell cat REPOS_CONFIG|grep -E '^[a-zA-Z].*=.*'|sed -e 's/ \?= \?/=/')),$(eval $(call REPO_RULE_template,$(REPO))))

# The following line calls our RPM rule template defined above allowing us to build a proper dependency list.
$(foreach RPM,$(RPMS),$(eval $(call RPM_RULE_template,$(RPM))))

create-repos: $(setup_all_repos)

setup-my-repo: $(RPMS)
	@echo "Generating yum repo metadata, this could take a few minutes..."
	cd $(MY_REPO_DIR) && $(REPO_CREATE) .

rpms: $(RPMS)

srpms: $(SRPMS)

%.src.rpm: FORCE
	$(call MKDIR,$(SRPM_OUTPUT_DIR))
	$(MAKE) -C $(PKG_DIR)/$(call PKG_NAME_FROM_RPM,$(notdir $@)) srpm

$(LIVECDS): $(BUILD_CONF_DEPS) create-repos $(RPMS)
	$(MAKE) -C $(KICKSTART_DIR)/"`echo '$(@)'|sed -e 's/\(.*\)-livecd/\1/'`" livecd

$(INSTISOS): $(BUILD_CONF_DEPS) create-repos $(RPMS)
	$(MAKE) -C $(KICKSTART_DIR)/"`echo '$(@)'|sed -e 's/\(.*\)-installation-iso/\1/'`" installation-iso

$(MOCK_CONF_DIR)/$(MOCK_REL).cfg: $(MOCK_CONF_DIR)/$(MOCK_REL).cfg.tmpl
	$(VERBOSE)cat $(MOCK_CONF_DIR)/$(MOCK_REL).cfg.tmpl > $@
	$(VERBOSE)echo -e $(MOCK_YUM_CONF) >> $@
	$(VERBOSE)echo '"""' >> $@

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
	$(VERBOSE)$(RM) -r $(REPOS_DIR)
	$(VERBOSE)$(RM) $(MOCK_CONF_DIR)/$(MOCK_REL).cfg

clean:
	$(VERBOSE)for pkg in $(PACKAGES); do $(MAKE) -C $(PKG_DIR)/$$pkg $@; done
	$(RM) -r $(RPM_TMPDIR)

bare: bare-repos clean
	for pkg in $(PACKAGES); do $(MAKE) -C $(PKG_DIR)/$$pkg $@; done
	$(VERBOSE)$(RM) $(addprefix $(SRPM_OUTPUT_DIR),$(SRPMS))
	$(VERBOSE)$(RM) $(addprefix $(OUTPUT_DIR),$(RPMS))

FORCE:

.PHONY: all all-vm create-repos $(setup_all_repos) srpms rpms clean bare bare-repos $(addsuffix -rpm,$(PACKAGES)) $(addsuffix -srpm,$(PACKAGES)) $(addsuffix -nomock-rpm,$(PACKAGES)) $(addsuffix -clean,$(PACKAGES)) $(LIVECDS) $(INSTISOS) FORCE

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
