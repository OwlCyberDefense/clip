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
#Group ID (Vulid): V-22470
#Group Title: GEN005521
#Rule ID: SV-26763r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005521
#Rule Title: The SSH daemon must restrict login ability to specific users and/or groups.
#
#Vulnerability Discussion: Restricting SSH logins to a limited group of users, such as system administrators, prevents password-guessing and other SSH attacks from reaching system accounts and other accounts not authorized for SSH access.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the SSH daemon configuration for the AllowGroups setting.
# grep -i AllowGroups /etc/ssh/sshd_config | grep -v '^#'
#If no lines are returned, this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and add an "AllowGroups" directive.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005521

#Start-Lockdown

# Each environment will have a different set of users/groups allowed to ssh in.
