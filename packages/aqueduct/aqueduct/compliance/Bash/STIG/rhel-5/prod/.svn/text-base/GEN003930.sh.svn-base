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
# Group ID (Vulid): V-22435
# Group Title: GEN003930
# Rule ID: SV-37449r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003930
# Rule Title: The hosts.lpd (or equivalent) file must be group-owned by 
# root, bin, sys, or system.
#
# Vulnerability Discussion: Failure to give group-ownership of  the 
# hosts.lpd file to root, bin, sys, or system provides the members of the 
# owning group and possible unauthorized users, with the potential to 
# modify the hosts.lpd file.  Unauthorized modifications could disrupt 
# access to local printers from authorized remote hosts or permit 
# unauthorized remote access to local printers.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group ownership of the /etc/cups/printers.conf file.

# Procedure:
# ls -lL /etc/cups/printers.conf

# If the file is not group-owned by lp, this is a finding.


#
# Fix Text: 
#
# Change the group-owner of the printers.conf file.

# Procedure:
# chgrp lp /etc/cups/printers.conf     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003930
	
# Start-Lockdown

#Start-Lockdown

if [ -a "/etc/cups/printers.conf" ]
then
  CURGROUP=`stat -c %G /etc/cups/printers.conf`;
  if [  "$CURGROUP" != "lp" ]
  then
      chgrp lp /etc/cups/printers.conf
  fi
fi
