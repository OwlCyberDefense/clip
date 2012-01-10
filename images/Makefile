# Copyright (C) 2011-2012 Tresys Technology, LLC
#
# Authors: Francisco Slavin <fslavin@tresys.com>
#          Spencer Shimko <sshimko@tresys.com>
#

# The name of the Vendor
VENDOR ?= Tresys Technology, LLC

CWD := $(shell pwd)
ROOT_DIR ?= $(CWD)
TMP_DIR ?= $(ROOT_DIR)/tmp
OUTPUT_DIR ?= $(ROOT_DIR)

LIVECD_CREATOR_CLIP ?= /usr/bin/livecd-creator
BUILD_DATE ?= $(shell date +%m-%d-%y)

TMP_DIR ?= tmp

all: clip-livecd

clip-livecd:
	$(MAKE) -C $@ $@

clean:
	rm -rf $(BUILD_DIR)

bare: clean

.PHONY: all clip-livecd clean bare
