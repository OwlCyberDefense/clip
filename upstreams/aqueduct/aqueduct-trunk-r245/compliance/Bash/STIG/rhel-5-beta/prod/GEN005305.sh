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
# on 05-Feb-2012 to removed uneeded loop that was causing lines to be commented
# out multiple times
#
# Updated by Lee Kinser (lkinser@redhat.com) on 1 May 2012 to add logic
# for verifying net-snmp is installed before attempting to configure
# the service


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22447
#Group Title: GEN005305
#Rule ID: SV-26713r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005305
#Rule Title: The SNMP service must use only SNMPv3 or its successors.
#
#Vulnerability Discussion: SNMP Versions 1 and 2 are not considered secure.
#Without the strong authentication and privacy that is provided by the SNMP Version
#3 User-based Security Model (USM), an attacker or other unauthorized users may gain
#access to detailed system management information and use that information to launch attacks against the system.
#
#Responsibility: System Administrator
#IAControls: DCPP-1
#
#Check Content: 
#Check that the SNMP daemon is not configured to use the v1 or v2c security models.
#
#Procedure:
#Examine the default install location /etc/snmp/snmpd.conf
#or:
# find / -name snmpd.conf
#
# grep -E '(v1|v2c|community|com2sec)' <snmp.conf file> | grep -v '^#'
#If any configuration is found, this is a finding.
#
#Fix Text: Edit /etc/snmp/snmpd.conf and remove references to the "v1", "v2c", "community", or "com2sec".
#Restart the SNMP service.
# service snmpd restart   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005305

#Start-Lockdown
# Confirm that we actually have net-snmp installed.  Both the directory holding the files for this GEN
# as well as the net-snmp RPM must be missing in order for this check to stop execution of the script
if [ ! -d /etc/snmp ] && ! rpm -q net-snmp >/dev/null 2>&1 ; then
        exit 0
fi

line=/etc/snmp/snmpd.conf
V1VAR=$( cat $line | grep -i v1 | grep -v '^#' | wc -l )
V2CVAR=$( cat $line | grep -i v2c | grep -v '^#' | wc -l )
COMMVAR=$( cat $line | grep -i community | grep -v '^#' | wc -l )
COM2VAR=$( cat $line | grep -i com2sec | grep -v '^#' | wc -l )

#Check if the v1 line is in the config file
if [ $V1VAR -ne 0 ]
then
  #Comment out any line that has v1 in it.
  sed -i 's/.*v1/#&/g' /etc/snmp/snmpd.conf
fi

#Check if the v2 line is in the config file
if [ $V2CVAR -ne 0 ]
then
  sed -i 's/.*v2c/#&/g' /etc/snmp/snmpd.conf
fi

#Check if the community line is in the config file
if [ $COMMVAR -ne 0 ]
then
 sed -i 's/.*community/#&/g' /etc/snmp/snmpd.conf
fi

if [ $COM2VAR -ne 0 ]
then
  sed -i 's/.*com2sec/#&/g' /etc/snmp/snmpd.conf
fi

