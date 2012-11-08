# Copyright (C) 2011-2012 Tresys Technology, LLC
#
# Authors: Francisco Slavin <fslavin@tresys.com>
#          Spencer Shimko <sshimko@tresys.com>
#

RHEL_VER ?= 6
NAME := clip-rhel
KS := $(NAME)$(RHEL_VER).ks

# bump this if creating multiple releases from the same
# version (think about this... why are you doing this?)
RELEASE ?= 1

# The name of the Vendor
VENDOR ?= Tresys Technology, LLC

ROOT_DIR ?= $(CURDIR)
TMP_DIR ?= $(ROOT_DIR)/tmp
BUILD_DIR ?= $(TMP_DIR)/clip-iso-build
SUPPORT_DIR ?= $(ROOT_DIR)/support

OUTPUT_DIR ?= $(ROOT_DIR)

PUNGI_OS_DIR := $(BUILD_DIR)/$(RHEL_VER)/$(shell uname -i)/os/
PUNGI_ISO_DIR := $(BUILD_DIR)/$(RHEL_VER)/$(shell uname -i)/iso/

LIVECD_CREATOR ?= $(SUPPORT_DIR)/livecd-creator
PUNGI ?= $(SUPPORT_DIR)/pungi
BUILD_DATE ?= $(shell date +%m-%d-%y)

DEBUG ?= y

PUNGI_ARGS := --destdir="$(BUILD_DIR)" --ver="$(RHEL_VER)" --name="$(NAME)" --nosource --force
LIVECD_ARGS := --skip-compress --extra-space=104857600 --config="$(BUILD_DIR)/$(NAME).ks" --fslabel="$(NAME)"

# This is only useful for building out of this subdir.  The top-level Makefile passes this variable down
# pointing to the yum repos CLIP creates and manages in repos/*.  What this means is that you should
# probably just ignore this.
REPO_LINES ?= repo --name=centos --baseurl=http://mirror.centos.org/centos/6.2/os/$$basearch\nrepo --name=epel   --baseurl=http://download.fedora.redhat.com/pub/epel/$(RHEL_VER)/$$basearch

DEPS := $(PUNGI) $(LIVECD_CREATOR) $(CURDIR)/Makefile $(CURDIR)/$(KS)

all: installation-iso livecd

installation-iso: $(DEPS) $(ADDTL_DEPS)
	$(VERBOSE)sudo rm -rf $(PUNGI_OS_DIR)
	$(VERBOSE)test -d $(PUNGI_OS_DIR) || mkdir -p $(PUNGI_OS_DIR)
	$(VERBOSE)cp --force $(CURDIR)/$(KS) $(BUILD_DIR)/$(KS)
	$(VERBOSE)sed -i -e 's;#REPO-REPLACEMENT-PLACEHOLDER;$(REPO_LINES);' $(BUILD_DIR)/$(KS)
	$(VERBOSE)sed -i -e 's;#CONFIG-BUILD-PLACEHOLDER;$(CONFIG_BUILD_BASH_VARS);' $(BUILD_DIR)/$(KS) || true
	@echo "Gathering things with pungi..."
	@echo "Pungi needs root permissions - please enter your sudo password if prompted."
	@# Don't remove the "cd $(BUILD_DIR)" below b/c a bug in pungi ends up creating empty dirs in curdir.  This avoids confusion.
	$(VERBOSE)cd $(BUILD_DIR); sudo $(PUNGI) $(PUNGI_ARGS) -GCB -c "$(BUILD_DIR)/$(KS)"
	$(VERBOSE)sed -e 's/^repo/#repo/' $(BUILD_DIR)/$(KS) > $(PUNGI_OS_DIR)/$(KS)
	@echo "Fixing the boot menu..."
	$(VERBOSE)sudo sed -i -e "s/^label linux$$/label clip/" \
	       -e "s/append initrd=initrd.img$$/append initrd=initrd.img ks=cdrom:$(KS)/" \
	       -e "s/or upgrade an existing system/$(NAME)/" \
	$(PUNGI_OS_DIR)/isolinux/isolinux.cfg
	@echo "Building ISO with pungi..."
	@echo "Pungi needs root permissions - please enter your sudo password if prompted."
	@# Don't remove the "cd $(BUILD_DIR)" below b/c a bug in pungi ends up creating empty dirs in curdir.  This avoids confusion.
	$(VERBOSE)cd $(BUILD_DIR);sudo $(PUNGI) $(PUNGI_ARGS) -I -c $(BUILD_DIR)/$(KS)
	$(VERBOSE)sudo mv --force $(PUNGI_ISO_DIR)/$(NAME)-$(RHEL_VER)-x86_64.iso $(OUTPUT_DIR)/


livecd: $(DEPS) $(ADDTL_DEPS)
	$(VERBOSE)test -d $(BUILD_DIR) || mkdir -p $(BUILD_DIR)
	$(VERBOSE)cp --force $(KS) $(BUILD_DIR)/$(KS)
	$(VERBOSE)cp --force $(MAYFLOWER) $(BUILD_DIR)/mayflower
	$(VERBOSE)cp --force $(LIVECD_CREATOR) $(BUILD_DIR)/livecd-creator
	$(VERBOSE)sed -i -e 's;#REPO-REPLACEMENT-PLACEHOLDER;$(REPO_LINES);' $(BUILD_DIR)/$(KS)
	$(VERBOSE)sed -i -e 's;#CONFIG-BUILD-PLACEHOLDER;$(CONFIG_BUILD_BASH_VARS);' $(BUILD_DIR)/$(KS) || true
	$(VERBOSE)sed -i -e 's;CDLABEL;live:CDLABEL;g' $(BUILD_DIR)/livecd-creator
	@echo "Live CD Creator needs root permissions - please enter your sudo password if prompted."
	$(VERBOSE)sudo $(BUILD_DIR)/livecd-creator  $(LIVECD_ARGS)
	$(VERBOSE)mv --force $(NAME).iso $(OUTPUT_DIR)/

clean:
	sudo rm -rf $(BUILD_DIR)

bare: clean
	rm -rf $(TMP_DIR)

.PHONY: all livecd installation-iso clean bare
