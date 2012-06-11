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
#Group ID (Vulid): V-4295
#Group Title: SSH Version 1 Compatibility
#Rule ID: SV-4295r6_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN005500
#Rule Title: The SSH daemon must be configured to only use the SSHv2 protocol.
#
#Vulnerability Discussion: SSHv1 is not a DoD-approved protocol and has many well-known vulnerability exploits. Exploits of the SSH daemon could provide immediate root access to the system.
#
#Responsibility: System Administrator
#IAControls: DCPP-1
#
#Check Content: 
#Locate the sshd_config file:
# more /etc/ssh/sshd_config
#
#Examine the file. If the variables 'Protocol 2,1’ or ‘Protocol 1’ are defined on a line without a leading comment, this is a finding.
#
#If the SSH server is F-Secure, the variable name for SSH 1 compatibility is ‘Ssh1Compatibility’, not ‘protocol’. If the variable ‘Ssh1Compatiblity’ is set to ‘yes’, then this is a finding.
#
#Fix Text: Edit the sshd_config file and set the "Protocol" setting to "2". If using the F-Secure SSH server, set the "Ssh1Compatibility" setting to "no".  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005500

#Start-Lockdown

if [ `grep -c "^Protocol" /etc/ssh/sshd_config` -gt 0 ]
then
  egrep '^Protocol.*1' /etc/ssh/sshd_config > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i "/^Protocol/ c\Protocol 2" /etc/ssh/sshd_config
  fi
else
  echo "Protocol 2" >> /etc/ssh/sshd_config
fi
