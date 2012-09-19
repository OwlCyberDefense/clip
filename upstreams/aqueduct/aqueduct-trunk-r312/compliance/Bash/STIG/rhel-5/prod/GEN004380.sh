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
# Group ID (Vulid): V-832
# Group Title: GEN004380
# Rule ID: SV-37475r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004380
# Rule Title: The alias file must have mode 0644 or less permissive.
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
# If an alias file has a mode more permissive than 0644, this is a finding.

# for postfix:
# Verify the location of the alias file.
# postconf alias maps

# This will return the location of the "aliases" file, by default 
# "/etc/postfix/aliases"

# ls -lL <postfix aliases file> <postfix aliases.db file>
# If an alias file has a mode more permissive than 0644, this is a finding.


#
# Fix Text: 
#
# Change the mode of the alias files as needed to function. No higher 
# than 0644.
# Procedure:
# for sendmail:
# chmod 0644 /etc/aliases /etc/aliases.db

# for postfix (assuming the default postfix directory):
# chmod 0644 /etc/postfix/aliases /etc/postfix/aliases.db     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004380
	
# Start-Lockdown

if [ -a "/etc/aliases" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/aliases`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7133)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&3)) != "0" ]
      then
        chmod u-xs,g-wxs,o-wxt /etc/aliases
    fi
fi

if [ -a "/etc/aliases.db" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/aliases.db`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7133)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&3)) != "0" ]
      then
        chmod u-xs,g-wxs,o-wxt /etc/aliases.db
    fi
fi
