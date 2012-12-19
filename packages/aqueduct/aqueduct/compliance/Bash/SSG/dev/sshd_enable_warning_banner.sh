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

CONFIG=/etc/ssh/sshd_config

# No sshd - exit
[ -f $CONFIG ] || exit 0

# Banner is set - exit
/bin/grep -qi "^Banner" $CONFIG && exit 0

if /bin/grep -qi "^#\s*Banner" $CONFIG; then
	/bin/sed -i -e "s:no default banner path:Use /etc/issue as banner:" $CONFIG
	/bin/sed -i -e "s:^#\s*Banner.*:Banner /etc/issue:" $CONFIG
else
	/bin/cat <<EOF >> $CONFIG

# Added by $(/bin/basename $0) on $(/bin/date -u)
Banner /etc/issue
EOF
fi
