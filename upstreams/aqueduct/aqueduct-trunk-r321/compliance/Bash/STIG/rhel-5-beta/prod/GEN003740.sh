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
# on 04-feb-2012 to check permissions before running chmod and to allow for
# "less permissive" permissions.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-822
#Group Title: The xinetd.conf permissions
#Rule ID: SV-27428r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003740
#Rule Title: The xinetd.conf files must have mode 0640 or less permissive.
#
#Vulnerability Discussion: The Internet service daemon configuration 
#files must be protected as malicious modification could cause denial 
#of service or increase the attack surface of the system.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#RHEL5 does not include inetd service in its distribution. It has been 
#replaced by xinetd.
#
#Procedure:
# ls -lL /etc/xinetd.conf
# ls -lL /etc/xinetd.d
#If the mode of the file(s) is more permissive than 0640, 
#this is a finding.
#
#Fix Text: Change the mode of the xinetd configuration files.
# chmod 0640 /etc/xinetd.conf /etc/xinetd.d/*    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003740

#Start-Lockdown
find /etc/xinetd.conf /etc/xinetd.d -type f -perm /7137 -exec chmod u-xs,g-wxs,o-rwxt {} \; 2> /dev/null
