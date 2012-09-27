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
# on 06-Feb-2012 to only run fix when needed and point it to ssh_config and
# not sshd_config. I then commented everything out as this is a bad option.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22465
#Group Title: GEN005516
#Rule ID: SV-26758r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005516
#Rule Title: The SSH client must be configured to not allow TCP forwarding.
#
#Vulnerability Discussion: SSH TCP connection forwarding provides a mechanism to establish TCP connections proxied by the SSH server. 
#This function can provide similar convenience to a virtual private network (VPN) with the similar risk of providing a path to circumvent firewalls and network ACLs.
#
#If this function is necessary to support a valid mission requirement, its use must be authorized and approved in the system accreditation package.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the SSH client configuration for the TCP forwarding setting.
# grep -i AllowTCPForwarding /etc/ssh/ssh_config | grep -v '^#'
#If no lines are returned, or the returned setting has a value evaluating to "yes", this is a finding.
#
#Fix Text: Edit the SSH client configuration and change or add the "AllowTCPForwarding" setting to "no".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005516

#Start-Lockdown

# Tcp fowarding is not a valid ssh client option and will throw errors.
#if [ `grep -c "^AllowTcpForwarding" /etc/ssh/ssh_config` -gt 0 ]
#then
#  egrep '^AllowTcpForwarding.*yes' /etc/ssh/ssh_config > /dev/null
#  if [ $? -eq 0 ]
#  then
#    sed -i "/^AllowTcpForwarding/ c\AllowTcpForwarding no" /etc/ssh/ssh_config
#  fi
#else
#  echo "AllowTcpForwarding no" >> /etc/ssh/ssh_config
#fi

