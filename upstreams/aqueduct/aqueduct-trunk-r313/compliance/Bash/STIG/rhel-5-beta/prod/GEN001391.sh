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
#Group ID (Vulid): V-22335
#Group Title: GEN001391
#Rule ID: SV-26431r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001391
#Rule Title: The /etc/group file must be owned by root.
#
#Vulnerability Discussion: The /etc/group file is critical to system 
#security and must be owned by a privileged user. The group file 
#contains a list of system groups and associated information.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that the /etc/group file is owned by root.
# ls -l /etc/group
#If the file is not owned by root, this is a finding.
#
#Fix Text: Change the owner of the /etc/group file to root.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001391

#Start-Lockdown

if [ -a "/etc/group" ]
  then
  CUROWN=`stat -c %U /etc/group`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /etc/group
  fi
  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/group does not exist." >> $PDI-error.log
    echo "Could not change ownership to root" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi



