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
# Group ID (Vulid): V-22348
# Group Title: GEN001475
# Rule ID: SV-37383r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001475
# Rule Title: The /etc/group file must not contain any group password 
# hashes.
#
# Vulnerability Discussion: Group passwords are typically shared and 
# should not be used.  Additionally, if password hashes are readable by 
# non-administrators, the passwords are subject to attack through lookup 
# tables or cryptographic weaknesses in the hashes.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the /etc/group file for password hashes.
# cut -d : -f 2 /etc/group | egrep -v '^(x|!)$'
# If any password hashes are returned, this is a finding.


#
# Fix Text: 
#
# Edit /etc/group and change the password field to an exclamation point 
# (!) to lock the group password.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001475
	
# Start-Lockdown

# Lets go ahead and make sure an error is reported just in case.
BADHASH=`awk -F ':' '{if($2 != "x" && $2 != "*") print $1}' /etc/group | tr "\n" " "`  
if [ "$BADHASH" != "" ]
then

  echo "------------------------------" > $PDI-error.log
  date >> $PDI-error.log
  echo " " >> $PDI-error.log
  echo "$PDI: The following groups have password hashes in the /etc/group file." >> $PDI-error.log
  echo "${BADHASH}" >> $PDI-error.log
  echo "------------------------------" >> $PDI-error.log

fi
