# Copyright (C) 2011-2012 Tresys Technology, LLC
#
# Authors: Francisco Slavin <fslavin@tresys.com>
#          Spencer Shimko <sshimko@tresys.com>
#

NAME := clip-rhel6
KS := $(NAME).ks

# This is the version number of the RPM that will be
# generated.  Typically you bump this for delivery.
CLIP_VERSION ?= 0.1

# bump this if creating multiple releases from the same
# version (think about this... why are you doing this?)
CLIP_RELEASE ?= 1

# The name of the Vendor
VENDOR ?= Tresys Technology, LLC

ROOT_DIR ?= $(CURDIR)
TMP_DIR ?= $(ROOT_DIR)/tmp
BUILD_DIR ?= $(TMP_DIR)/clip-iso-build

OUTPUT_DIR ?= $(ROOT_DIR)

OS_DIR := $(BUILD_DIR)/$(CLIP_VERSION)/$(shell uname -i)/os/

LIVECD_CREATOR ?= /usr/bin/livecd-creator
PUNGI ?= /usr/bin/pungi
BUILD_DATE ?= $(shell date +%m-%d-%y)

DEBUG ?= y

PUNGI_ARGS := --destdir="$(BUILD_DIR)" --ver="$(CLIP_VERSION)" --name="$(NAME)" --nosource --force
LIVECD_ARGS := --skip-compress --extra-space=104857600 --config="$(BUILD_DIR)/$(NAME).ks" --fslabel="$(NAME)"

REPO_LINES ?= repo --name=rhel --baseurl=file:///mnt/repos/rhel/rhel-5-6-i386/rhel-i386-server-5.6.z/getPackage\nrepo --name=epel --baseurl=file:///mnt/repos/rhel/EL-5-i386-EPEL\n

all: installation-iso

installation-iso:
	sudo rm -rf $(BUILD_DIR)/*
	echo "Gather things with pungi..."
	sudo $(PUNGI) $(PUNGI_ARGS) -GCB -c "$(KS)"
	@echo "Generating modified kickstart..."
	sudo sh -c "sed -e 's/^repo/#repo/' '$(KS)' > '$(OS_DIR)/$(KS)'"
	@echo "Fixing the boot menu..."
	sudo sed -i -e "s/^label linux$$/label $(NAME)/" \
	       -e "s/append initrd=initrd.img$$/append initrd=initrd.img ks=cdrom:$(KS)/" \
	       -e "s/or upgrade an existing system/$(NAME)/" \
	$(OS_DIR)/isolinux/isolinux.cfg
	@echo "Building ISO with pongi..."
	sudo $(PUNGI) $(PUNGI_ARGS) -I -c $(KS)


livecd:
	@test -d $(BUILD_DIR) || mkdir -p $(BUILD_DIR)
	@cp --force $()/$(NAME).ks $(BUILD_DIR)/$(NAME).ks
	@cp --force $(MAYFLOWER) $(BUILD_DIR)/mayflower
	@cp --force $(LIVECD_CREATOR) $(BUILD_DIR)/livecd-creator
	@cd $(BUILD_DIR)
	@sed --in-place 's;#REPO-REPLACEMENT-PLACEHOLDER;$(REPO_LINES);' $(BUILD_DIR)/$(NAME).ks
	@echo "livecd creator needs root permissions - please enter your sudo password"
	sudo $(BUILD_DIR)/livecd-creator  $(LIVECD_ARGS)
	@mv --force $(NAME).iso $(OUTPUT_DIR)/

clean:
	rm -rf $(BUILD_DIR)

bare: clean
	rm -rf $(TMP_DIR)

.PHONY: all livecd tos-livecd clean bare
