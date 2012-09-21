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
# Group ID (Vulid): V-11976
# Group Title: GEN000700
# Rule ID: SV-37298r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000700
# Rule Title: User passwords must be changed at least every 60 days.
#
# Vulnerability Discussion: Limiting the lifespan of authenticators 
# limits the period of time an unauthorized user has access to the system 
# while using compromised credentials and reduces the period of time 
# available for password-guessing attacks to run against a single password.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Check the max days field (the 5th field) of /etc/shadow.
# more /etc/shadow
# If the max days field is equal to 0 or greater than 60 for any user, this 
# is a finding.
#
# Fix Text: 
#
# Set the max days field to 60 for all user accounts.
# passwd -x 60 <user>  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000700
	
# Start-Lockdown

for ACCOUNT in `awk -F ':' '{if($5 != 60) print $1}' /etc/shadow`
do
  passwd -x 60 $ACCOUNT > /dev/null
done

grep '^PASS_MAX_DAYS' /etc/login.defs > /dev/null
if [ $? -eq 0 ]
then
  PASS_MAX_DAYS=`awk '/PASS_MAX_DAYS/{print $2}' /etc/login.defs`
  if [ "$PASS_MAX_DAYS" != "60" ]
  then
    sed -i -e 's/\(PASS_MAX_DAYS[^0-9]*\).*/\160/g' /etc/login.defs
  fi
else
  echo "" >> /etc/login.defs
  echo "# Added for STIG id GEN000700" >> /etc/login.defs
  echo 'PASS_MAX_DAYS   60' >> /etc/login.defs
fi

