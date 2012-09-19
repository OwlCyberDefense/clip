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
# Group ID (Vulid): V-1061
# Group Title: GEN002360
# Rule ID: SV-37577r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002360
# Rule Title: Audio devices must be group-owned by root, sys, bin, or 
# system.
#
# Vulnerability Discussion: Without privileged group owners, audio 
# devices will be vulnerable to being used as eaves-dropping devices by 
# malicious users or intruders to possibly listen to conversations 
# containing sensitive information.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group-owner of audio devices.

# Procedure:
# ls -lL /dev/audio* /dev/snd/*

# If the group-owner of an audio device is not root, sys, bin, or system, 
# this is a finding.
#
# Fix Text: 
#
# Change the group-owner of the audio device.

# Procedure:
# chgrp root <audio device>  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002360
	
# Start-Lockdown

# See udev configuration in GEN002320.sh
