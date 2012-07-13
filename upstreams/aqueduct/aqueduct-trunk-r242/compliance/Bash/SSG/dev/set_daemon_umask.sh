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

# set_daemon_umask
# Set the daemon umask in /etc/init.d/functions

FILE=/etc/init.d/functions
[ -f $FILE ] || exit 1

grep -q '^\#*\s*umask\s+\d+' $FILE
if [ $? -eq 0 ]; then
	sed -i -r -e 's/^(\#*)(\s*)(umask)\s+\d+/\2 027/g' $FILE
else
	echo umask 027 >> $FILE
fi
