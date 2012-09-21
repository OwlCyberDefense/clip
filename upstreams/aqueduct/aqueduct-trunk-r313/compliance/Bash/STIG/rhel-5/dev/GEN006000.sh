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
# Group ID (Vulid): V-12024
# Group Title: GEN006000
# Rule ID: SV-37862r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006000
# Rule Title: The system must not have a public Instant Messaging (IM) 
# client installed.
#
# Vulnerability Discussion: Public (IM) systems are not approved for use 
# and may result in the unauthorized distribution of information.  IM 
# clients provide a way for a user to send a message to one or more other 
# users in real time.  Additional capabilities may include file transfer 
# and support for distributed game playing.  Communication between clients 
# and associated directory services are managed through messaging servers.  
# Commercial IM clients include AOL Instant Messenger (AIM), MSN Messenger, 
# and Yahoo! Messenger.

# IM clients present a security issue when the clients route messages 
# through public servers.  The obvious implication is potentially sensitive 
# information could be intercepted or altered in the course of 
# transmission.  This same issue is associated with the use of public 
# e-mail servers.  In order to reduce the potential for disclosure of 
# sensitive Government information and to ensure the validity of official 
# government information, IM clients connecting to public IM services will 
# not be installed.  Clients use to access  internal or DoD-controlled IM 
# services are permitted.
#
# Responsibility: System Administrator
# IAControls: ECIM-1
#
# Check Content:
#
# If an IM client is installed, ask the SA if it has access to any public 
# domain IM servers. If it does have access to public servers, this is a 
# finding.

#
# Fix Text: 
#
# Uninstall the IM client from the system, or configure the client to 
# only connect to DoD-approved IM services.
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006000
	
# Start-Lockdown

