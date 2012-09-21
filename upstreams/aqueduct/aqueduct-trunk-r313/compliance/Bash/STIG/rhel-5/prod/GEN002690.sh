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
# Group ID (Vulid): V-22702
# Group Title: GEN002690
# Rule ID: SV-37914r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002690
# Rule Title: System audit logs must be group-owned by root, bin, sys, or 
# system.
#
# Vulnerability Discussion: Sensitive system and user information could 
# provide a malicious user with enough information to penetrate further 
# into the system.
#
# Responsibility: System Administrator
# IAControls: ECLP-1, ECTP-1
#
# Check Content:
#
# Check the group ownership of the audit logs.

# Procedure:
# grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs stat -c 
# %G:%n

# If any audit log file is not group-owned by root, bin, sys, or system, 
# this is a finding.


#
# Fix Text: 
#
# Change the group ownership of the audit log file(s).

# Procedure:
# chgrp root <audit log file>  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002690
LOGFILES=$( grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs stat -c %G:%n | cut -d ":" -f 2 )
BADELOGFILES=$( for line in $LOGFILES; do find $line ! -group root ! -group sys ! -group bin ; done )

#Start-Lockdown

for file in $BADELOGFILES
  do
    chgrp root $file
done

