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
# Group ID (Vulid): V-789
# Group Title: GEN001320
# Rule ID: SV-37267r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001320
# Rule Title: NIS/NIS+/yp files must be owned by root, sys, or bin.
#
# Vulnerability Discussion: NIS/NIS+/yp files are part of the system's 
# identification and authentication processes and are critical to system 
# security.  Failure to give ownership of sensitive files or utilities to 
# root or bin provides the designated owner and unauthorized users with the 
# potential to access sensitive information or change the system 
# configuration which could weaken the system's security posture.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Perform the following to check NIS file ownership:
# ls -la /var/yp/*;
# If the file ownership is not root, sys, or bin, this is a finding.


#
# Fix Text: 
#
# Change the ownership of NIS/NIS+/yp files to root, sys or bin. 

# Procedure (example):
# chown root <filename>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001320
	
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
