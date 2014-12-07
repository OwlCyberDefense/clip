#!/bin/sh

# Copyright (C) 2013 Cubic Corporation
# Copyright (C) 2014 Tresys Technology
#
# Authors: Spencer Shimko <spencer@quarksecurity.com>
# Authors: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
#
check () {
    return 0
}

install() {
    if [ -x "/usr/sbin/load_policy" -o -x "/sbin/load_policy" ]; then
        inst_hook pre-pivot 51 "$moddir/clip.sh"
    fi
}
