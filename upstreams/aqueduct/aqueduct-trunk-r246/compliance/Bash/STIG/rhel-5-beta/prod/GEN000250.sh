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
#Group ID (Vulid): V-22294
#Group Title: GEN000250
#Rule ID: SV-26294r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000250
#Rule Title: The time synchronization configuration file 
#(such as /etc/ntp.conf) must be owned by root.
#
#Vulnerability Discussion: A synchronized system clock is critical 
#for the enforcement of time-based policies and the correlation of 
#logs and audit records with other systems. If an illicit time source 
#is used for synchronization, the integrity of system logs and the 
#security of the system could be compromised. If the configuration 
#files controlling time synchronization are not owned by a system 
#account, unauthorized modifications could result in the failure 
#of time synchronization.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the NTP configuration file.
# ls -l /etc/ntp.conf
#If the owner is not root, this is a finding.
#
#Fix Text: Change the owner of the NTP configuration file.
# chown root /etc/ntp.conf 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000250

#Start-Lockdown

if [ -a "/etc/ntp.conf" ]
  then
    CUROWN=`stat -c %U /etc/ntp.conf`;
    if [ "$CUROWN" != "root" ]
      then
        chown root /etc/ntp.conf
    fi
  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/ntp.conf does not exist." >> $PDI-error.log
    echo "Could not change ownership to root" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi


