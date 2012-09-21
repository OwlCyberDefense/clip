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
# Group ID (Vulid): V-762
# Group Title: GEN000320
# Rule ID: SV-27068r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000320
# Rule Title: All accounts must be assigned unique User Identification 
# Numbers (UIDs).
#
# Vulnerability Discussion: Accounts sharing a UID have full access to 
# each others' files.  This has the same effect as sharing a login.  There 
# is no way to assure identification, authentication, and accountability 
# because the system sees them as the same user. If the duplicate UID is 0, 
# this gives potential intruders another privileged account to attack.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Perform the following to ensure there are no duplicate UIDs:

# cut -d: -f3 /etc/passwd | uniq -d

# If any duplicate UIDs are found, this is a finding.
#
# Fix Text: 
#
# Edit user accounts to provide unique UIDs for each account.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000320
	
# Start-Lockdown

DUPUID=`awk -F ':' '{print $3}' /etc/passwd | sort | uniq -d | tr "\n" " "`
if [ "$DUPUID" != "" ]
then
  echo "------------------------------" > $PDI-error.log
  date >> $PDI-error.log
  echo " " >> $PDI-error.log
  echo "The following uids are duplicates: $DUPUID" >> $PDI-error.log
  echo " " >> $PDI-error.log
  echo "Please review these accounts" >> $PDI-error.log
  echo "------------------------------" >> $PDI-error.log
fi
