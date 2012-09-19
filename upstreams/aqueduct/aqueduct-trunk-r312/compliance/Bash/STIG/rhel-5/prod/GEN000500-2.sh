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
# Group ID (Vulid): V-27283
# Group Title: GEN000500-2
# Rule ID: SV-34582r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000500-2
# Rule Title: The graphical desktop environment must set the idle timeout 
# to no more than 15 minutes.
#
# Vulnerability Discussion: If graphical desktop sessions do not lock the 
# session after 15 minutes of inactivity, requiring re-authentication to 
# resume operations, the system or individual data could be compromised by 
# an alert intruder who could exploit the oversight. This requirement 
# applies to graphical desktop environments provided by the system to 
# locally attached displays and input devices as well as to graphical 
# desktop environments provided to remote systems, including thin clients.
#
# Responsibility: System Administrator
# IAControls: PESL-1
#
# Check Content:
#
# For the Gnome screen saver, check the idle_delay setting.

# Procedure:
# gconftool-2 --direct --config-source 
# xml:readwrite:/etc/gconf/gconf.xml.mandatory --get 
# /apps/gnome-screensaver/idle_delay
# If this does not return 15 or less, this is a finding.
#
# Fix Text: 
#
# For the Gnome screen saver, set idle_delay to 15.

# Procedure:
# gconftool-2 --direct --config-source 
# xml:readwrite:/etc/gconf/gconf.xml.mandatory --type int --set 
# /apps/gnome-screensaver/idle_delay 15  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000500-2
	
# Start-Lockdown

IDLEDELAY=`gconftool-2 --direct --config-source xml:read:/etc/gconf/gconf.xml.mandatory --get /apps/gnome-screensaver/idle_delay 2> /dev/null | awk '!/^Resolved/'`
if [ "$IDLEDELAY" != '15' ]
then
  gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type int --set /apps/gnome-screensaver/idle_delay 15 > /dev/null
fi

