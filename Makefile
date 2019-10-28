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

CLIP_RELEASE := "7.5"

######################################################
# BEGIN MAGIC
ifneq ($(QUIET),y)
$(info Boot strapping build system...)
endif

# NOTE: DO NOT REMOVE THIS CHECK. RUNNING MOCK AS ROOT *WILL* BREAK THINGS.
ifeq ($(shell id -u),0)
$(error Never CLIP as root! It will break things!  Try again as an unprivileged user with sudo access.)
endif

HOST_RPM_DEPS := rpm-build createrepo mock repoview

export ROOT_DIR ?= $(CURDIR)
export OUTPUT_DIR ?= $(ROOT_DIR)
export RPM_TMPDIR ?= $(ROOT_DIR)/tmp
export CONF_DIR ?= $(ROOT_DIR)/conf
export MOCK_DIR ?= $(RPM_TMPDIR)/mockbuild

# Config deps
CONFIG_BUILD_DEPS = $(ROOT_DIR)/CONFIG_BUILD $(ROOT_DIR)/CONFIG_REPOS $(ROOT_DIR)/Makefile $(CONF_DIR)/pkglist.blacklist

# MOCK_REL_INSTANCE must be configured in MOCK_CONF_DIR/MOCK_REL_INSTANCE.cfg
MOCK_REL := rhel-$(RHEL_VER)-$(TARGET_ARCH)

# This directory contains all of our packages we will be building.
PKG_DIR += $(CURDIR)/packages
# List of packages not to build in the packages directory
EXCLUDE_PKGS := examples webpageexample 
PACKAGES := $(shell ls $(PKG_DIR))
PACKAGES := $(filter-out $(EXCLUDE_PKGS),$(PACKAGES))

# This is the directory that will contain all of our yum repos.
REPO_DIR := $(CURDIR)/repos

# This directory is used by repoquery and yum to cache a repository's repomd.xml.  The cachedir setting in yum.conf is ignored for a non-root user.
YUM_TMP := $(REPO_DIR)/yumtmp

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

export MAYFLOWER := $(SUPPORT_DIR)/mayflower
export PUNGI := $(SUPPORT_DIR)/pungi
export LORAX_TEMPLATES := $(SUPPORT_DIR)/lorax

SED := /bin/sed
GREP := /bin/egrep
MOCK := /usr/bin/mock
REPO_LINK := /bin/ln -s
REPO_WGET := /usr/bin/wget
REPO_CREATE := /usr/bin/createrepo -d --workers $(shell /usr/bin/nproc) -c $(REPO_DIR)/yumcache
REPO_QUERY :=  repoquery -c $(YUM_CONF_FILE) --quiet -a --queryformat '%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}.rpm'
MOCK_ARGS += --resultdir=$(CLIP_REPO_DIR) -r $(MOCK_CONF_DIR)/$(MOCK_REL_INSTANCE).cfg --configdir=$(MOCK_CONF_DIR) --unpriv --rebuild
ifeq ($(CLEAN_MOCK),n)
    MOCK_ARGS += --no-clean --no-cleanup-after
endif

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
CHECK_REPO = $(VERBOSE)test -d $(1)/repodata || $(REPO_CREATE) $(1)

SYSTEMS := $(shell ls $(KICKSTART_DIR))

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

######################################################
# BEGIN RPM GENERATION RULES (BEWARE OF DRAGONS)
# This define directive is used to generate build rules.
define RPM_RULE_template
$(1): $(SRPM_OUTPUT_DIR)/$(call SRPM_FROM_RPM,$(notdir $(1))) $(MY_REPO_DEPS) $(MOCK_CONF_DIR)/$(MOCK_REL_INSTANCE).cfg
	$(call CHECK_DEPS)
	$(call MKDIR,$(CLIP_REPO_DIR))
	$(call CHECK_REPO,$(CLIP_REPO_DIR))
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
GET_REPO_KEY_INFO = $(shell if [ -e $(CONF_DIR)/$(1) ]; then echo "gpgkey=file://$(CONF_DIR)/$(1)\\\ngpgcheck=1"; fi)

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
$(eval REPO_KEY := $(call GET_REPO_KEY_INFO,RPM-GPG-KEY-$(REPO_ID)-$(RHEL_VER)))
$(eval setup_all_repos += setup-$(REPO_ID)-repo)

$(eval YUM_CONF += \\n[$(REPO_ID)]\\nname=$(REPO_ID)\\nbaseurl=file://$(REPO_PATH)\\nenabled=1\\n\\nexclude=$(strip $(PKG_BLACKLIST))\\n)
$(eval MOCK_YUM_CONF := $(MOCK_YUM_CONF)[$(REPO_ID)]\\nname=$(REPO_ID)\\nbaseurl=$(REPO_URL)\\nenabled=1\\n$(REPO_KEY)\\n\\nexclude=$(strip $(PKG_BLACKLIST))\\n)
$(eval MY_REPO_DEPS += $(REPO_DIR)/$(REPO_ID)-repo/last-updated)
$(eval REPO_LINES := $(REPO_LINES)repo --name=$(REPO_ID) --baseurl=file://$(REPO_DIR)/$(REPO_ID)-repo\n)

$(eval CLIP_REPO_DIRS += "$(REPO_DIR)/$(REPO_ID)-repo")
$(eval PKG_LISTS += "./$(shell basename $(CONF_DIR))/pkglist.$(REPO_ID)")
$(eval P_ARG_REPO += "$(REPO_PATH),$(CONF_DIR)/pkglist.$(REPO_ID)")

$$(eval $$(call better_shell,$(call MKDIR,$(RPM_TMPDIR))))

setup-$(REPO_ID)-repo:  $(REPO_DIR)/$(REPO_ID)-repo/last-updated

# This is the key target for managing yum repos.  If the pkg list for the repo
# is more recent then our private repo regen the repo by symlink'ing the packages into our repo.
$(REPO_DIR)/$(REPO_ID)-repo/last-updated: $(CONF_DIR)/pkglist.$(REPO_ID) $(filter-out $(ROOT_DIR)/CONFIG_BUILD,$(CONFIG_BUILD_DEPS))
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
$(CONF_DIR)/pkglist.$(REPO_ID) ./$(shell basename $(CONF_DIR))/pkglist.$(REPO_ID):
	$(VERBOSE)$(RM) $(YUM_CONF_FILE)
	$(VERBOSE)$(RM) $(MOCK_CONF_DIR)/$(MOCK_REL).cfg
	@echo "Generating list of packages for $(call GET_REPO_ID,$(1))"
	$(VERBOSE)cat $(YUM_CONF_FILE).tmpl > $(YUM_CONF_FILE)
	echo -e $(YUM_CONF) >> $(YUM_CONF_FILE)
	$(VERBOSE)$(REPO_QUERY) --repoid=$(REPO_ID) |sort 1>$(CONF_DIR)/pkglist.$(REPO_ID)

endif
endef

define newline


endef

define error_ifneq
ifneq ($(1),$(2))
$$(error $(3))
endif
endef

define better_shell
$(eval $(subst #N#,$(newline),$(shell OUTPUT="`$(1) 2>&1`"; RC=$$?; ( echo "define output"; echo "$${OUTPUT}"; echo "endef"; echo "rc := $${RC}" ) | awk 1 ORS="#N#")))
$(call info_quiet,command: $(1))
$(call info_quiet,output: $$(output))
$(call error_ifneq,$(rc),0,Command $(1) returned error code $(rc))
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
	@echo "To do a release of CLIP:"
	@echo "	release"
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

define ADD_IF_MISSING
ifeq ($(shell if [ -e $(2) ]; then echo $(2); fi),)
$(1) += $(2)
endif
endef

P_ARG_SPEC := $(foreach SPEC,$(foreach PKG,$(PACKAGES),$(shell find $(PKG_DIR)/$(PKG) -iname '$(PKG)*.spec')),-s $(SPEC))
P_ARG_KS := $(foreach SYSTEM,$(SYSTEMS),-k $(KICKSTART_DIR)/$(SYSTEM)/$(SYSTEM).ks)
P_ARG_LORAX := $(foreach TMPL,$(shell find $(LORAX_TEMPLATES) -iname '*.tmpl*'),-l $(TMPL))
P_ARG_REQ := $(foreach REQ,$(shell sed -n "s/.*install \([^']*\).*/\1/p" $(MOCK_CONF_DIR)/$(MOCK_REL).cfg.tmpl),-r $(REQ))

P_ARGS := add -c $(YUM_CONF_FILE) $(P_ARG_KS) $(P_ARG_SPEC) $(P_ARG_REQ) $(P_ARG_REPO) $(P_ARG_LORAX)

# create pkglist files if they are missing 
# PKG_LISTS is populated in the calls to REPO_RULE_template above
# which is why this 
MISSING_PKGLIST =
$(foreach PKGLIST,$(PKG_LISTS),$(eval $(call ADD_IF_MISSING,MISSING_PKGLIST,$(PKGLIST))))
ifneq ($(MISSING_PKGLIST),)
$(shell $(RM) $(YUM_CONF_FILE))
$(shell cat $(YUM_CONF_FILE).tmpl > $(YUM_CONF_FILE))
$(shell echo -e $(YUM_CONF) >> $(YUM_CONF_FILE))
$(shell rm -rf "$(YUM_TMP)")
$(shell mkdir -p "$(YUM_TMP)")
$(info generating missing pkglist file(s): $(MISSING_PKGLIST))
$(eval $(call better_shell,TMPDIR="$(YUM_TMP)" ./support/manage_pkglist.py $(P_ARGS)))

# make sure all pkglist files were actually created
MISSING_PKGLIST =
$(foreach PKGLIST,$(PKG_LISTS),$(eval $(call ADD_IF_MISSING,MISSING_PKGLIST,$(PKGLIST))))
ifneq ($(MISSING_PKGLIST),)
$(error The following pkglist files were not generated as expected: $(MISSING_PKGLIST))
endif
else
$(info all pkglist files exist)
endif



# generate a hash from all pkglist files which will be used to provide a yum
# repository to mock which is individualized based on the pkglist contents
ifneq ($(PKG_LISTS),)
PKG_LIST_HASH = $(strip $(shell cat $(sort $(PKG_LISTS)) | md5sum | cut -f1 -d' '))
PREV_PKG_LIST_HASH = $(strip $(shell cat conf/pkglist_hash))
MOCK_REL_INSTANCE = $(shell whoami | cut -f1 -d' ')-$(notdir $(abspath $(ROOT_DIR)))-$(PKG_LIST_HASH)
ifneq ($(PKG_LIST_HASH),$(PREV_PKG_LIST_HASH))
$(info Updating conf/pkglist_hash)
$(shell echo $(PKG_LIST_HASH) > conf/pkglist_hash)
else
$(info conf/pkglist_hash up to date)
endif
else
$(error no pkglists/repos)
endif

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

$(INSTISOS):  $(BUILD_CONF_DEPS) create-repos $(RPMS)
	$(eval SYSTEM_NAME=$(shell echo '$(@)'|$(SED) -e 's/\(.*\)-iso/\1/'))
	$(call CHECK_DEPS)
	$(MAKE) SYSTEM_NAME=$(SYSTEM_NAME) -C $(KICKSTART_DIR)/$(SYSTEM_NAME) iso

$(MOCK_CONF_DIR)/$(MOCK_REL_INSTANCE).cfg:  $(MOCK_CONF_DIR)/$(MOCK_REL).cfg.tmpl $(CONF_DIR)/pkglist.blacklist conf/pkglist_hash $(filter-out $(ROOT_DIR)/CONFIG_BUILD,$(CONFIG_BUILD_DEPS))
	$(call CHECK_DEPS)
	$(VERBOSE)cat $(MOCK_CONF_DIR)/$(MOCK_REL).cfg.tmpl > $@
	$(VERBOSE)echo -e $(MOCK_YUM_CONF) >> $@
	$(VERBOSE)sed -i '2i config_opts["basedir"] = "$(MOCK_DIR)"' $@
	$(VERBOSE)sed -i '2i config_opts["cache_topdir"] = "$(MOCK_DIR)/cache"' $@
	$(VERBOSE)sed -i '2i config_opts["root"] = "$(MOCK_REL_INSTANCE)"' $@
	$(VERBOSE)sed -i '2i config_opts["rootdir"] = "$(MOCK_DIR)/$(MOCK_REL_INSTANCE)"' $@
	$(VERBOSE)echo -e "[clip-repo]\\nname=clip-repo\\nbaseurl=file://$(CLIP_REPO_DIR)/\\nenabled=1\\ngpgcheck=0\\nexclude=$(strip $(PKG_BLACKLIST))\\n" >> $@
	$(VERBOSE)echo '"""' >> $@

ifneq ($(OVERLAY_HOME_SIZE),)
OVERLAYS += --home-size-mb $(OVERLAY_HOME_SIZE)
endif
ifneq ($(OVERLAY_SIZE),)
OVERLAYS += --overlay-size-mb $(OVERLAY_SIZE)
endif

clean-mock: $(ROOT_DIR)/CONFIG_REPOS $(ROOT_DIR)/Makefile $(CONF_DIR)/pkglist.blacklist
	$(VERBOSE)$(RM) $(YUM_CONF_FILE)
	$(VERBOSE)$(RM) $(MOCK_CONF_DIR)/$(MOCK_REL_INSTANCE).cfg
	$(VERBOSE)$(RM) -rf $(REPO_DIR)/yumcache

bare-repos: clean-mock
	$(VERBOSE)$(RM) -r $(CLIP_REPO_DIRS) $(CLIP_REPO_DIR)
	$(VERBOSE)sudo $(RM) -r $(MOCK_DIR)

clean:
	@sudo $(RM) -rf $(RPM_TMPDIR)
	@sudo $(RM) -rf $(SRPM_OUTPUT_DIR)
	@$(VERBOSE)for pkg in $(PACKAGES); do $(MAKE) -C $(PKG_DIR)/$$pkg $@; done

bare: bare-repos clean
	for pkg in $(PACKAGES); do $(MAKE) -C $(PKG_DIR)/$$pkg $@; done
	$(VERBOSE)$(RM) $(addprefix $(SRPM_OUTPUT_DIR),$(SRPMS))
	$(VERBOSE)$(RM) $(addprefix $(OUTPUT_DIR),$(RPMS))
	$(VERBOSE)$(RM) *.iso

release:
	git tag -a -m "CLIP for RHEL $(CLIP_RELEASE)" CLIP_RHEL_$(CLIP_RELEASE)
	git push origin CLIP_RHEL_$(CLIP_RELEASE)

FORCE:

# Unfortunately mock isn't exactly "parallel" friendly which sucks since we could roll a bunch of packages in parallel.
.NOTPARALLEL:

.PHONY:  all all-vm create-repos $(setup_all_repos) srpms rpms clean bare bare-repos $(addsuffix -rpm,$(PACKAGES)) $(addsuffix -srpm,$(PACKAGES)) $(addsuffix -nomock-rpm,$(PACKAGES)) $(addsuffix -clean,$(PACKAGES)) $(LIVECDS) $(INSTISOS) FORCE clean-mock release


# END RULES
######################################################

