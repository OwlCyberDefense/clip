# Copyright (C) 2012 Tresys Technology, LLC
#
# Authors: Joe Nall <joe@nall.com>
#

all:
	env HOME=`pwd` rpmbuild -bb rpmbuild/SPECS/clip-selinux-policy.spec

clean:
	rm -rf rpmbuild/{BUILD,BUILDROOT,RPMS,SRPMS} 
