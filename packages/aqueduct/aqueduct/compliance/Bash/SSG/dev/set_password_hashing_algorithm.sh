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

FILE=/etc/login.defs
PARAM=MD5_CRYPT_ENAB
DESIRED=no

# delete if multiple, add if missing
COUNT=$( /bin/egrep "^$PARAM\s+" $FILE | /usr/bin/wc -l )
if [ $COUNT -ne 1 ]; then
	/bin/sed -i -r -e "/^$PARAM\s+/d" $FILE
 	/bin/echo "$PARAM	$DESIRED" >>$FILE
	exit
fi

# get value
ACTION='{print $2}'
VAL=$(/bin/awk "/^$PARAM/$ACTION" $FILE )

# fix if wrong
[ "x$VAL" != "x$DESIRED" ] && /bin/sed -i -r -e "s/^$PARAM\s+.*/$PARAM	$DESIRED/" $FILE

# - - - - - - - - 

PARAM=ENCRYPT_METHOD
DESIRED=SHA512

# delete if multiple, add if missing
COUNT=$( /bin/egrep "^$PARAM\s+" $FILE | /usr/bin/wc -l )
if [ $COUNT -ne 1 ]; then
	/bin/sed -i -r -e "/^$PARAM\s+/d" $FILE
	/bin/echo "$PARAM	$DESIRED" >>$FILE
	exit
fi

# get value
ACTION='{print $2}'
VAL=$(/bin/awk "/^$PARAM/$ACTION" $FILE )

# fix if wrong
[ "x$VAL" != "x$DESIRED" ] && /bin/sed -i -r -e "s/^$PARAM\s+.*/$PARAM	$DESIRED/" $FILE

# - - - - - - - - 

. $(dirname $0)/set_pam_common
set_pam_unix_flag sha512
