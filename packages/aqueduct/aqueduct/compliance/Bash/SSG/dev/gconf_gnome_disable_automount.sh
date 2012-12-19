#!/bin/bash -u
set -e

# 
# Copyright (c) 2012 Tresys Technology LLC, Columbia, Maryland, USA
#
# This software was developed by Tresys Technology LLC
# with U.S. Government sponsorship.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CONFIG_FILE=/etc/gconf/gconf.xml.mandatory

[ -f /usr/bin/gconftool-2 ] || exit 1
[ -f $CONFIG_FILE ] || exit 1

# Disable automount
/usr/bin/gconftool-2 --direct \
        --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
        --type bool \
        --set /apps/nautilus/preferences/media_automount false && exit 1

# Disable autorun
/usr/bin/gconftool-2 --direct \
        --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
        --type bool \
        --set /apps/nautilus/preferences/media_autorun_never true && exit 1

# Verify automount disabled
/usr/bin/gconftool-2 --direct \
        --config-source xml:read:/etc/gconf/gconf.xml.mandatory \
        --get /apps/nautilus/preferences/media_automount && exit 1

# Verify autorun disabled
/usr/bin/gconftool-2 --direct \
        --config-source xml:read:/etc/gconf/gconf.xml.mandatory \
        --get /apps/nautilus/preferences/media_autorun_never && exit 1
