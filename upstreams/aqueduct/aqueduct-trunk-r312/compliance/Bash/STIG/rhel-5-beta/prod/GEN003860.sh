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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4701
#Group Title: The finger service is enabled
#Rule ID: SV-27442r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN003860.
#Rule Title: The system must not have the finger service active.
#
#Vulnerability Discussion: The finger service provides information 
#about the system's users to network clients. This information could 
#expose information that could be used in subsequent attacks.
#
#
#Responsibility: System Administrator
#IAControls: DCPP-1
#
#Check Content: 
# grep disable /etc/xinetd.d/finger
#If the finger service is not disabled, this is a finding.
#
#Fix Text: Edit /etc/xinetd.d/finger and set "disable=yes".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003860

#Start-Lockdown

#Check if rsh installed
if [ -e /etc/xinetd.d/finger ]
  then
    sed -i 's/[[:blank:]]*disable[[:blank:]]*=[[:blank:]]*no/        disable                 = yes/g' /etc/xinetd.d/finger
fi