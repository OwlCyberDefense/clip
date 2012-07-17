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

FILE=/etc/sysconfig/network

[ -f $FILE ] || exit 1

[ -f /etc/init.d/network ] || exit 0

grep -Pq "^(\s*)(\#*)(\s*)(NETWORKING_IPV6)(\s*)\=" $FILE
if [ $? -eq 0 ]; then
	 sed -i -r -e "s/^(\s*)(\#*)(\s*)(NETWORKING_IPV6(\s*)\=).*/\3\4no/g" $FILE
else 
	echo "NETWORKING_IPV6=no" >> $FILE
fi
	
grep -Pq "^(\s*)(\#*)(\s*)(IPV6INIT)(\s*)\=" $FILE
if [ $? -eq 0 ]; then
	sed -i -r -e "s/^(\s*)(\#*)(\s*a)(IPV6INIT(\s*)\=).*/\3\4no/g
"a $FILE
else
	echo "IPV6INIT=no" >> $FILE
fi

IFCFG_INTERFACES="/etc/sysconfiag/network-scripts/ifcfg-*"

for interfaces in ${IFCFG_INTERFACES}; do
        if [ $interfaces -ne "/etc/sysconfig/network-scripts/ifcfg-lo" ]
        then
                rm $interfaces
        fi
done

chkconfig network off

