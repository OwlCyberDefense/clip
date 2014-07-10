#!/bin/sh
# Copyright (C) 2013 Cubic Corporation
# Copyright (C) 2014 Quark Security, Inc
#
# Authors: Spencer Shimko <spencer@quarksecurity.com>
#

# Generated live media appears to retain the .autorelabel file
# cuains g relabel on each and every boot when stateless.
# Remove it here for those environments.
getarg "liveimg" > /dev/null
[ $? -eq 0 ] && { [ -f "$NEWROOT"/.autorelabel ] && rm "$NEWROOT"/.autorelabel; }

# If SELinux is disabled exit now
getarg "selinux=0" > /dev/null && return 0

# If we are booting after a rescue mode boot "/" is mnt_t.
# This is less than ideal, but it happens all too aften not to try to address it somewhat.
ls -Zd /sysroot | grep -q root_t || /sysroot/usr/bin/chcon -t root_t /sysroot


getarg "liveimg" > /dev/null
if [ $? -eq 0 ]; then
	# TODO: something about live media environments necessitated this.  Unforunately 
	# it has been a year and I have forgot what the problem actually is.  But IIRC
	# it was livecd creator looking at the enforcing mode in the ks and ignoring
	# it elsewhere and we got "stuck" in either or state.
	SELINUX="enforcing"
	[ -e "$NEWROOT/etc/selinux/config" ] && . "$NEWROOT/etc/selinux/config"

	getarg "enforcing=0" > /dev/null
	# If both the cmdline and SELinux config file agree that the system should be 
	# in enforcing mode, do it.
	if [ $? -eq 1 -a "$SELINUX" = "enforcing" ]; then
		echo 1 > "$NEWROOT"/selinux/enforce
	fi
fi
