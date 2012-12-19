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

FILE=/etc/passwd

# If /etc/passwd doesn't exist we can't identify system accounts from this listing.
[ -f  $FILE ] || exit 1

# Check each user in /etc/passwd for a file and change the permisssions if it
# exists
/bin/awk -F: '{
	if( system( "[ -f " "/home/"$1 " ] " ) == 0 ) 
		print "/bin/chmod -f g-w /home/"$1
		print "/bin/chmod -f o-rwx /home/"$1
}' $FILE | bash
