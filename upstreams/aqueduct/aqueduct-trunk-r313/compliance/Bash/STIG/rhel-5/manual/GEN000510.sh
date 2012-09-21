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
# Group ID (Vulid): V-22301
# Group Title: GEN000510
# Rule ID: SV-37222r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN000510
# Rule Title: The system must display a publicly-viewable pattern during 
# a graphical desktop environment session lock.
#
# Vulnerability Discussion: To protect the on-screen content of a 
# session, it must be replaced with a publicly-viewable pattern upon 
# session lock. Examples of publicly viewable patterns include screen saver 
# patterns, photographic images, solid colors, or a blank screen, so long 
# as none of those patterns convey sensitive information.

# This requirement applies to graphical desktop environments provided by 
# the system to locally attached displays and input devices, as well as, to 
# graphical desktop environments provided to remote systems using remote 
# access protocols.
#
# Responsibility: System Administrator
# IAControls: PESL-1
#
# Check Content:
#
# Determine if a publicly-viewable pattern is displayed during a session 
# lock. Some screensaver themes available but not included in the RHEL 
# distribution use a snapshot of the current screen as a graphic. This 
# theme does not qualify as a publicly-viewable pattern. If the session 
# lock pattern is not publicly-viewable this is a finding.
#
# Fix Text: 
#
# Configure the system to display a publicly-viewable pattern during a 
# session lock. This is done graphically by selecting a screensaver theme 
# using gnome-screensaver-preferences command. Any of the themes 
# distributed with RHEL may be used including "Blank Screen".    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000510
	
# Start-Lockdown

#This is default for RHEL to go 'blank', not going to mess with this. 

