#!/bin/sh
echo "This script attempts to automate the process of modifying a spec file to meet the build system's expectations."
if [ x"$1" == "x" ]; then
	echo "Please pass in a spec file as an argument when running this script."
fi

echo "Press enter to continue or ctrl-c to exit."
read

sed -i -e 's/^\s*Name:.*$/Name: %{pkgname}/' -e 's/^\s*Version:.*$/Version: %{version}/' -e 's/^\s*Release:.*$/Release: %{release}/' -e 's/^\s*Arch:.*$/Arch: %{arch}/' -e 's/^\s*%setup -q\s*$/%setup -q -n %{pkgname}/' $1
