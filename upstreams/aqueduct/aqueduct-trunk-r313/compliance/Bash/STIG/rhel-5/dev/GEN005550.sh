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
# Group ID (Vulid): V-22489
# Group Title: GEN005550
# Rule ID: SV-37915r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005550
# Rule Title: The SSH daemon must be configured with the Department of 
# Defense (DoD) logon banner.
#
# Vulnerability Discussion: Failure to display the DoD logon banner prior 
# to a logon attempt will negate legal proceedings resulting from 
# unauthorized access to system resources.

# The SSH service must be configured to display the DoD logon warning 
# banner either through the SSH configuration or a wrapper program such as 
# TCP_WRAPPERS.

# The SSH daemon may also be used to provide SFTP service.  The warning 
# banner configuration for SSH will apply to SFTP.
#
# Responsibility: System Administrator
# IAControls: ECWM-1
#
# Check Content:
#
# Verify the SSH daemon is configured for logon warning banners.
# Procedure:

# An exact match is required to have a valid warning banner.  Check for the 
# following login banner.


# You are accessing a U.S. Government (USG) Information System (IS) that is 
# provided for USG-authorized use only.

# By using this IS (which includes any device attached to this IS), you 
# consent to the following conditions:

# -The USG routinely intercepts and monitors communications on this IS for 
# purposes including, but not limited to, penetration testing, COMSEC 
# monitoring, network operations and defense, personnel misconduct (PM), 
# law enforcement (LE), and counterintelligence (CI) investigations.

# -At any time, the USG may inspect and seize data stored on this IS.

# -Communications using, or data stored on, this IS are not private, are 
# subject to routine monitoring, interception, and search, and may be 
# disclosed or used for any USG-authorized purpose.

# -This IS includes security measures (e.g., authentication and access 
# controls) to protect USG interests--not for your personal benefit or 
# privacy.

# -Notwithstanding the above, using this IS does not constitute consent to 
# PM, LE or CI investigative searching or monitoring of the content of 
# privileged communications, or work product, related to personal 
# representation or services by attorneys, psychotherapists, or clergy, and 
# their assistants. Such communications and work product are private and 
# confidential. See User Agreement for details.


#
# Fix Text: 
#
# Edit /etc/issue and the DoD login banner.

# DoD Login Banners:

# You are accessing a U.S. Government (USG) Information System (IS) that is 
# provided for USG-authorized use only.

# By using this IS (which includes any device attached to this IS), you 
# consent to the following conditions:

# -The USG routinely intercepts and monitors communications on this IS for 
# purposes including, but not limited to, penetration testing, COMSEC 
# monitoring, network operations and defense, personnel misconduct (PM), 
# law enforcement (LE), and counterintelligence (CI) investigations.

# -At any time, the USG may inspect and seize data stored on this IS.

# -Communications using, or data stored on, this IS are not private, are 
# subject to routine monitoring, interception, and search, and may be 
# disclosed or used for any USG-authorized purpose.

# -This IS includes security measures (e.g., authentication and access 
# controls) to protect USG interests- -not for your personal benefit or 
# privacy.

# -Notwithstanding the above, using this IS does not constitute consent to 
# PM, LE or CI investigative searching or monitoring of the content of 
# privileged communications, or work product, related to personal 
# representation or services by attorneys, psychotherapists, or clergy, and 
# their assistants. Such communications and work product are private and 
# confidential. See User Agreement for details.


# Find the location of the banner file for sshd and examine the content:

# grep -i banner /etc/ssh/sshd_config | grep -v '^#'
# cat

# Edit the SSH daemon configuration and add or edit a "Banner" setting 
# referencing a file containing a logon warning banner.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005550
	
# Start-Lockdown

