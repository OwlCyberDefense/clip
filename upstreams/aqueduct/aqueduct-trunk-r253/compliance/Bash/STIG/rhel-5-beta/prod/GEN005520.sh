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
#Group ID (Vulid): V-22469
#Group Title: GEN005520
#Rule ID: SV-26762r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005520
#Rule Title: The SSH client must be configured to not allow X11 forwarding.
#
#Vulnerability Discussion: X11 forwarding over SSH allows for the secure remote execution of X11-based applications. 
#This feature can increase the attack surface of an SSH connection and should not be enabled unless needed.
#
#If this function is necessary to support a valid mission requirement, its use must be authorized and approved in the system accreditation package.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the SSH client configuration for the X11 forwarding setting.
# grep -i X11Forwarding /etc/ssh/ssh_config | grep -v '^#'
#If no lines are returned, or the returned setting has a value evaluating to "yes", this is a finding.
#
#Fix Text: Edit the SSH client configuration and change or add the "X11Forwarding" setting to "no".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005520

#Start-Lockdown

# This is not a valid client option.
#if [ `grep -c "^X11Forwarding" /etc/ssh/ssh_config` -gt 0 ]
#then
#  egrep '^X11Forwarding.*yes' /etc/ssh/ssh_config > /dev/null
#  if [ $? -eq 0 ]
#  then
#    sed -i "/^X11Forwarding/ c\X11Forwarding no" /etc/ssh/ssh_config
#  fi
#else
#  echo "X11Forwarding no" >> /etc/ssh/ssh_config
#fi
