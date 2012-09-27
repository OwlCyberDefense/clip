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
# Group ID (Vulid): V-22439
# Group Title: GEN004390
# Rule ID: SV-37488r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004390
# Rule Title: The alias file must not have an extended ACL.
#
# Vulnerability Discussion: Excessive permissions on the aliases file may 
# permit unauthorized modification.  If the alias file is modified by an 
# unauthorized user, they may modify the file to run malicious code or 
# redirect e-mail.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the permissions of the alias file.

# Procedure:
# for sendmail:
# ls -lL /etc/aliases /etc/aliases.db
# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.

# for postfix:
# Verify the location of the alias file.
# postconf alias maps

# This will return the location of the "aliases" file, by default 
# "/etc/postfix/aliases"

# ls -lL <postfix aliases file> <postfix aliases.db file>
# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.


#
# Fix Text: 
#
# Remove the extended permissions from the alias files.
# Procedure:
# for sendmail:
# setfacl --remove-all /etc/aliases /etc/aliases.db

# for postfix (assuming the default postfix directory):
# setfacl --remove-all /etc/postfix/aliases /etc/postfix/aliases.db     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004390
	
# Start-Lockdown

if [ -a "/etc/aliases" ]
then
  ACLOUT=`getfacl --skip-base /etc/aliases 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all /etc/aliases
  fi
fi

if [ -a "/etc/aliases.db" ]
then
  ACLOUT=`getfacl --skip-base /etc/aliases.db 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all /etc/aliases.db
  fi
fi
