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
# Group ID (Vulid): V-22312
# Group Title: GEN001170
# Rule ID: SV-37165r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001170
# Rule Title: All files and directories must have a valid group-owner.
#
# Vulnerability Discussion: Files without a valid group owner may be 
# unintentionally inherited if a group is assigned the same GID as the GID 
# of the files without a valid group-owner.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Search the system for files without a valid group-owner.
# find / -nogroup 
# If any files are found, this is a finding.


#
# Fix Text: 
#
# Change the group-owner for each file without a valid group-owner.
# chgrp avalidgroup /tmp/a-file-without-a-valid-group-owner     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001170
	
# Start-Lockdown

NOGROUPS=`find / -fstype nfs -prune -o -nogroup 2>/dev/null | wc -l `
if [ $NOGROUPS -ge 1 ]
then
  echo "------------------------------" > $PDI-NOGROUP.log
  date >> $PDI-NOGROUP.log
  echo " " >> $PDI-NOGROUP.log
  echo "The following files don't have proper GROUP ownership." >> $PDI-NOGROUP.log
  echo "Please review and fix as needed" >> $PDI-NOGROUP.log
  echo " " >> $PDI-NOGROUP.log
  find / -fstype nfs -prune -o -nogroup 2>/dev/null >> $PDI-NOGROUP.log
  echo "------------------------------" >> $PDI-NOGROUP.log
fi

