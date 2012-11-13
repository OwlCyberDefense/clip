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

FILE=/etc/passwd

# If /etc/passwd doesn't exist we can't identify system accounts from this listing.
[ -f $FILE ] || exit 1

# Find all system accounts and disable their login shells. 
/bin/awk -F: '{
	if ($3)
		if ($3 < 500 && $1 != "root")
			print "/usr/sbin/usermod -s /sbin/nologin " $1
}' $FILE | bash
