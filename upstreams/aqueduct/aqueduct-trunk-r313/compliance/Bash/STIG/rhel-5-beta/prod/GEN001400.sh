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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on 
# 30-dec-2011.  Added a check for existing permissions before making a change.




#######################DISA INFORMATION###############################
#Group ID (Vulid): V-797
#Group Title: /etc/passwd and/or /etc/shadow File Ownership
#Rule ID: SV-797r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001400
#Rule Title: The /etc/shadow (or equivalent) file must be owned by root.
#
#Vulnerability Discussion: The /etc/shadow file contains the list of 
#local system accounts. It is vital to system security and must be 
#protected from unauthorized modification. Failure to give ownership 
#of sensitive files or utilities to root or bin provides the designated 
#owner and unauthorized users with the potential to access sensitive 
#information or change the system configuration which could weaken the 
#system's security posture.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the /etc/shadow file.
# ls -lL /etc/shadow
#If the /etc/shadow file is not owned by root, this is a finding.
#
#
#Fix Text: Change the ownership of the /etc/shadow (or equivalent) file. 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001400

#Start-Lockdown

if [ -a "/etc/shadow" ]
  then
  CUROWN=`stat -c %U /etc/shadow`;
  if [ "$CUROWN" != "root" ]
  then
    chown root /etc/shadow
  fi
  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/shadow does not exist." >> $PDI-error.log
    echo "Could not change ownership to root" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi



