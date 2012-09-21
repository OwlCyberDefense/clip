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
# Group ID (Vulid): V-22369
# Group Title: GEN002710
# Rule ID: SV-37917r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002710
# Rule Title: All system audit files must not have extended ACLs.
#
# Vulnerability Discussion: If a user can write to the audit logs, then 
# audit trails can be modified or destroyed and system intrusion may not be 
# detected.
#
# Responsibility: System Administrator
# IAControls: ECTP-1
#
# Check Content:
#
# Check the system audit log files for extended ACLs.

# Procedure:
# grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs ls -l

# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.


#
# Fix Text: 
#
# Remove the extended ACL from the system audit file(s).  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002710
LOGACLFILES=$( grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs ls -l | awk '{print $9}' )
BADLOGACLFILES=$( for line in $LOGACLFILES ; do getfacl --absolute-names --skip-base $line| grep "# file:" | cut -d ":" -f 2 ; done )

#Start-Lockdown

for file in $BADLOGACLFILES
  do
    setfacl --remove-all $file
done

