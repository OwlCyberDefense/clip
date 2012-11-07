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

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-985
# Group Title: GEN003300
# Rule ID: SV-37516r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003300
# Rule Title: The at.deny file must not be empty if it exists.
#
# Vulnerability Discussion: On some systems, if there is no at.allow file 
# and there is an empty at.deny file, then the system assumes everyone has 
# permission to use the "at" facility.  This could create an insecure 
# setting in the case of malicious users or system intruders.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# # more /etc/at.deny
# If the at.deny file exists and is empty, this is a finding.
#
# Fix Text: 
#
# Add appropriate users to the at.deny file, or remove the empty at.deny 
# file if an at.allow file exists.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003300
	
# Start-Lockdown

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