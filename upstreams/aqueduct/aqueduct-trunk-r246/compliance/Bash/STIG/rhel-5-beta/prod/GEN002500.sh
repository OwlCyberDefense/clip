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
# Updated by Lee Kinser (lkinser@redhat.com) on 1 May 2012 to squash
# find errors

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-806
#Group Title: Sticky bit on public directories
#Rule ID: SV-806r7_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN002500
#Rule Title: The sticky bit must be set on all public directories.
#
#Vulnerability Discussion: Failing to set the sticky bit on the public 
#directories allows unauthorized users to delete files in the directory 
#structure.
#
#The only authorized public directories are those temporary directories
 #supplied with the system or those designed to be temporary file 
 #repositories. The setting is normally reserved for directories used by 
 #the system and by users for temporary file storage (e.g., /tmp) and for 
 #directories that require global read/write access.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check that all world-writable directories have the sticky bit set.
#
#Procedure:
# find / -type d -perm -002 ! -perm -1000 > wwlist
#
#If the sticky bit is not set on a world-writable directory, this is a finding.
#
#Fix Text: Set the sticky bit on all public directories.
#
#Procedure:
# chmod 1777 /tmp
#
#(Replace /tmp with the public directory missing the sticky bit, if necessary.)   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002500

NOSTICKY=$( find / -fstype nfs -prune -o -type d -perm -002 ! -perm -1000 2> /dev/null )

#Start-Lockdown

for SETSTICKY in $NOSTICKY
  do
    chmod +t $SETSTICKY
done

