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

FILE="/etc/rsyslog.conf"
LOGROT="/etc/logrotate.d/syslog"

[ -f "$FILE" ] || exit 1

PATTERN="(mail\.\*)(\s+)(.*)(\/var\/log\/maillog)"

. $(dirname $0)/set_general_entry
safe_add_field "$PATTERN" "\t\t\t\-/var/log/maillog" "$FILE"

[ -f /var/log/maillog ] || exit 1

/bin/chown root:root /var/log/maillog
/bin/chmod 600 /var/log/maillog

if /bin/grep -Eq "\/var\/log\/maillog" "$LOGROT"; then
	exit 0
else
	/bin/sed -i -r -e "/1/i\
			\/var\/log\/maillog" "$LOGROT"
fi
