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
#Group ID (Vulid): V-22474
#Group Title: GEN005525
#Rule ID: SV-26767r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005525
#Rule Title: The SSH client must not permit GSSAPI authentication unless needed.
#
#Vulnerability Discussion: GSSAPI authentication is used to provide additional authentication mechanisms to applications. 
#Allowing GSSAPI authentication through SSH exposes the system’s GSSAPI to remote hosts, increasing the attack surface of the system. 
#GSSAPI authentication must be disabled unless needed.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the SSH clients configuration for the GSSAPIAuthentication setting.
# grep -i GSSAPIAuthentication /etc/ssh/ssh_config | grep -v '^#'
#If no lines are returned, or the setting is set to "yes", this is a finding.
#
#Fix Text: Edit the SSH client configuration and set (add if necessary) an "GSSAPIAuthentication" directive set to "no".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005525

#Start-Lockdown

if [ `grep -c "^[^#]*GSSAPIAuthentication" /etc/ssh/ssh_config` -gt 0 ]
then
  egrep 'GSSAPIAuthentication.*yes' /etc/ssh/ssh_config > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i "/GSSAPIAuthentication/ c\GSSAPIAuthentication no" /etc/ssh/ssh_config
  fi
else
  echo "#Adding for DISA $PDI" >> /etc/ssh/ssh_config
  echo "GSSAPIAuthentication no" >> /etc/ssh/ssh_config
fi

