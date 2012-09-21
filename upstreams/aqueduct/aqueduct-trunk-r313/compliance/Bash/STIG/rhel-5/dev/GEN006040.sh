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
# Group ID (Vulid): V-12025
# Group Title: GEN006040
# Rule ID: SV-37865r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006040
# Rule Title: The system must not have any peer-to-peer file-sharing 
# application installed.
#
# Vulnerability Discussion: Peer-to-peer file-sharing software can result 
# in the unintentional exfiltration of information.  There are also many 
# legal issues associated with these types of utilities including copyright 
# infringement or other intellectual property issues.  The ASD Memo "Use of 
# Peer-to-Peer (P2P) File-Sharing Applications across the DoD" states the 
# following:

# “P2P file-sharing applications are authorized for use on DOD networks 
# with approval by the appropriate Designated Approval Authority (DAA).  
# Documented requirements, security architecture, configuration management 
# process, and a training program for users are all requirements within the 
# approval process.  The unauthorized use of application or services, 
# including P2P applications, is prohibited, and such applications or 
# services must be eliminated.”

# P2P applications include, but are not limited to, the following:

# -Napster
# -Kazaa
# -ARES
# -Limewire
# -IRC Chat Relay
# -BitTorrent
#
# Responsibility: System Administrator
# IAControls: DCPD-1, ECSC-1
#
# Check Content:
#
# Ask the SA if any peer-to-peer file-sharing applications are installed. 
# Some examples of these applications include:

# - Napster
# - Kazaa
# - ARES
# - Limewire
# - IRC Chat Relay
# - BitTorrent

# If any of these applications are installed, this is a finding.


#
# Fix Text: 
#
# Uninstall the peer-to-peer file sharing application(s) from the system. 
   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006040
	
# Start-Lockdown

