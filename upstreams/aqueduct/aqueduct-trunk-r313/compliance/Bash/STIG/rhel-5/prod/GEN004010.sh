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
# Group ID (Vulid): V-22437
# Group Title: GEN004010
# Rule ID: SV-37468r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004010
# Rule Title: The traceroute file must not have an extended ACL.
#
# Vulnerability Discussion: If an extended ACL exists on the traceroute 
# executable file, it may provide unauthorized users with access to the 
# file.  Malicious code could be inserted by an attacker and triggered 
# whenever the traceroute command is executed by authorized users.  
# Additionally, if an unauthorized user is granted executable permissions 
# to the traceroute command, it could be used to gain information about the 
# network topology behind the firewall.  This information may allow an 
# attacker to determine trusted routers and other network information 
# potentially leading to system and network compromise.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the permissions of the /bin/traceroute file.
# ls -lL /bin/traceroute
# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.


#
# Fix Text: 
#
# Remove the extended ACL from the file.
# setfacl --remove-all /bin/traceroute     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004010
	
# Start-Lockdown

if [ -a "/bin/traceroute" ]
then
  ACLOUT=`getfacl --skip-base /bin/traceroute 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all /bin/traceroute
  fi
fi
