#!/bin/bash -u
set -e

# 
# Copyright (c) 2010, 2011 Tresys Technology LLC, Columbia, Maryland, USA
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

RSYS=/etc/rsyslog.conf

grep -Eq "local4.*" $RSYS
if [ $? -eq 0 ]; then
	sed -i -r -e "s/(\s*)(\#*)(\s*)(local4.*)/\3\4/g" $RSYS
else
	echo local.* >> $RSYS
fi

touch /var/log/ldap.log
chown root:root /var/log/ldap.log
chmod 0600 /var/log/ldap.log

grep -Eq "\/var\/log\/ldap\.log" /etc/logrotate.d/syslog
if [ $? -eq 0 ]; then
	sed -i -r -e "s/(\s*)(\#*)(\s*)(\/var\/log\/ldap\.log)/\3\4/g" /var/log/ldap.log
else
	/var/log/ldap.log >> /etc/logrotate.d/syslog
fi

echo "loglevel stats2" >> /etc/openldap/slapd.conf
