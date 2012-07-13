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
# Updated by Lee Kinser (lkinser@redhat.com) on 1 May 2012 to squash
# find errors

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22452
#Group Title: GEN005375
#Rule ID: SV-26735r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005375
#Rule Title: The snmpd.conf file must not have an extended ACL.
#
#Vulnerability Discussion: The snmpd.conf file contains authenticators and must be protected from unauthorized access and modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the SNMP configuration file.
#
#Procedure:
#Examine the default install location /etc/snmp/snmpd.conf
#or:
# find / -name snmpd.conf
#
# ls -lL <snmpd.conf>
#
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all <snmpd.conf file>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005375
SNMPDFILES=$( find / -fstype nfs -prune -o -name snmpd.conf -print 2> /dev/null )
#Start-Lockdown

for line in $SNMPDFILES
  do
    if [ -a $line ]
      then
        ACLOUT=`getfacl --skip-base $line 2>/dev/null`;
      if [ "$ACLOUT" != "" ]
        then
        setfacl --remove-all $line 
      fi
    fi
done
