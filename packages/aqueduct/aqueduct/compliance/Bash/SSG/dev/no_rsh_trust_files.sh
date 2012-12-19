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

# Remove rsh host trust files if they exists.

[ -f ~/.rhosts ] || [ -f /etc/hosts.equiv ] || exit 0

for USERS in `/bin/awk -F: '{print $1}' /etc/passwd`; do
	/bin/rm -f /home/${USERS}/.rhosts
	/bin/rm -f /home/${USERS}/etc/hosts.equiv
done;
