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
#Group ID (Vulid): V-22468
#Group Title: GEN005519
#Rule ID: SV-26761r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005519
#Rule Title: The SSH daemon must be configured to not allow X11 forwarding.
#
#Vulnerability Discussion: X11 forwarding over SSH allows for the secure remote execution of X11-based applications. This feature can increase the attack surface of an SSH connection and should not be enabled unless needed.
#
#If this function is necessary to support a valid mission requirement, its use must be authorized and approved in the system accreditation package.
#
#Mitigations: 
#GEN005519
#
#Mitigation Control: 
#If X11 connection forwarding is required, the risk of unauthorized use of this feature can be mitigated by placing restrictions on which users are permitted to use it. For instance, OpenSSH provides conditional configuration blocks (using the "Match" keyword) that can be used to limit X11 connection forwarding based on user, group, host, or address.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the SSH daemon configuration for the X11 forwarding setting.
# grep -i X11Forwarding /etc/ssh/sshd_config | grep -v '^#'
#If no lines are returned, or the returned setting has a value evaluating to "yes", this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and change or add the "X11Forwarding" setting to "no".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005519

#Start-Lockdown

if [ `grep -c "^X11Forwarding" /etc/ssh/sshd_config` -gt 0 ]
then
  egrep '^X11Forwarding.*yes' /etc/ssh/sshd_config > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i "/^X11Forwarding/ c\X11Forwarding no" /etc/ssh/sshd_config
    service sshd restart
  fi
else
  echo "#Adding for DISA $PDI" >> /etc/ssh/sshd_config
  echo "X11Forwarding no" >> /etc/ssh/sshd_config
  service sshd restart
fi

