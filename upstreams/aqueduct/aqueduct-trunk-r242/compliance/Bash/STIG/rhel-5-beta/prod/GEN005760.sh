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
# on 12-Feb-2012 to check permissions before running chmod and to allow for 
# "less permissive" permissions.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-929
#Group Title: Export Configuration File Permissions
#Rule ID: SV-28447r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005760
#Rule Title: The NFS export configuration file must have mode 0644 or less permissive.
#
#Vulnerability Discussion: Excessive permissions on the NFS export configuration file could allow unauthorized modification of the file, which could result in denial of service to authorized NFS exports and the creation of additional unauthorized exports.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2, ECLP-1
#
#Check Content: 
# ls -lL /etc/exports
#If the file has a mode more permissive than 0644, this is a finding.
#
#Fix Text: # chmod 0644 /etc/exports  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005760

#Start-Lockdown

if [ -a "/etc/exports" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/exports`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7133)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&3)) != "0" ]
      then
        chmod u-xs,g-wxs,o-wxt /etc/exports
    fi
fi
