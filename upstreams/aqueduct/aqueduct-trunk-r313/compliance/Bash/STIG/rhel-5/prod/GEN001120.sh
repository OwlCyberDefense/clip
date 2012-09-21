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
# Group ID (Vulid): V-1047
# Group Title: GEN001120
# Rule ID: SV-37156r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001120
# Rule Title: The system must not permit root logins using remote access 
# programs such as ssh.

#
# Vulnerability Discussion: Even though communications are encrypted, an 
# additional layer of security may be gained by extending the policy of not 
# logging directly on as root.  In addition, logging in with a 
# user-specific account preserves the audit trail.
#
# Responsibility: System Administrator
# IAControls: ECPA-1
#
# Check Content:
#
# Determine if the SSH daemon is configured to permit root logins.

# Procedure:
# grep -v "^#" /etc/ssh/sshd_config | grep -i permitrootlogin

# If the PermitRootLogin entry is not found or is not set to "no", this is 
# a finding.


#
# Fix Text: 
#
# Edit the sshd_config file and set the PermitRootLogin option to "no".   
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001120
	
# Start-Lockdown

# Check for entry and add if not there
grep '^[#]*PermitRootLogin' /etc/ssh/sshd_config > /dev/null
if [ $? -ne 0 ]
then
  echo "" >> /etc/ssh/sshd_config
  echo "# Entry added for STIG check GEN001120" >> /etc/ssh/sshd_config
  echo "PermitRootLogin no" >> /etc/ssh/sshd_config
else

  # If its there and commented out, fix it
  grep '^#PermitRootLogin' /etc/ssh/sshd_config > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i "/^#PermitRootLogin/ c\PermitRootLogin no" /etc/ssh/sshd_config
  fi

  # If its set to something other than no, set it to no
  egrep -e '^PermitRootLogin.*no' /etc/ssh/sshd_config > /dev/null
  if [ $? -ne 0 ]
  then
    sed -i 's/\(^PermitRootLogin\).*/PermitRootLogin no/g' /etc/ssh/sshd_config
  fi

fi




