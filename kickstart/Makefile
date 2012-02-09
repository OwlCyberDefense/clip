# Copyright (C) 2011-2012 Tresys Technology, LLC
#
# Authors: Francisco Slavin <fslavin@tresys.com>
#          Spencer Shimko <sshimko@tresys.com>
#

# The name of the Vendor
VENDOR ?= Tresys Technology, LLC

ROOT_DIR ?= $(CURDIR)
TMP_DIR ?= $(ROOT_DIR)/tmp
OUTPUT_DIR ?= $(ROOT_DIR)

LIVECD_CREATOR_CLIP ?= /usr/bin/livecd-creator
BUILD_DATE ?= $(shell date +%m-%d-%y)

TMP_DIR ?= tmp

all: clip-rhel5-livecd clip-rhel6-livecd clip-rhel5 clip-rhel6

clip-rhel5-livecd clip-rhel6-livecd:
	$(MAKE) -C $@ $@

clean:
	rm -rf $(BUILD_DIR)

bare: clean

.PHONY: all clip-rhel5-livecd clip-rhel6-livecd clip-rhel5 clip-rhel6 clean bare
