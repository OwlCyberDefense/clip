#!/bin/bash -u
set -e

if [ $# -ne 1 ]; then
	echo "Usage: `basename $0` <src rpm filename>"
	exit 1
fi

echo "Extracting information from src rpm..."
PKGNAME=`rpmquery -qp --queryformat '%{NAME}' $1 2>/dev/null`

# We've seen cases from, e.g., rpmforge, where the src.rpm ver/release
# don't match the contained package ver/release.  So extract the spec
# the spec file and get it from there.
test -d tmp || mkdir tmp
cd tmp
rm -f ${PKGNAME}.spec
( rpm2cpio ../$1 | cpio --quiet -i ${PKGNAME}.spec ) 2>&1 >/dev/null

# Spec files can roll multiple packages which results in the query 
# returning dupe versions, just go with the first.  *Hopefully* this
# is the 99& case.
VERSION=`rpm -q --specfile --queryformat '%{VERSION}\n' ${PKGNAME}.spec | head -n 1`
RELEASE=`rpm -q --specfile --queryformat '%{RELEASE}\n' ${PKGNAME}.spec | head -n 1`
ARCH=`rpm -q --specfile --queryformat '%{ARCH}\n' ${PKGNAME}.spec | head -n 1`
cd ../

rm -rf tmp

echo "Name: $PKGNAME"
echo "Version: $VERSION"
echo "Release: $RELEASE"

sed -e "s;SRC_SRPM :=.*;SRC_SRPM := \$(CURDIR)/$1;" -e "s;^PKGNAME :=.*;PKGNAME := $PKGNAME;" -e "s;^VERSION :=.*;VERSION := $VERSION;" -e "s;^RELEASE :=.*;RELEASE := $RELEASE;" Makefile.tmpl > Makefile 

if [ x"$ARCH" == "xnoarch" ]; then
	echo "Arch: $ARCH"
	sed -i -e  "s;ARCH .*;ARCH := $ARCH;" Makefile 
fi
