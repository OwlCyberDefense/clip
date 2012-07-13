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
# on 14-Feb-2012 to check permissions before running chmod and to allow for 
# "less permissive" permissions.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4276
#Group Title: /etc/news/passwd.nntp permissions
#Rule ID: SV-4276r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006320
#Rule Title: The /etc/news/passwd.nntp file (or equivalent) must have mode 0600 or less permissive.
#
#Vulnerability Discussion: File permissions more permissive than 0600 for /etc/news/passwd.nntp may allow access to privileged information by system intruders or malicious users.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check /etc/news/passwd.nntp permissions:
#
# ls -lL /etc/news/passwd.nntp
#
#If /etc/news/passwd.nntp has a mode more permissive than 0600, this is a finding.
#
#
#Fix Text: Change the mode of the /etc/news/passwd.nntp file.
# chmod 0600 /etc/news/passwd.nntp   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006320

#Start-Lockdown

if [ -a "/etc/news/passwd.nntp" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/news/passwd.nntp`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7177)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&7)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
      then
        chmod u-xs,g-rwxs,o-rwxt /etc/news/passwd.nntp
    fi
fi



