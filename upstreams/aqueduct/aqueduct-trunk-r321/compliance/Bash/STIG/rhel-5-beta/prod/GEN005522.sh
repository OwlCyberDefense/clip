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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 04-Feb-2012 to check permissions before running chmod.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22471
#Group Title: GEN005522
#Rule ID: SV-26764r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005522
#Rule Title: The SSH public host key files must have mode 0644 or less permissive.
#
#Vulnerability Discussion: If a public host key file is modified by an unauthorized user, the SSH service may be compromised.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions for SSH public host key files.
# ls -lL /etc/ssh/*key.pub
#If any file has a mode more permissive than 0644, this is a finding.
#
#Fix Text: Change the permissions for the SSH public host key files.
# chmod 0644 /etc/ssh/*key.pub   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005522

#Start-Lockdown

find /etc/ssh -type f -name '*key.pub' -exec chmod u-xs,g-wxs,o-wxt {} \;
