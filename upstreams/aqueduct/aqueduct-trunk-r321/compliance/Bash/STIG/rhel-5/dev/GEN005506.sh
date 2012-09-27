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
# Group ID (Vulid): V-22459
# Group Title: GEN005506
# Rule ID: SV-26752r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005506
# Rule Title: The SSH daemon must be configured to not use Cipher-Block 
# Chaining (CBC) ciphers.
#
# Vulnerability Discussion: The Cipher-Block Chaining (CBC) mode of 
# encryption as implemented in the SSHv2 protocol is vulnerable to chosen 
# plain text attacks and must not be used.


#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the SSH daemon configuration for allowed ciphers.
# grep -i ciphers /etc/ssh/sshd_config | grep -v '^#' 
# If no lines are returned, or the returned ciphers list contains any 
# cipher ending with cbc, this is a finding.

#
# Fix Text: 
#
# Edit /etc/ssh/sshd_config and add or edit the "Ciphers" line.  Only 
# include ciphers that start with "3des" or "aes" and do not contain "cbc". 
#  For the list of available ciphers for the particular version of your 
# software, consult the sshd_config manpage.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005506
	
# Start-Lockdown

