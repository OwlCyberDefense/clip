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
#Group ID (Vulid): V-12039
#Group Title: /etc/securetty ownership
#Rule ID: SV-12540r2_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000000-LNX00640
#Rule Title: The /etc/securetty file must be owned by root.
#
#Vulnerability Discussion: The securetty file contains the list of 
#terminals that permit direct root logins. It must be protected 
#from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check /etc/securetty ownership.
#
#Procedure:
# ls -lL /etc/securetty
#
#If /etc/securetty is not owned by root, this is a finding.
#
#Fix Text: Change the owner of the /etc/securetty file to root.
#
#Procedure:
# chown root /etc/securetty   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00640

#Start-Lockdown

if [ -a "/etc/securetty" ]
  then
    CUROWN=`stat -c %U /etc/securetty`;
    if [ "$CUROWN" != "root" ]
      then
        chown root /etc/securetty
    fi
  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/securetty does not exist." >> $PDI-error.log
    echo "Could not change ownership to root" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi


