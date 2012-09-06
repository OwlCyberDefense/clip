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
# Group ID (Vulid): V-22446
# Group Title: GEN005190
# Rule ID: SV-37682r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005190
# Rule Title: The .Xauthority files must not have extended ACLs.
#
# Vulnerability Discussion: .Xauthority files ensure the user is 
# authorized to access specific X Windows host. Extended ACLs may permit 
# unauthorized modification of these files, which could lead to Denial of 
# Service to authorized access or allow unauthorized access to be obtained.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the file permissions for the .Xauthority files.  These files will 
# be located in user home directories.

# Procedure:
# ls -la ~username |egrep "(\.Xauthority|\.xauth)"

# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.
#
# Fix Text: 
#
# Remove the extended ACL from the file.
# setfacl --remove-all .Xauthority     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005190
XAUTHFILE=$( find / -fstype nfs -prune -o -name *.xauth 2> /dev/null )
XAUTHORITYFILE=$(find / -fstype nfs -prune -o -name *.Xauthority 2> /dev/null )

#Start-Lockdown

for line in $XAUTHFILE
  do
    if [ -a $line ]
      then
       ACLOUT=`getfacl --skip-base $line 2>/dev/null`;
          if [ "$ACLOUT" != "" ]
          then
            setfacl --remove-all $line
          fi
    fi
done

for line in $XAUTHORITYFILE
  do
    if [ -a $line ]
      then
        ACLOUT=`getfacl --skip-base $line 2>/dev/null`;
          if [ "$ACLOUT" != "" ]
          then
            setfacl --remove-all $line
          fi
    fi
done

