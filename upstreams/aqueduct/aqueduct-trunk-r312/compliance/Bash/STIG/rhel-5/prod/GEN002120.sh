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
# Group ID (Vulid): V-916
# Group Title: GEN002120
# Rule ID: SV-37390r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002120
# Rule Title: The /etc/shells (or equivalent) file must exist.
#
# Vulnerability Discussion: The shells file (or equivalent) lists 
# approved default shells. It helps provide layered defense to the security 
# approach by ensuring users cannot change their default shell to an 
# unauthorized unsecure shell.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify /etc/shells exists.
# ls -l /etc/shells
# If the file does not exist, this is a finding.
#
# Fix Text: 
#
# Create a /etc/shells file containing a list of valid system shells. 
# Consult vendor documentation for an appropriate list of system shells.

# Procedure:
# echo "/bin/bash" >> /etc/shells
# echo "/bin/csh" >> /etc/shells
# (Repeat as necessary for other shells.)  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002120
	
# Start-Lockdown

if [ ! -f "/etc/shells" ];
then

  cat <<EOF > /etc/shells
/bin/sh
/bin/bash
/bin/tcsh
/bin/csh
/bin/ksh
EOF

  chown root:root /etc/shells
  chmod 644 /etc/shells
  chcon system_u:object_r:etc_t /etc/shells

fi


