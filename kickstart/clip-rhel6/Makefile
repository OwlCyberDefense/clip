# Copyright (C) 2011-2012 Tresys Technology, LLC
#
# Authors: Francisco Slavin <fslavin@tresys.com>
#          Spencer Shimko <sshimko@tresys.com>
#

NAME := clip-rhel$(RHEL_VER)
KS := $(NAME).ks
VER := 2

# This is the version number of the RPM that will be
# generated.  Typically you bump this for delivery.
VERSION ?= 0.1

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

PUNGI_OS_DIR := $(BUILD_DIR)/$(VER)/$(shell uname -i)/os/
PUNGI_ISO_DIR := $(BUILD_DIR)/$(VER)/$(shell uname -i)/iso/

LIVECD_CREATOR ?= $(SUPPORT_DIR)/livecd-creator
PUNGI ?= $(SUPPORT_DIR)/pungi
BUILD_DATE ?= $(shell date +%m-%d-%y)

DEBUG ?= y

PUNGI_ARGS := --destdir="$(BUILD_DIR)" --ver="$(VER)" --name="$(NAME)" --nosource --force
#PUNGI_ARGS := --destdir="$(BUILD_DIR)" --ver="1" --name="clip" --nosource --force
LIVECD_ARGS := --skip-compress --extra-space=104857600 --config="$(BUILD_DIR)/$(NAME).ks" --fslabel="$(NAME)"

REPO_LINES ?= repo --name=centos --baseurl=http://mirror.centos.org/centos/6.2/os/$$basearch\nrepo --name=epel   --baseurl=http://download.fedora.redhat.com/pub/epel/$(VER)/$$basearch

DEPS := $(PUNGI) $(LIVECD_CREATOR) $(CURDIR)/Makefile $(CURDIR)/$(KS)

all: installation-iso livecd

installation-iso: $(DEPS) $(ADDTL_DEPS)
	$(VERBOSE)sudo rm -rf $(PUNGI_OS_DIR)
	$(VERBOSE)test -d $(PUNGI_OS_DIR) || mkdir -p $(PUNGI_OS_DIR)
	$(VERBOSE)cp --force $(NAME).ks $(BUILD_DIR)/$(KS)
	$(VERBOSE)sed -i -e 's;#REPO-REPLACEMENT-PLACEHOLDER;$(REPO_LINES);' $(BUILD_DIR)/$(KS)
	@echo "Gathering things with pungi..."
	sudo $(PUNGI) $(PUNGI_ARGS) -GCB -c "$(BUILD_DIR)/$(KS)"
	sed -e 's/^repo/#repo/' $(BUILD_DIR)/$(KS) > $(PUNGI_OS_DIR)/$(KS)
	@echo "Fixing the boot menu..."
	$(VERBOSE)sudo sed -i -e "s/^label linux$$/label clip/" \
	       -e "s/append initrd=initrd.img$$/append initrd=initrd.img ks=cdrom:$(KS)/" \
	       -e "s/or upgrade an existing system/$(NAME)/" \
	$(PUNGI_OS_DIR)/isolinux/isolinux.cfg
	$(VERBOSE)echo "Building ISO with pungi..."
	sudo $(PUNGI) $(PUNGI_ARGS) -I -c $(BUILD_DIR)/$(KS)
	$(VERBOSE)sudo mv --force $(PUNGI_ISO_DIR)/$(NAME)-$(VER)-x86_64.iso $(OUTPUT_DIR)/


livecd: $(DEPS) $(ADDTL_DEPS)
	@test -d $(BUILD_DIR) || mkdir -p $(BUILD_DIR)
	@cp --force $(KS) $(BUILD_DIR)/$(KS)
	@cp --force $(MAYFLOWER) $(BUILD_DIR)/mayflower
	@cp --force $(LIVECD_CREATOR) $(BUILD_DIR)/livecd-creator
	@sed -i -e 's;#REPO-REPLACEMENT-PLACEHOLDER;$(REPO_LINES);' $(BUILD_DIR)/$(KS)
	@sed -i -e 's;CDLABEL;live:CDLABEL;g' $(BUILD_DIR)/livecd-creator
	@echo "livecd creator needs root permissions - please enter your sudo password"
	sudo $(BUILD_DIR)/livecd-creator  $(LIVECD_ARGS)
	@mv --force $(NAME).iso $(OUTPUT_DIR)/

clean:
	sudo rm -rf $(BUILD_DIR)

bare: clean
	rm -rf $(TMP_DIR)

.PHONY: all livecd installation-iso clean bare
