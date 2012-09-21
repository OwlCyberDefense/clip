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
# Group ID (Vulid): V-22396
# Group Title: GEN003430
# Rule ID: SV-37529r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003430
# Rule Title: The "at" directory must be group-owned by root, bin, sys, 
# or cron.
#
# Vulnerability Discussion: If the group of the "at" directory is not 
# root, bin, sys, or cron, unauthorized users could be allowed to view or 
# edit files containing sensitive information within the directory.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group ownership of the file.

# Procedure:
# ls -lL /var/spool/at

# If the file is not group-owned by root, bin, sys, daemon or cron, this is 
# a finding.
#
# Fix Text: 
#
# Change the group ownership of the file to root, bin, sys, daemon or 
# cron.

# Procedure:
# chgrp <root or other system group> <"at" directory>   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003430
	
# Start-Lockdown

for ATFILE in /var/spool/cron/atjobs /var/spool/atjobs /var/spool/at
do
  if [ -a "$ATFILE" ]
  then
    CURGOWN=`stat -c %G $ATFILE`;
    if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "daemon" -a "$CURGOWN" != "system" -a "$CURGOWN" != "cron" ]
      then
        chgrp daemon $ATFILE
    fi
  fi
done