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
# Group ID (Vulid): V-850
# Group Title: GEN005160
# Rule ID: SV-37678r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005160
# Rule Title: Any X Windows host must write .Xauthority files.
#
# Vulnerability Discussion: .Xauthority files ensure the user is 
# authorized to access specific X Windows host. If .Xauthority files are 
# not used, it may be possible to obtain unauthorized access to the X 
# Windows host.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check for .Xauthority or .xauth files being utilized by looking for 
# such files in the home directory of a user.

# Procedure:
# Verify Xwindows is used on the system. 
# egrep "^x:5.*X11" /etc/inittab
# If no line is returned the boot process does not start Xwindows. If 
# Xwindows is not configured to run, this rule is not applicable. 

# Look for xauthority files in user home directory.
# cd ~someuser
# ls -la|egrep "(\.Xauthority|\.xauth)"

# If the .Xauthority or .xauth (followed by apparently random characters) 
# files do not exist, ask the SA if the user is using Xwindows. If the user 
# is utilizing Xwindows and none of these files exist, this is a finding.
#
# Fix Text: 
#
# Ensure the X Windows host is configured to write .Xauthority files into 
# user home directories. Edit the Xaccess file. Ensure the line writing the 
# .Xauthority file is uncommented.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005160
	
# Start-Lockdown

#This is set by default with the xorg-auth rpm file for remote connections.  The files will be created once a connection is made. 
