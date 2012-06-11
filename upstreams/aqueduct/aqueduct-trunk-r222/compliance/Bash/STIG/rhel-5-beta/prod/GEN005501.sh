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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechonlogy-llc.com)
# on 06-Feb-2012 to only run fix when needed.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22456
#Group Title: GEN005501
#Rule ID: SV-26749r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005501
#Rule Title: The SSH client must be configured to only use the SSHv2 protocol.
#
#Vulnerability Discussion: SSHv1 is not a DoD-approved protocol and has many well-known vulnerability exploits.
#Exploits of the SSH client could provide access to the system with the privileges of the user running the client.
#
#Responsibility: System Administrator
#IAControls: DCPP-1
#
#Check Content: 
#Check the SSH client configuration for allowed protocol versions.
# grep -i protocol /etc/ssh/ssh_config | grep -v '^#'
#If the returned protocol configuration allows versions less than 2, this is a finding.
#
#Fix Text: Edit the /etc/ssh/ssh_config file and add or edit a "Protocol" configuration line that does not allow versions less than 2.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005501

#Start-Lockdown

if [ `grep -c "^Protocol" /etc/ssh/ssh_config` -gt 0 ]
then
  egrep '^Protocol.*1' /etc/ssh/sshd_config > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i "/^Protocol/ c\Protocol 2" /etc/ssh/ssh_config
  fi
else
  echo "Protocol 2" >> /etc/ssh/ssh_config
fi
