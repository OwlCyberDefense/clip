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
# Group ID (Vulid): V-831
# Group Title: GEN004360
# Rule ID: SV-37472r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004360
# Rule Title: The alias file must be owned by root.
#
# Vulnerability Discussion: If the alias file is not owned by root, an 
# unauthorized user may modify the file adding aliases to run malicious 
# code or redirect e-mail.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the ownership of the alias files.

# Procedure:
# for sendmail:
# ls -lL /etc/aliases
# ls -lL /etc/aliases.db
# If all the files are not owned by root, this is a finding.

# for postfix:
# Verify the location of the alias file.
# postconf alias maps

# This will return the location of the "aliases" file, by default 
# "/etc/postfix/aliases"

# ls -lL <postfix aliases file>
# ls -lL <postfix aliases.db file>
# If all the files are not owned by root, this is a finding.


#
# Fix Text: 
#
# Change the owner of the /etc/aliases file to root.

# Procedure:
# for sendmail:
# chown root /etc/aliases
# chown root /etc/aliases.db

# for postfix
# chown root /etc/postfix/aliases
# chown root /etc/postfix/aliases.db
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004360
	
# Start-Lockdown

if [ -a "/etc/aliases" ]
then
  CUROWN=`stat -c %U /etc/aliases`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /etc/aliases
  fi
fi

if [ -a "/etc/aliases.db" ]
then
  CUROWN=`stat -c %U /etc/aliases.db`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /etc/aliases.db
  fi
fi
