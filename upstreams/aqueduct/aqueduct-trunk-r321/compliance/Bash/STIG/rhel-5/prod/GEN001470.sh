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
# Group ID (Vulid): V-22347
# Group Title: GEN001470
# Rule ID: SV-37381r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001470
# Rule Title: The /etc/passwd file must not contain password hashes.
#
# Vulnerability Discussion: If password hashes are readable by 
# non-administrators, the passwords are subject to attack through lookup 
# tables or cryptographic weaknesses in the hashes.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Verify no password hashes are present in /etc/passwd.
# cut -d : -f 2 /etc/passwd | grep -v '^(x|\*)$'
# If any password hashes are returned, this is a finding.


#
# Fix Text: 
#
# Migrate /etc/passwd password hashes to /etc/shadow.
# pwconv     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001470
	
# Start-Lockdown

# Lets go ahead and make sure an error is reported just in case.
BADHASH=`awk -F ':' '{if($2 != "x" && $2 != "*") print $1}' /etc/passwd | tr "\n" " "`  
if [ "$BADHASH" != "" ]
then

  echo "------------------------------" > $PDI-error.log
  date >> $PDI-error.log
  echo " " >> $PDI-error.log
  echo "$PDI: The following users have password hashes in the /etc/passwd file." >> $PDI-error.log
  echo "${BADHASH}" >> $PDI-error.log
  echo "------------------------------" >> $PDI-error.log

fi

