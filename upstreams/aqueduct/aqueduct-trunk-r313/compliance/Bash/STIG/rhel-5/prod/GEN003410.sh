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
# Group ID (Vulid): V-22395
# Group Title: GEN003410
# Rule ID: SV-37523r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003410
# Rule Title: The "at" directory must not have an extended ACL.
#
# Vulnerability Discussion: If the "at" directory has an extended ACL, 
# unauthorized users could be allowed to view or to edit files containing 
# sensitive information within the "at" directory.  Unauthorized 
# modifications could result in Denial of Service to authorized "at" jobs.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the permissions of the directory.
# ls -lLd /var/spool/at
# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.
#
# Fix Text: 
#
# Remove the extended ACL from the directory.
# setfacl --remove-all /var/spool/at     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003410
	
# Start-Lockdown

for ATFILE in /var/spool/cron/atjobs /var/spool/atjobs /var/spool/at
do

  if [ -a "$ATFILE" ]
  then

    ACLOUT=`getfacl --skip-base $ATFILE 2>/dev/null`;
    if [ "$ACLOUT" != "" ]
      then
      setfacl --remove-all $ATFILE
    fi

  fi

done