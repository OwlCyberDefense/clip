#!/bin/sh
# Interupting ISO builds can leave loopback mounts in certain conditions.
# This script should be run if you run out of loop devices and have ensured no other user is currently generating ISOs.
for dir in `find /var/tmp/imgcreate* -maxdepth 0 -type d`; do
	umount "$dir/install_root/sys"
	umount "$dir/install_root/selinux"
	umount "$dir/install_root/proc"
	umount "$dir/install_root/dev/pts"
	umount "$dir/install_root/var/cache/yum"
	umount "$dir/install_root"
	loopdev=`/sbin/losetup -a|grep "$dir"|awk -F: '{ print $1; }'`
	/sbin/losetup -d $loopdev
	rm -rf "$dir"
done
