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
#  - Updated by Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
# on 28-dec-2011 to include a group ownership check before running.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22342
#Group Title: GEN000000-LNX001432
#Rule ID: SV-29956r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000000-LNX001432
#Rule Title: The /etc/gshadow file must be group-owned by root.
#
#Vulnerability Discussion: The /etc/gshadow file is critical to system 
#security and must be protected from unauthorized modification. The 
#/#etc/gshadow file contains a list of system groups and hashes for 
#group passwords.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that the /etc/gshadow file is group-owned by root.
# ls -l /etc/gshadow
#If the file is not group-owned by root, this is a finding.

#Fix Text: Change the group-owner of the /etc/gshadow file to root.
# chgrp root /etc/gshadow   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX001432

#Start-Lockdown

if [ -a "/etc/gshadow" ]
  then

    CURGOWN=`stat -c %G /etc/gshadow`;

    if [ "$CURGOWN" != "root" ]
      then
        chgrp root /etc/gshadow
    fi

  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/gshadow does not exist." >> $PDI-error.log
    echo "Could not change group ownership to root" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi

