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
# on 28-dec-2011 to include an ownership check before running.
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1025
#Group Title: Access File Ownership
#Rule ID: SV-1025r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000000-LNX00400
#Rule Title: The /etc/security/access.conf file must be owned by root.
#
#Vulnerability Discussion: The /etc/security/access.conf file contains 
#entries that restrict access from the system console by authorized 
#System Administrators. If the file were owned by a user other than 
#root, it could compromise the system.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check access configuration ownership:
#
# ls -lL /etc/security/access.conf
#
#If this file exists and is not owned by root, this is a finding.
#
#
#Fix Text: Follow the correct configuration parameters for access 
#configuration file. Use the chown command to configure it properly.
#For example:
# chown root /etc/security/access.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00400

#Start-Lockdown

if [ -a "/etc/security/access.conf" ]
  then

  CUROWN=`stat -c %U /etc/security/access.conf`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /etc/security/access.conf
  fi

  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/security/access.conf does not exist." >> $PDI-error.log
    echo "Could not change ownership to root" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi

