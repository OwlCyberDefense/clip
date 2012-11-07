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

# TO BE DONE MANUALLY
FILE=/etc/rsyslog.conf

# if no rsyslog, exit
[ -f $FILE ] || exit 1

# prompt for central logserver and put entry in rsyslog.conf
/bin/echo ""
/bin/echo "Enter the name of your central logserver (e.g. loghost.example.com)."
read -p "logserver: " logserver

if /bin/grep -qi "\*\.\*\"" "$FILE"; then
	/bin/sed -i -r -e "s/*.*\s+@.*/@$logserver/g" "$FILE"
else
	/bin/sed -i -r -e "/\#\sRemote\sLogging.*/ a\
			\*.\*\t\t\t\t@$logserver" "$FILE"
fi
