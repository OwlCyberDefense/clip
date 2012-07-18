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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
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
#  - Updated by Shannon Mitchell shannon.mitchell@fusiontechnology-llc.com)
# on 28-dec-2011 to check the permissions before running the chmod command.
# Changed the chmod command to allow for "less permissive" permissions.
								     
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22296
#Group Title: GEN000252
#Rule ID: SV-26297r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000252
#Rule Title: The time synchronization configuration file (such as 
#/etc/ntp.conf) must have mode 0640 or less permissive.
#
#Vulnerability Discussion: A synchronized system clock is critical for 
#the enforcement of time-based policies and the correlation of logs 
#and audit records with other systems. If an illicit time source is 
#used for synchronization, the integrity of system logs and the 
#security of the system could be compromised. If the configuration 
#files controlling time synchronization are not protected, 
#unauthorized modifications could result in the failure of time 
#synchronization.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that the mode for the NTP configuration file is not more 
#permissive than 0640.
# ls -l /etc/ntp.conf
#
#If the mode is more permissive than 0640, this is a finding.
#
#Fix Text: Change the mode of the NTP configuration file to 0640 
#or less permissive.
# chmod 0640 /etc/ntp.conf
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000252

#Start-Lockdown

if [ -a "/etc/ntp.conf" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/ntp.conf`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7137)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
      then
        chmod u-xs,g-wxs,o-rwxt /etc/ntp.conf
    fi

  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/ntp.conf does not exist." >> $PDI-error.log
    echo "Could not change permissions to 0640" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi


