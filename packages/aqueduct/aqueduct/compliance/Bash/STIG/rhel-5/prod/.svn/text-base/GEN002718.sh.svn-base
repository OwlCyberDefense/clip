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
# Group ID (Vulid): V-22373
# Group Title: GEN002718
# Rule ID: SV-26513r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN002718
# Rule Title: System audit tool executables must not have extended ACLs.
#
# Vulnerability Discussion: To prevent unauthorized access or 
# manipulation of system audit logs, the tools for manipulating those logs 
# must be protected.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the permissions of audit tool executables.
# ls -l /sbin/auditctl /sbin/auditd /sbin/ausearch /sbin/aureport 
# /sbin/autrace /sbin/audispd 
# If the permissions include a '+' the file has an extended ACL, this is a 
# finding.
#
# Fix Text: 
#
# Remove the extended ACL from the file.
# setfacl --remove-all [audit file]  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002718
	
# Start-Lockdown
for AUDITFILE in /sbin/auditctl /sbin/auditd /sbin/ausearch /sbin/aureport /sbin/autrace /sbin/audispd
do
    ACLOUT=`getfacl --skip-base $AUDITFILE 2>/dev/null`;
    if [ "$ACLOUT" != "" ]
      then
      setfacl --remove-all $AUDITFILE
    fi
done
