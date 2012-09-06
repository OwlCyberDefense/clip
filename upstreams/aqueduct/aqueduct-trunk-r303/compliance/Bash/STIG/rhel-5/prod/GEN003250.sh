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
# Group ID (Vulid): V-22391
# Group Title: GEN003250
# Rule ID: SV-37499r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003250
# Rule Title: The cron.allow file must be group-owned by root, bin, sys, 
# or cron.
#
# Vulnerability Discussion: If the group of the cron.allow is not set to 
# root, bin, sys, or cron, the possibility exists for an unauthorized user 
# to view or edit the list of users permitted to use cron.  Unauthorized 
# modification of this file could cause Denial of Service to authorized 
# cron users or provide unauthorized users with the ability to run cron 
# jobs.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group ownership of the file.

# Procedure:
# ls -lL /etc/cron.allow

# If the file exists and is not group-owned by root, bin, sys or cron, this 
# is a finding.
#
# Fix Text: 
#
# Change the group ownership of the file.

# Procedure:
# chgrp root /etc/cron.allow  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003250
	
# Start-Lockdown

if [ -e "/etc/cron.allow" ]
  then
    CURGOWN=`stat -c %G /etc/cron.allow`;
      if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "cron" ]
        then
          chgrp root /etc/cron.allow
      fi
fi
