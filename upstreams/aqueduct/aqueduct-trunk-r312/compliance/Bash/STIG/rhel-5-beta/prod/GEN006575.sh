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

#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 16-Feb-2012 to move check from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22509
#Group Title: GEN006575
#Rule ID: SV-26861r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN006575
#Rule Title: The file integrity tool must use FIPS 140-2 approved cryptographic hashes for validating file contents.
#
#Vulnerability Discussion: File integrity tools often use cryptographic hashes for verifying that file contents have not been altered. These hashes must be FIPS 140-2 approved.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If using AIDE, check that the configuration contains the "sha256" or "sha512" options for all monitored files and directories.
#
#Procedure:
#Check for the default location /etc/aide/aide.conf
#or:
# find / -name aide.conf
#
#  <aide.conf file>
#If the option is not present. This is a finding.
#If one of these option is not present. This is a finding.
#
#If using a different file integrity tool, check the configuration per tool documentation.
#
#Fix Text: If using AIDE, edit the configuration and add the "sha512" option for all monitored files and directories.
#
#If using a different file integrity tool, configure FIPS 140-2 approved cryptographic hashes per the tool's documentation.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006575

#Start-Lockdown

#Think this is on by default...but not 100% since the check isn't very specific 
rpm -q aide > /dev/null
if [ $? -ne 0 ]
then
  yum install aide -y
fi

# Start out by getting all file check definitions(line starting with a /)
# to get a list of used check groups.
if [ -e /etc/aide.conf ]
then
  for GROUP in `awk '/^\//{print $2}' /etc/aide.conf | sort | uniq`
  do
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
fi



