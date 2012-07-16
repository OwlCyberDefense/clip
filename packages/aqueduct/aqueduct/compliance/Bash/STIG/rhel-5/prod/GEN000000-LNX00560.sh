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
# Group ID (Vulid): V-4339
# Group Title: GEN000000-LNX00560
# Rule ID: SV-37316r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN000000-LNX00560
# Rule Title: The Linux NFS Server must not have the insecure file 
# locking option.
#
# Vulnerability Discussion: Insecure file locking could allow for 
# sensitive data to be viewed or edited by an unauthorized user.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Determine if an NFS server is running on the system by:
     
# ps -ef |grep nfsd

# If an NFS server is running, confirm it is not configured with the 
# insecure_locks option by:

# exportfs -v

# The example below would be a finding:

#       /misc/export       speedy.example.com(rw,insecure_locks)
#
# Fix Text: 
#
# Remove the "insecure_locks" option from all NFS exports on the system.

# Procedure:

# Edit /etc/exports and remove all instances of the insecure_locks option.

# Re-export the file systems to make the setting take effect.
# exportfs -a  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00560
	
# Start-Lockdown

grep insecure_locks /etc/exports > /dev/null
if [ $? -eq 0 ]
then
  sed -i 's/(insecure_locks,/(/g' /etc/exports 
  sed -i 's/,insecure_locks)/)/g' /etc/exports 
  sed -i 's/,insecure_locks,/,/g' /etc/exports 
fi
