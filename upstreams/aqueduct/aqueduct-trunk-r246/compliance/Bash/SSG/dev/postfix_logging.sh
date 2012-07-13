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

[ -f $FILE ] || exit 1

PATTERN="(mail\.\*)(\s+)(.*)(\/var\/log\/maillog)"

grep -Eq "$PATTERN" $FILE
if [ $? -eq 0 ]; then
	sed -i -r -e "s|(\s*)(\#*)(\s*)$PATTERN|\3\4\5-\7/g" $FILE
else
	echo "mail.*				-/var/log/maillog" >> $FILE
fi

[ -f /var/log/maillog ] || exit 1

chown root:root /var/log/maillog
chmod 600 /var/log/maillog

grep -Eq "\/var\/log\/maillog" $LOGROT
if [ $? -eq 0 ]; then
	exit 0
else
	sed -i -r -e "/1/i\
			\/var\/log\/maillog" $LOGROT
fi
