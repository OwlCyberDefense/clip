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
#Group ID (Vulid): V-1054
#Group Title: Access File Group Ownership
#Rule ID: SV-1054r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000000-LNX00420
#Rule Title: The /etc/security/access.conf file must have a privileged 
#group owner.
#
#Vulnerability Discussion: Depending on the access restrictions of the 
#/etc/security/access.conf file, if the group owner were not a 
#privileged group, it could endanger system security.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check access configuration group ownership:
#
# ls -lL /etc/security/access.conf
#
#If this file exists and has a group-owner that is not a privileged 
#user, this is a finding.
#
#Fix Text: Use the chgrp command to ensure the group owner is root,
#sys, or bin.
#For example:
# chgrp root /etc/security/access.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00420

#Start-Lockdown

if [ -a "/etc/security/access.conf" ]
  then
    CURGOWN=`stat -c %G /etc/security/access.conf`;

    if [ "$CURGOWN" != "root" ]
      then
        chgrp root /etc/security/access.conf
    fi
  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/security/access.conf does not exist." >> $PDI-error.log
    echo "Could not change group ownership to root" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi

