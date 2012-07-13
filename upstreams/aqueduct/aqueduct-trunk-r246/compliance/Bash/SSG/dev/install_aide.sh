#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Vincent C. Passaro (vincent.passaro@gmail.com)
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor,
#Boston, MA  02110-1301, USA.

#!/bin/bash -u
set -e

# Copied from GEN006575 script

rpm -q aide > /dev/null
if [ $? -ne 0 ]; then
  yum install aide -y
  [ $? -eq 0 ] || exit 1
fi

# fail if we can't configure
[ -f /etc/aide.conf ] || exit 1

# Start out by getting all file check definitions(line starting with a /)
# to get a list of used check groups.
for GROUP in `awk '/^\//{print $2}' /etc/aide.conf | sort | uniq`; do
    CONFLINE=`awk "/^${GROUP}/{print \\$3}" /etc/aide.conf`
    if [[ "$CONFLINE" != *sha512* ]]
    then
      NEWCONFLINE="${CONFLINE}+sha512"
      sed -i -e "s/^${GROUP}.*/${GROUP} = $NEWCONFLINE/g" /etc/aide.conf
    fi
    
    # Remove all other checksum types to make sure sha512 is used
    # Turns out that FIPS modes keeps aide from initializing if you
    # disable the other checksums. Lets keep this in just in case this
    # gets fixed in the future.
    sed -i -e "s/^\(${GROUP}.*\)md5\(.*\)/\1\2/g" /etc/aide.conf | grep DATA
    sed -i -e "s/^\(${GROUP}.*\)sha1\(.*\)/\1\2/g" /etc/aide.conf | grep DATA
    sed -i -e "s/^\(${GROUP}.*\)sha256\(.*\)/\1\2/g" /etc/aide.conf | grep DATA
    sed -i -e "s/^\(${GROUP}.*\)rmd160\(.*\)/\1\2/g" /etc/aide.conf | grep DATA
    sed -i -e "s/^\(${GROUP}.*\)tiger\(.*\)/\1\2/g" /etc/aide.conf | grep DATA
    sed -i -e "s/^\(${GROUP}.*\)haval\(.*\)/\1\2/g" /etc/aide.conf | grep DATA
    sed -i -e "s/^\(${GROUP}.*\)gost\(.*\)/\1\2/g" /etc/aide.conf | grep DATA
    sed -i -e "s/^\(${GROUP}.*\)crc32\(.*\)/\1\2/g" /etc/aide.conf | grep DATA
    sed -i -e "s/^\(${GROUP}.*\)whirlpool\(.*\)/\1\2/g" /etc/aide.conf | grep DATA
    # Replace two or mor +s with a single + to fix the damage from removing
    # the checksum types
    sed -i -e 's/\+\++/+/g' /etc/aide.conf
done
