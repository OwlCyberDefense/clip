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
# Group ID (Vulid): V-1026
# Group Title: GEN006080
# Rule ID: SV-37870r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006080
# Rule Title: The Samba Web Administration Tool (SWAT) must be restricted 
# to the local host or require SSL.
#
# Vulnerability Discussion: SWAT is a tool used to configure Samba.  It 
# modifies Samba configuration, which can impact system security, and must 
# be protected from unauthorized access.  SWAT authentication may involve 
# the root password, which must be protected by encryption when traversing 
# the network.

# Restricting access to the local host allows for the use of SSH TCP 
# forwarding, if configured, or administration by a web browser on the 
# local system.
#
# Responsibility: System Administrator
# IAControls: EBRP-1, ECCT-1, ECCT-2
#
# Check Content:
#
# SWAT is a tool for configuring Samba and should only be found on a 
# system with a requirement for Samba. If SWAT is used, it must be utilized 
# with SSL to ensure a secure connection between the client and the server.

# Procedure:

# grep -H "bin/swat" /etc/xinetd.d/*|cut -d: -f1 |xargs grep "only_from"

# If the value of the "only_from" line in the "xinetd.d" file which starts 
# "/usr/sbin/swat" is not "localhost" or the equivalent, this is a finding.
#
# Fix Text: 
#
# Disable SWAT or require SWAT is only accessed via SSH.

# Procedure:
# If SWAT is not needed for operation of the system remove the SWAT package:
# rpm -qa|grep swat

# Remove "samba-swat" or "samba3x-swat" depending on which one is installed
# rpm --erase samba-swat
# or
# rpm --erase samba3x-swat

# If SWAT is required but not at all times disable it when it is not needed.
# Modify the /etc/xinetd.d file for "swat" to contain a "disable = yes" 
# line.

# To access using SSH:
# Follow vendor configuration documentation to create an stunnel for SWAT.

  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006080
	
# Start-Lockdown

