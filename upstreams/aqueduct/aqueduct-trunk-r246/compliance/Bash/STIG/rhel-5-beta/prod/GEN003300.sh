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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 02-feb-2012 fixed bug that would not add users to the at.deny
# if some but not all system accounts are already listed in it.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-985
#Group Title: The at.deny file
#Rule ID: SV-27383r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003300
#Rule Title: The at.deny file must not be empty if it exists.
#
#Vulnerability Discussion: On some systems, if there is no at.allow file
#and there is an empty at.deny file, then the system assumes that 
#everyone has permission to use the "at" facility. This could create an 
#insecure setting in the case of malicious users or system intruders.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
# more /etc/at.deny
#If the at.deny file exists and is empty, this is a finding.
#
#Fix Text: Add appropriate users to the at.deny file, or remove the 
#empty at.deny file if an at.allow file exists.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003300

#Start-Lockdown
for CURUSER in `awk -F ':' '!/root/{if($3 < 500) print $1}' /etc/passwd`
do

  # If the at.deny exists add the user if not there
  if [ -e "/etc/at.deny" ]
  then
    grep "$CURUSER" /etc/at.deny > /dev/null
    if [ $? -ne 0 ]
    then
      echo "$CURUSER" >> /etc/at.deny
    fi
  fi

done

# Remove emtpy lines(at.deny has one by default?)
if [ -e "/etc/at.deny" ]
then
  sed -i -e '/^\s*$/d' /etc/at.deny
fi
