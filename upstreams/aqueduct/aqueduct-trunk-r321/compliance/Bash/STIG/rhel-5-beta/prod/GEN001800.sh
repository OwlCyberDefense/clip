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
# on 14-jan-2012 to allow for "less permissive" permissions


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-788
#Group Title: Default/Skeleton Dot Files Permissions
#Rule ID: SV-788r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001800
#Rule Title: All skeleton files (typically those in /etc/skel) must 
#have mode 0644 or less permissive.
#
#Vulnerability Discussion: If the skeleton files are not protected, 
#unauthorized personnel could change user startup parameters and 
#possibly jeopardize user files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check skeleton files permissions.
# ls -alL /etc/skel
#If a skeleton file has a mode more permissive than 0644, this is a finding.
#
#Fix Text: Change the mode of skeleton files with incorrect mode:
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001800
BADSKELFILE=$( find /etc/skel -perm /7133 -type f )

#Start-Lockdown

for file in $BADSKELFILE
  do
    chmod u-xs,g-wxs,o-wxt $file
done



