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
#Group ID (Vulid): V-12019
#Group Title: snmpd.conf ownership
#Rule ID: SV-12520r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005360
#Rule Title: The snmpd.conf file must be owned by root.
#
#Vulnerability Discussion: The snmpd.conf file contains authenticators and must be protected from unauthorized access and modification. If the file is not owned by root, it may be subject to access and modification from unauthorized users.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Determine the owner of the SNMP configuration file.
#
#Procedure:
#Examine the default install location /etc/snmp/snmpd.conf
#or:
# find / -name snmpd.conf
#
# ls -lL <snmpd.conf>
#
#If the snmpd.conf file is not owned by root, this is a finding.
#
#Fix Text: Change the owner of the snmpd.conf file to root.
#
#Procedure:
# chown root <snmpd.conf file>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005360
SNMPDFILES=$( find / -fstype nfs -prune -o -name snmpd.conf -print 2> /dev/null )
#Start-Lockdown

for line in $SNMPDFILES
  do
    if [ -a $line ]
      then
        CUROWN=`stat -c %U $line`
        
      if [ "$CUROWN" != "root" ]
        then
          chown root $line
      fi
    fi
done
