#!/bin/bash -u
set -e

if [ $# -ne 1 ]; then
	echo "Usage: `basename $0` <src rpm filename>"
	exit 1
fi
echo "Extracting information from src rpm..."
PKGNAME=`rpmquery -qp --queryformat '%{NAME}' $1`
VERSION=`rpmquery -qp --queryformat '%{VERSION}' $1`
RELEASE=`rpmquery -qp --queryformat '%{RELEASE}' $1`

echo "Name: $PKGNAME"
echo "Version: $VERSION"
echo "Release: $RELEASE"

sed -e "s;SRPM :=.*;SRPM := $1;" -e "s;^PKGNAME :=.*;PKGNAME := $PKGNAME;" -e "s;^VERSION :=.*;VERSION := $VERSION;" -e "s;^RELEASE :=.*;RELEASE := $RELEASE;" Makefile.tmpl > Makefile 
