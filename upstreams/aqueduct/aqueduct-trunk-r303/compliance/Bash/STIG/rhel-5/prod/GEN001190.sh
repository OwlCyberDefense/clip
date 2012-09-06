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
# Group ID (Vulid): V-22313
# Group Title: GEN001190
# Rule ID: SV-37199r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001190
# Rule Title: All network services daemon files must not have extended 
# ACLs.
#
# Vulnerability Discussion: Restricting permission on daemons will 
# protect them from unauthorized modification and possible system 
# compromise.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check network services daemon files have no extended ACLs.

# ls -la /usr/sbin

# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.

# Note: Network daemons not residing in these directories must also be 
# checked.
#
# Fix Text: 
#
# Remove the extended ACL from the file.
# setfacl --remove-all /usr/sbin/*  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001190
	
# Start-Lockdown

for CURFILE in `find /usr/sbin/ ! -type l`
do
  if [ -e "$CURFILE" ]
  then
    ACLOUT=`getfacl --skip-base $CURFILE 2>/dev/null`;
    if [ "$ACLOUT" != "" ]
      then
      setfacl --remove-all $CURFILE
    fi

  fi
done

