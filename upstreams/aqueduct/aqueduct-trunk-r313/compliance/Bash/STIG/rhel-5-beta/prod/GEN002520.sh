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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 23-jan-2012 to use find to add a check before changing ownership.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-807
#Group Title: Public directories ownership
#Rule ID: SV-807r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002520
#Rule Title: All public directories must be owned by root or an 
#application account.
#
#Vulnerability Discussion: If a public directory has the sticky bit set 
#and is not owned by a privileged UID, unauthorized users may be able to 
#modify files created by others.
#
#The only authorized public directories are those temporary directories 
#supplied with the system or those designed to be temporary file 
#repositories. The setting is normally reserved for directories used by 
#the system and by users for temporary file storage (e.g., /tmp) and for 
#directories that require global read/write access.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of all public directories.
#
#Procedure:
# find / -type d -perm -1002 -exec ls -ld {} \;
#
#If any public directory is not owned by root or an application user, 
#this is a finding.
#
#Fix Text: Change the owner of public directories to root or an 
#application account.
#
#Procedure:
# chown root /tmp
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002520

#Start-Lockdown

find / -type d -perm -1002 ! -user root -exec chown root {} \; 2>/dev/null

