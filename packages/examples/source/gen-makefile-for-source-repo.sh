#!/bin/bash -u
set -e

echo "This script attempts to automate the process of modifying a spec file to meet the build system's expectations."
echo "This script should only be used if you are taking an unofficial build, such as a git or svn checkout, and will rolling it here."
echo "The idea is that you will likely have to manage the versioning and release of the package.  So this modifies the spec file to pass vars from the Makefile into the spec files."
echo "Please make sure you have a spec file available and named <package name>.spec."
echo "Press enter to continue or ctrl-c to exit."
read
if [ $# -ne 3 ]; then
        echo "Usage: `basename $0` <pkgname> <version> <release>"
        exit 1
fi

PKGNAME=$1
VERSION=$2
RELEASE=$3

echo "Name: $PKGNAME"
echo "Version: $VERSION"
echo "Release: $RELEASE"


sed -i -e 's/^\s*Name:.*$/Name: %{pkgname}/' -e 's/^\s*Version:.*$/Version: %{version}/' -e 's/^\s*Release:.*$/Release: %{release}/' -e 's/^\s*Arch:.*$/Arch: %{arch}/' -e 's/^\s*%setup -q\s*$/%setup -q -n %{pkgname}/' $1.spec

sed -e "s;^PKGNAME :=.*;PKGNAME := $PKGNAME;" -e "s;^VERSION :=.*;VERSION := $VERSION;" -e "s;^RELEASE :=.*;RELEASE := $RELEASE;" Makefile.tmpl > Makefile
