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
# Group ID (Vulid): V-1032
# Group Title: GEN000540
# Rule ID: SV-37239r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000540
# Rule Title: Users must not be able to change passwords more than once 
# every 24 hours.
#
# Vulnerability Discussion: The ability to change passwords frequently 
# facilitates users reusing the same password. This can result in users 
# effectively never changing their passwords.  This would be accomplished 
# by users changing their passwords when required and then immediately 
# changing it to the original value.

#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the minimum time period between password changes for each user 
# account is 1 day.
# cat /etc/shadow | cut -d ':' -f 4 | grep -v 1
# If any results are returned, this is a finding.
#
# Fix Text: 
#
#  Change the minimum time period between password changes for each user 
# account to 1 day.
# passwd -n 1 <user name>  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000540
	
# Start-Lockdown

for ACCOUNT in `awk -F ':' '{if($4 != 1) print $1}' /etc/shadow`
do
  passwd -n 1 $ACCOUNT > /dev/null
done

grep '^PASS_MIN_DAYS' /etc/login.defs > /dev/null
if [ $? -eq 0 ]
then
  PASS_MIN_DAYS=`awk '/PASS_MIN_DAYS/{print $2}' /etc/login.defs`
  if [ "$PASS_MIN_DAYS" != "1" ]
  then
    sed -i -e 's/\(PASS_MIN_DAYS[^0-9]*\).*/\11/g' /etc/login.defs
  fi
else
  echo "" >> /etc/login.defs
  echo "# Added for STIG id GEN000540" >> /etc/login.defs
  echo 'PASS_MIN_DAYS   1' >> /etc/login.defs
fi


