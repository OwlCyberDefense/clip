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
# Group ID (Vulid): V-790
# Group Title: GEN001340
# Rule ID: SV-41577r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001340
# Rule Title: NIS/NIS+/yp files must be group-owned by root, sys, or bin.
#
# Vulnerability Discussion: NIS/NIS+/yp files are part of the system's 
# identification and authentication processes and are, therefore, critical 
# to system security.  Failure to give ownership of sensitive files or 
# utilities to root or bin provides the designated owner and unauthorized 
# users with the potential to access sensitive information or change the 
# system configuration which could weaken the system's security posture.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Perform the following to check NIS file ownership:

# ls -la /var/yp/*

# If the file group ownership is not root, sys, or bin, this is a finding.

#
# Fix Text: 
#
# Perform the following to change NIS file ownership.

# chown root /var/yp/*  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001340
	
# Start-Lockdown
if [ -d '/var/yp' ]
then
  for CURFILE in `find /var/yp -type f`
  do
    CUROWN=`stat -c %U $CURFILE`;
    if [ "$CUROWN" != "root" -a "$CUROWN" != "root" -a "$CUROWN" != "bin" -a "$CUROWN" != "sys" -a "$CUROWN" != "system" ]
    then
      chown root $CURFILE
    fi
  done
fi
