#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
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
##########################################################################

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-781
# Group Title: GEN000380
# Rule ID: SV-27072r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN000380
# Rule Title: All GIDs referenced in the /etc/passwd file must be defined 
# in the /etc/group file.
#
# Vulnerability Discussion: If a user is assigned the GID of a group not 
# existing on the system, and a group with the GID is subsequently created, 
# the user may have unintended rights to the group.

#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Perform the following to ensure there are no GIDs referenced in 
# /etc/passwd not defined in /etc/group:
# pwck -r
# If GIDs referenced in /etc/passwd are not defined in /etc/group are 
# returned, this is a finding.
#
# Fix Text: 
#
# Add a group to the system for each GID referenced without a 
# corresponding group.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000380
	
# Start-Lockdown

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
    BGIDUSER=`awk -F ':' '{print $4"("$1")"}' /etc/passwd | grep "^${UGID}("`
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
