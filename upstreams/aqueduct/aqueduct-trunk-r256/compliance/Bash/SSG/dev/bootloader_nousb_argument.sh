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

# bootloader_nousb_argument
# 
BACKUP=/etc/grub.conf_backup
FILE=/grub_test/etc/grub.conf
version=$( uname -r )

LINE="kernel(\s)+\/vmlinuz-${version}\s+ro\s+vga\=ext\s+root"
LINE+="\=\/dev\/VolGroup00\/LogVol00\s+rhgb\s+quiet"

#grep -P "^(\s*)(\#*)(\s*)(${LINE})(.*)$n $BACKUP
sed -i -r -e "s/^(\s*)(\#*)(\s*)($LINE)(.*)/\3\4 nousb \5/g" $FILE
