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
#Group ID (Vulid): V-1030
#Group Title: smb.conf configuration
#Rule ID: SV-1030r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006220
#Rule Title: The smb.conf file must use the "hosts" option to
#restrict access to Samba.
#
#Vulnerability Discussion: Samba increases the attack surface of the
#system and must be restricted to communicate only with systems requiring access.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Examine the smb.conf file.
#
# more /etc/samba/smb.conf
#
#If the "hosts" option is not present to restrict access to a list
#of authorized hosts and networks, this is a finding.
#
#Fix Text: Edit the /etc/samba/smb.conf file and set the "hosts"
#option to permit only authorized hosts to access Samba.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006220

#Start-Lockdown

#Manual check
