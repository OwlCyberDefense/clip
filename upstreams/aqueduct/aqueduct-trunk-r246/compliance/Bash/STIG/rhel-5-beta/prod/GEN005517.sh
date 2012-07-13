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
#Group ID (Vulid): V-22466
#Group Title: GEN005517
#Rule ID: SV-26759r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005517
#Rule Title: The SSH daemon must be configured to not allow gateway ports.
#
#Vulnerability Discussion: SSH TCP connection forwarding provides a mechanism to establish TCP connections proxied by the SSH server. 
#This function can provide similar convenience to a virtual private network (VPN) with the similar risk of providing a path to circumvent 
#firewalls and network ACLs. Gateway ports allow remote forwarded ports to bind to non-loopback addresses on the server.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the SSH daemon configuration for the gateway ports setting.
# grep -i GatewayPorts /etc/ssh/sshd_config | grep -v '^#'
#If no lines are returned, or the returned setting has a value evaluating to "yes", this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and change or add the "GatewayPorts" setting to "no".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005517


#Start-Lockdown

if [ `grep -c "^GatewayPorts" /etc/ssh/sshd_config` -gt 0 ]
then
  egrep '^GatewayPorts.*yes' /etc/ssh/sshd_config > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i "/^GatewayPorts/ c\GatewayPorts no" /etc/ssh/sshd_config
    service sshd restart
  fi
else
  echo "#Adding for DISA $PDI" >> /etc/ssh/sshd_config
  echo "GatewayPorts no" >> /etc/ssh/sshd_config
  service sshd restart
fi

