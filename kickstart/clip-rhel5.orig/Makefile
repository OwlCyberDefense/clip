# Copyright (C) 2011-2012 Tresys Technology, LLC
#
# Authors: Francisco Slavin <fslavin@tresys.com>
#          Spencer Shimko <sshimko@tresys.com>
#

# This is the version number of the RPM that will be
# generated.  Typically you bump this for delivery.
CLIP_VERSION ?= 0.1

# bump this if creating multiple releases from the same
# version (think about this... why are you doing this?)
CLIP_RELEASE ?= 1

# The name of the Vendor
VENDOR ?= Tresys Technology, LLC

CWD := $(shell pwd)
ROOT_DIR ?= $(CWD)
TMP_DIR ?= $(ROOT_DIR)/tmp
BUILD_DIR ?= $(TMP_DIR)/clip-iso-build

OUTPUT_DIR ?= $(ROOT_DIR)

LIVECD_CREATOR ?= /usr/bin/livecd-creator
IMG_NAME ?= CLIP
BUILD_DATE ?= $(shell date +%m-%d-%y)

DEBUG ?= y

ICE_DUMMY ?=
ICE_DUMMY_POLICY ?=

REPO_LINES ?= repo --name=rhel --baseurl=file:///mnt/repos/rhel/rhel-5-6-i386/rhel-i386-server-5.6.z/getPackage\nrepo --name=epel --baseurl=file:///mnt/repos/rhel/EL-5-i386-EPEL\n

all: livecd

livecd tos-livecd:
	@test -d $(BUILD_DIR) || mkdir -p $(BUILD_DIR)
	@cp --force $(CWD)/$(IMG_NAME).ks $(BUILD_DIR)/$(IMG_NAME).ks
	@cp --force $(MAYFLOWER) $(BUILD_DIR)/mayflower
	@cp --force $(LIVECD_CREATOR) $(BUILD_DIR)/livecd-creator
	@cd $(BUILD_DIR)
	@sed --in-place 's;#REPO-REPLACEMENT-PLACEHOLDER;$(REPO_LINES);' $(BUILD_DIR)/$(IMG_NAME).ks
	@echo "livecd creator needs root permissions - please enter your sudo password"
	sudo $(BUILD_DIR)/livecd-creator --skip-compress --extra-space=104857600 --config=$(BUILD_DIR)/$(IMG_NAME).ks --fslabel=$(IMG_NAME)
	@mv --force $(IMG_NAME).iso $(OUTPUT_DIR)/

clean:
	rm -rf $(BUILD_DIR)

bare: clean

.PHONY: all livecd tos-livecd clean bare
