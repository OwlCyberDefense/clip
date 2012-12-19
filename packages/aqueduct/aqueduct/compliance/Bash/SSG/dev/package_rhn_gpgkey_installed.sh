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

[ -f /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release ] || exit 1

# verify we have the right key
keyid=`/bin/echo $(/usr/bin/gpg --throw-keyids < /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release ) | \
       /bin/cut --characters=11-18 | /usr/bin/tr [A-Z] [a-z] )`
[ "$keyid" == "fd431d51" ] || exit 0

# if not installed, install it
if /bin/rpm -qi "gpg-pubkey-$keyid" | /bin/grep -q "release key 2"; then
	/bin/rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
fi

# return status of key check
/bin/rpm -qi "gpg-pubkey-$keyid" | /bin/grep -q "release key 2"
