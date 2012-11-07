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
# Group ID (Vulid): V-4365
# Group Title: GEN003420
# Rule ID: SV-37527r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003420
# Rule Title: The at directory must be owned by root, bin, sys, daemon, 
# or cron.
#
# Vulnerability Discussion: If the owner of the "at" directory is not 
# root, bin, or sys, unauthorized users could be allowed to view or edit 
# files containing sensitive information within the directory.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the ownership of the "at" directory:

# Procedure:
# ls -ld /var/spool/at

# If the directory is not owned by root, sys, bin, daemon, or cron, this is 
# a finding.

# Fix Text: Change the owner of the "at" directory to root, bin, sys, or 
# system.
#
# Fix Text: 
#
# Change the owner of the "at" directory to root, bin, sys, or system.

# Procedure:
# chown <root or other system account> <"at" directory>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003420
	
# Start-Lockdown

for ATFILE in /var/spool/cron/atjobs /var/spool/atjobs /var/spool/at
do
  if [ -a "$ATFILE" ]
  then
    CUROWN=`stat -c %U $ATFILE`;
    if [ "$CUROWN" != "root" -a "$CUROWN" != "sys" -a "$CUROWN" != "bin" -a "$CUROWN" != "daemon" -a "$CUROWN" != "system" -a "$CUROWN" != "cron" ]
      then
        chown daemon $ATFILE
    fi
  fi
done