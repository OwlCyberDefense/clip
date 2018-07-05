# Copyright (C) 2018 Tresys Technology, LLC
#
# Authors: Dave Sugar <dsugar@tresys.com>
#

CWD := $(shell pwd)

####################################################
## things below this line should rarely change
ROOT_DIR ?= $(CWD)
OUTPUT_DIR ?= $(ROOT_DIR)

# exhaustive list of deps for the RPM, used to determine if RPM needs to be rebuilt
PRODUCT_DEPS := Makefile $(wildcard installclass/*)

P_TMPDIR ?= $(ROOT_DIR)/tmp/product_img
ANACONDA_DIR ?= $(P_TMPDIR)/
INSTALL_CLASSES_DIR ?= $(P_TMPDIR)/run/install/product/pyanaconda/installclasses/

MKDIR = test -d $(1) || mkdir -p $(1)

define custom-prep
	$(call MKDIR,$(ANACONDA_DIR)/pixmaps/)
	$(call MKDIR,$(ANACONDA_DIR)/pixmaps/rnotes/en/)
	$(call MKDIR,$(ANACONDA_DIR)/addons/)
	$(call MKDIR,$(INSTALL_CLASSES_DIR))
endef

all: product.img

product.img: $(PRODUCT_DEPS)
	$(call custom-prep)
	cp installclass/* $(INSTALL_CLASSES_DIR)
	cd $(P_TMPDIR) && /usr/bin/find . | /usr/bin/cpio -c -o | /usr/bin/gzip -9cv > $@

clean:
	$(RM) -r $(P_TMPDIR)

bare: clean
	$(RM) product.img

.PHONY: all clean bare
