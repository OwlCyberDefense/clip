# Copyright (C) 2013 Cubic Corporation
#
# Authors: Spencer Shimko <spencer@quarksecurity.com>
#
PREFIX ?= $(DESTDIR)/usr/share/dracut/modules.d
INSTDIR := $(PREFIX)/96clip

FILES := check install clip.sh

install: 
	test -d $(INSTDIR) || install -m 755 -d $(INSTDIR)
	install -m 755 -t $(INSTDIR) $(FILES)	
		
.PHONY: install
