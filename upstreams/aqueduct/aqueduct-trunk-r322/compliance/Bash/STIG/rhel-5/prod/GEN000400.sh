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
# Group ID (Vulid): V-763
# Group Title: GEN000400
# Rule ID: SV-37169r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000400
# Rule Title: The Department of Defense (DoD) login banner must be 
# displayed immediately prior to, or as part of, console login prompts.
#
# Vulnerability Discussion: Failure to display the logon banner prior to 
# a logon attempt will negate legal proceedings resulting from unauthorized 
# access to system resources.
#
# Responsibility: System Administrator
# IAControls: ECWM-1
#
# Check Content:
#
# Access the system console and make a login attempt. Check for either of 
# the following login banners based on the character limitations imposed by 
# the system. An exact match is required. If one of these banners is not 
# displayed, this is a finding.

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

# OR

# I've read & consent to terms in IS user agreem't.
#
# Fix Text: 
#
# Edit /etc/issue and add one of the DoD login banners (based on the 
# character limitations imposed by the system).

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

# OR

# I've read & consent to terms in IS user agreem't.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000400
	
# Start-Lockdown

grep 'U\.S\.Government' /etc/issue > /dev/null
if [ $? != 0 ]
then

  cat <<EOF > /etc/issue
##########################################################################
# You are accessing a U.S. Government (USG) Information System (IS)      #
# that is provided for USG-authorized use only.                          #
#                                                                        #
# By using this IS (which includes any device attached to this IS),      #
# you consent to the following conditions:                               #
#                                                                        #
# -The USG routinely intercepts and monitors communications on this      #
# IS for purposes including, but not limited to, penetration testing,    #
# COMSEC monitoring, network operations and defense, personnel           #
# misconduct (PM), law enforcement (LE), and counterintelligence (CI)    #
# investigations.                                                        #
#                                                                        #
# -At any time, the USG may inspect and seize data stored on this IS.    #
#                                                                        #
# -Communications using, or data stored on, this IS are not private,     #
# are subject to routine monitoring, interception, and search, and       #
# may be disclosed or used for any USG-authorized purpose.               #
#                                                                        #
# -This IS includes security measures (e.g., authentication and access   #
# controls) to protect USG interests--not for your personal benefit or   #
# privacy.                                                               #
#                                                                        #
# -Notwithstanding the above, using this IS does not constitute consent  #
# to PM, LE or CI investigative searching or monitoring of the content   #
# of privileged communications, or work product, related to personal     #
# representation or services by attorneys, psychotherapists, or clergy,  #
# and their assistants. Such communications and work product are private #
# and confidential. See User Agreement for details.                      #
##########################################################################
        
EOF


fi

grep '^Banner /etc/issue' /etc/ssh/sshd_config > /dev/null
if [ $? != 0 ]
then
  sed -i "/^#Banner/ c\Banner /etc/issue" /etc/ssh/sshd_config
fi


