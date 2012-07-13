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
# on 09-Feb-2012 to only run fix when needed.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22480
#Group Title: GEN005531
#Rule ID: SV-26774r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005531
#Rule Title: The SSH daemon must not permit tunnels.
#
#Vulnerability Discussion: OpenSSH has the ability to create network tunnels 
#(layer-2 and layer-3) over an SSH connection. This function can provide similar 
#convenience to a virtual private network (VPN) with the similar risk of 
#providing a path to circumvent firewalls and network ACLs.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the SSH daemon configuration for the PermitTunnel setting.
# grep -i PermitTunnel /etc/ssh/sshd_config | grep -v '^#'
#If the setting is not present, or set to "yes", this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and add or edit the "PermitTunnel" setting value to "no".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005531

#Start-Lockdown

if [ `grep -c "^PermitTunnel" /etc/ssh/sshd_config` -gt 0 ]
then
  egrep '^PermitTunnel.*yes' /etc/ssh/sshd_config > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i "/^PermitTunnel/ c\PermitTunnel no" /etc/ssh/sshd_config
    service sshd restart
  fi
else
  echo "#Added for DISA $PDI" >> /etc/ssh/sshd_config
  echo "PermitTunnel no" >> /etc/ssh/sshd_config
  service sshd restart
fi
