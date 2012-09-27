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
#####################Fotis Networks LLC###############################
#By Tummy a.k.a Vincent C. Passaro				     #
#Fotis Networks LLC						     #
#Vincent[.]Passaro[@]fotisnetworks[.]com			     #
#www.fotisnetworks.com						     #
######################Fotis Networks LLC##############################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 30-dec-11 to fix the logic to catch all primary gids associated with
# a user account that do not have a valid group defined in /etc/group.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-781
#Group Title: Groups referenced in /etc/passwd
#Rule ID: SV-27072r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN000380
#Rule Title: All GIDs referenced in the /etc/passwd file must be defined 
#in the /etc/group file.
#
#Vulnerability Discussion: If a user is assigned the GID of a group that 
#does not exist on the system, and a group with that GID is subsequently 
#created, the user may have unintended rights to that group.
#
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Perform the following to ensure that there are no GIDs referenced 
#in /etc/passwd not defined in /etc/group:
# pwck -r
#If GIDs referenced in /etc/passwd are not defined in /etc/group are 
#returned, this is a finding.
#
#Fix Text: Add a group to the system for each GID referenced that does 
#not have a corresponding group.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000380

#Start-Lockdown
BADGIDS=""
VALIDGROUP=0
for UGID in `awk -F ':' '{print $4}' /etc/passwd`
do
  for GGID in `awk -F ':' '{print $3}' /etc/group`
  do
    if [ "$UGID" = "$GGID" ]
    then
      VALIDGROUP=1
    fi
  done

  if [ $VALIDGROUP != 1 ]
  then
    BGIDUSER=`awk -F ':' '{print $3"("$1")"}' /etc/passwd | grep "^${UGID}("`
    BADGIDS="$BADGIDS $BGIDUSER"
  fi
  VALIDGROUP=0

done

if [ "$BADGIDS" != "" ]
then
  echo "------------------------------" > $PDI-error.log
  date >> $PDI-error.log
  echo " " >> $PDI-error.log
  echo "${PDI}: The following user primary GIDs are not valid groups" >> $PDI-error.log
  echo "$BADGIDS" >> $PDI-error.log
  echo "Please review these accounts" >> $PDI-error.log
  echo "------------------------------" >> $PDI-error.log
fi
