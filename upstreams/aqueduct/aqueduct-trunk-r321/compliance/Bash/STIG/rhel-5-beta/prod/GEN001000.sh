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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 03-jan-2011 to allow for either console or tty1 and default to console if
# no match is found.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4298
#Group Title: Remote Consoles
#Rule ID: SV-27151r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001000
#Rule Title: Remote consoles must be disabled or protected from 
#unauthorized access.
#
#Vulnerability Discussion: The remote console feature provides an 
#additional means of access to the system which could allow unauthorized 
#access if not disabled or properly secured. With virtualization 
#technologies, remote console access is essential as there is no physical 
#console for virtual machines. Remote console access must be protected 
#in the same manner as any other remote privileged access method.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check /etc/securetty
# more /etc/securetty
#If the file does not exist, or contains other than "console" or a 
#single tty device, this is a finding.
#
#Fix Text: Create if needed and set the contents of /etc/securetty 
#to "tty1".
# echo tty1 > /etc/securetty 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001000

#Start-Lockdown

# If multiple lines exist default to console
TTYCOUNT=`cat /etc/securetty | wc -l`
if [ $TTYCOUNT -gt 1 ]
then
  echo tty1 > /etc/securetty
else
  # Check the value of the single entry and if its not console or tty1 then fix
  CURTTY=`cat /etc/securetty`
  if [ "$CURTTY" != "console" -a "$CURTTY" != "tty1" ]
  then
    echo tty1 > /etc/securetty
  fi
fi


