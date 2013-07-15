#!/bin/sh
mount $1 /mnt -o loop || exit 1
mount /mnt/LiveOS/squashfs.img /media -o loop || exit 1
mount -o loop /media/LiveOS/ext3fs.img /srv || exit 1
