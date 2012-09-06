#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Vincent C. Passaro (vincent.passaro@gmail.com)
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

#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#
#  - Update by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) 
# on 05-jan-2012 to include some additional logic to include bad values and
# no entries.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1047
#Group Title: Encrypting Root Access
#Rule ID: SV-1047r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001120
#Rule Title: The system must not permit root logins using remote access 
#programs such as ssh.
#
#Vulnerability Discussion: Even though communications are encrypted, an 
#additional layer of security may be gained by extending the policy of 
#not logging directly on as root. In addition, logging in with a 
#user-specific account preserves the audit trail.
#
#Responsibility: System Administrator
#IAControls: ECPA-1
#
#Check Content: 
#Determine if the SSH daemon is configured to permit root logins.
#
#Procedure:
# grep -v "^#" /etc/ssh/sshd_config | grep -i permitrootlogin
#
#If the PermitRootLogin entry is not found or is not set to "no", this is a finding.
#
#Fix Text: Edit the sshd_config file and set the PermitRootLogin option to "no".    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001120

#Start-Lockdown

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




