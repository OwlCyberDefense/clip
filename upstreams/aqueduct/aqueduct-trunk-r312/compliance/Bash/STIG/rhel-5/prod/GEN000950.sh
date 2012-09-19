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
# Group ID (Vulid): V-22311
# Group Title: GEN000950
# Rule ID: SV-37364r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000950
# Rule Title: The root account's list of preloaded libraries must be 
# empty.
#
# Vulnerability Discussion: The library preload list environment variable 
# contains a list of libraries for the dynamic linker to load before 
# loading the libraries required by the binary.  If this list contains 
# paths to libraries relative to the current working directory, unintended 
# libraries may be preloaded.  This variable is formatted as a 
# space-separated list of libraries.  Paths starting with (/) are absolute 
# paths.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the LD_PRELOAD environment variable is empty or not defined for 
# the root user.
# echo $LD_PRELOAD
# If a path list is returned, this is a finding.
#
# Fix Text: 
#
# Edit the root user initialization files and remove any definition of 
# LD_PRELOAD.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000950
	
# Start-Lockdown

ROOTHOMEDIR=`cat /etc/passwd | grep -i ^root | cut -d ":" -f 6`
for BADCONFIG in `find $ROOTHOMEDIR -name .bash_profile -print`
do
  sed -i '/LD_PRELOAD/d' $BADCONFIG
done


