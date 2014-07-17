# Copyright (C) 2011-2012 Tresys Technology, LLC
# Copyright (C) 2014 Quark Security, Inc
#
# Authors: Francisco Slavin <fslavin@tresys.com>
#          Spencer Shimko <sshimko@tresys.com>
#          Spencer Shimko <spencer@quarksecurity.com>
#

NAME := $(shell basename $(CURDIR))
KS := $(CURDIR)/$(NAME).ks

TARGET_ARCH ?= $(shell uname -i)

ISO_VERSION ?= 1

ROOT_DIR ?= $(CURDIR)
TMP_DIR ?= $(ROOT_DIR)/tmp
BUILD_DIR ?= $(TMP_DIR)/clip-iso-build
SUPPORT_DIR ?= $(ROOT_DIR)/support

OUTPUT_DIR ?= $(ROOT_DIR)

INST_KS := $(BUILD_DIR)/$(NAME)-inst.ks
LIVE_KS := $(BUILD_DIR)/$(NAME)-live.ks

PUNGI_OS_DIR := $(BUILD_DIR)/$(ISO_VERSION)/$(TARGET_ARCH)/os/
PUNGI_ISO_DIR := $(BUILD_DIR)/$(ISO_VERSION)/$(TARGET_ARCH)/iso/

PUNGI ?= $(SUPPORT_DIR)/pungi
PUNGI_ARGS := --destdir="$(BUILD_DIR)" --ver="$(ISO_VERSION)" --name="$(NAME)" --nosource --force

LIVECD_CREATOR ?= /usr/bin/livecd-creator
override LIVECD_ARGS := $(LIVECD_ARGS)

DEBUG ?= y

# These variables are usually passed in from CONFIG_BUILD to the top level Makefile.
# This will only be set here if we are running setup-ks by hand.
CONFIG_BUILD_BASH_VARS ?= export CONFIG_BUILD_PRODUCTION=n CONFIG_BUILD_ENFORCING_MODE=y CONFIG_BUILD_UNCONFINED_TOOR=y CONFIG_BUILD_SECSTATE_REMEDIATE=y ISO_VERSION=debug

# The differences vetween live and installable are addressed via these vars
LIVE_CONFIG_BUILD_BASH_VARS := $(CONFIG_BUILD_BASH_VARS) CONFIG_BUILD_LIVE_MEDIA=y
LIVE_CONFIG_BUILD_ADDTL_PACKAGES += $(CONFIG_BUILD_ADDTL_PACKAGES) eject

# This is only useful for building out of this subdir.  The top-level Makefile passes this variable down
# pointing to the yum repos CLIP creates and manages in repos/*.  What this means is that you should
# probably just ignore this.
REPO_LINES ?= repo --name=centos --baseurl=http://mirror.centos.org/centos/6.2/os/$$basearch\nrepo --name=epel   --baseurl=http://download.fedora.redhat.com/pub/epel/$(RHEL_VER)/$$basearch

DEPS := $(PUNGI)
SETUP_DEeS := $(CURDIR)/Makefile $(KS)

all: iso live-iso setup-ks

iso: $(DEPS) $(ADDTL_DEPS) setup-inst-ks
	@echo "Gathering things with pungi..."
	@echo "Pungi needs root permissions - please enter your sudo password if prompted."
	$(VERBOSE)cd $(BUILD_DIR); sudo $(PUNGI) $(PUNGI_ARGS) -GCB -c "$(INST_KS)"
	@echo "Fixing the boot menu..."
	$(VERBOSE)sudo sed -i -e "s/^label linux$$/label $(NAME)/" \
	       -e "s/append initrd=initrd.img$$/append initrd=initrd.img ks=cdrom:$(notdir $(INST_KS))/" \
	       -e "s/or upgrade an existing system/$(NAME)/" \
	$(PUNGI_OS_DIR)/isolinux/isolinux.cfg
	@echo "Building ISO with pungi..."
	@echo "Pungi needs root permissions - please enter your sudo password if prompted."
	$(VERBOSE)cd $(BUILD_DIR);sudo $(PUNGI) $(PUNGI_ARGS) -I -c $(INST_KS)
	$(VERBOSE)sudo mv --force $(PUNGI_ISO_DIR)/$(NAME)-$(ISO_VERSION)-*.iso $(OUTPUT_DIR)/

live-iso: $(DEPS) $(ADDTL_DEPS) setup-live-ks
	@echo "Live CD Creator needs root permissions - please enter your sudo password if prompted."
	$(VERBOSE)cd $(BUILD_DIR);sudo $(LIVECD_CREATOR)  $(LIVECD_ARGS) --config="$(LIVE_KS)"
	$(VERBOSE)mv --force $(BUILD_DIR)/livecd-*.iso $(OUTPUT_DIR)/$(NAME)-$(ISO_VERSION)-live.iso


setup-inst-ks: $(SETUP_DEPS)
	$(VERBOSE)test -d $(BUILD_DIR) || mkdir -p $(BUILD_DIR)
	$(VERBOSE)test -d $(PUNGI_OS_DIR) || mkdir -p $(PUNGI_OS_DIR)
	$(VERBOSE)cp --force $(KS) $(INST_KS)
	@echo "Modifying kickstart with build variables..."
	$(VERBOSE)sed -i -e 's;#REPO-REPLACEMENT-PLACEHOLDER;$(REPO_LINES);' $(INST_KS)
	$(VERBOSE)sed -i -e 's;#CONFIG-BUILD-PLACEHOLDER;$(CONFIG_BUILD_BASH_VARS);' $(INST_KS)
	$(VERBOSE)sed -i -e 's;#CONFIG-BUILD-ADDTL-PACKAGES;$(CONFIG_BUILD_ADDTL_PACKAGES);' $(INST_KS)
	$(VERBOSE)sed -e 's/^repo/#repo/' $(INST_KS) > $(PUNGI_OS_DIR)/$(notdir $(INST_KS))

setup-live-ks: $(SETUP_DEPS)
	$(VERBOSE)test -d $(BUILD_DIR) || mkdir -p $(BUILD_DIR)
	$(VERBOSE)cp --force $(KS) $(LIVE_KS)
	@echo "Modifying kickstart with build variables..."
	$(VERBOSE)sed -i -e 's;#REPO-REPLACEMENT-PLACEHOLDER;$(REPO_LINES);' $(LIVE_KS)
	$(VERBOSE)sed -i -e 's;#CONFIG-BUILD-PLACEHOLDER;$(LIVE_CONFIG_BUILD_BASH_VARS);' $(LIVE_KS)
	$(VERBOSE)sed -i -e 's;#CONFIG-BUILD-ADDTL-PACKAGES;$(LIVE_CONFIG_BUILD_ADDTL_PACKAGES);' $(LIVE_KS)

clean:
	$(VERBOSE)sudo rm -rf $(BUILD_DIR)

VEbare: clean
	rm -rf $(TMP_DIR)

.PHONY: all live-iso iso clean bare setup-ks
