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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-Feb-2012 to move from dev to prod and added partial fix
#
# Updated by Lee Kinser (lkinser@redhat.com) on 1 May 2012 to add logic
# for verifying net-snmp is installed before attempting to configure
# the service



#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22448
#Group Title: GEN005306
#Rule ID: SV-26717r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005306
#Rule Title: The SNMP service must require the use of a FIPS 140-2 approved cryptographic hash algorithm as part of its authentication and integrity methods.
#
#Vulnerability Discussion: The SNMP service must use SHA-1 or a FIPS 140-2 approved successor for authentication and integrity.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Check that the SNMP daemon uses SHA for SNMPv3 users.
#
#Procedure:
#Examine the default install location /etc/snmp/snmpd.conf
#or:
# find / -name snmpd.conf
#
# grep -v '^#' <snmpd.conf file> | grep -i createuser | grep -vi SHA
#If any line is present this is a finding.
#
#Fix Text: Edit /etc/snmp/snmpd.conf and add the SHA keyword for any createUser statement that does not have them.
#Restart the SNMP service.
# service snmpd restart   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005306

#Start-Lockdown
# Confirm that we actually have net-snmp installed.  Both the directory holding the files for this GEN
# as well as the net-snmp RPM must be missing in order for this check to stop execution of the script
if [ ! -d /etc/snmp ] && ! rpm -q net-snmp >/dev/null 2>&1 ; then
        exit 0
fi


# man snmpd.conf
# ...
# createUser [-e ENGINEID] username  (MD5|SHA)  authpassphrase  [DES|AES] [privpassphrase]
# ...
# Based on the man pages the only option to SHA is MD5, so lets just change it.i
# Depending on how its used, changing it from MD5 to SHA may require manual
# changes.

grep 'createUser' /etc/snmp/snmpd.conf | grep 'MD5' > /dev/null
if [ $? -eq 0 ]
then
  sed -i 's/^\(createUser.*\)MD5\(.*\)/\1SHA\2/g' /etc/snmp/snmpd.conf
fi

