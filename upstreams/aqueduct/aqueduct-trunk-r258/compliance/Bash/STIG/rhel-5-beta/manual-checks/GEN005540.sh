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
#Group ID (Vulid): V-12022
#Group Title: Encrypted Communications IP Filtering and Banners
#Rule ID: SV-12523r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005540
#Rule Title: The SSH daemon must be configured for IP filtering.
#
#Vulnerability Discussion: The SSH daemon must be configured for IP filtering to provide a layered defense against connection attempts from unauthorized addresses.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the TCP wrappers configuration files to determine if sshd is configured to use TCP wrappers.
#
#Procedure:
# grep sshd /etc/hosts.deny
# grep sshd /etc/hosts.allow
#
#If no entries are returned, the TCP wrappers are not configured for sshd, this is a finding.
#
#Fix Text: Add appropriate IP restrictions for SSH to the /etc/hosts.deny and/or /etc/hosts.allow files.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005540

#Start-Lockdown

#Cant do this...admins will have to.  We don't know you're network spacing ;) 
