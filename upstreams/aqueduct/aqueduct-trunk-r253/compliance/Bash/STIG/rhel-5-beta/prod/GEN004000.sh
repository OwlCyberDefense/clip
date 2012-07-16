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
# on 05-Feb-2012 to check permissions before running chmod and to allow for 
# "less permissive" permissions.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4371
#Group Title: The traceroute command permissions
#Rule ID: SV-28399r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004000
#Rule Title: The traceroute file must have mode 0700 or less permissive.
#
#Vulnerability Discussion: If the mode of the traceroute executable is 
#more permissive than 0700, malicious code could be inserted by an 
#attacker and triggered whenever the traceroute command is executed by 
#authorized users. Additionally, if an unauthorized user is granted 
#executable permissions to the traceroute command, it could be used to 
#gain information about the network topology behind the firewall. This 
#information may allow an attacker to determine trusted routers and 
#other network information that may lead to system and network compromise.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
# ls -lL /bin/traceroute
#If the traceroute command has a mode more permissive than 0700, 
#this is a finding.
#
#
#Fix Text: Change the mode of the traceroute command.
# chmod 0700 /bin/traceroute
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004000

#Start-Lockdown

if [ -a "/bin/traceroute" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /bin/traceroute`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7077)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&7)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
      then
        chmod u-s,g-rwxs,o-rwxt /bin/traceroute
    fi
fi
