#!/bin/sh
# Copyright (C) 2013 Cubic Corporation
#
# Authors: Spencer Shimko <spencer@quarksecurity.com>
#
rm "$NEWROOT"/.autorelabel

# If SELinux is disabled exit now
getarg "selinux=0" > /dev/null && return 0

SELINUX="enforcing"
[ -e "$NEWROOT/etc/selinux/config" ] && . "$NEWROOT/etc/selinux/config"

getarg "enforcing=0" > /dev/null
if [ $? -eq 1 -o "$SELINUX" = "enforcing" ]; then
	echo 1 > "$NEWROOT"/selinux/enforce
fi
