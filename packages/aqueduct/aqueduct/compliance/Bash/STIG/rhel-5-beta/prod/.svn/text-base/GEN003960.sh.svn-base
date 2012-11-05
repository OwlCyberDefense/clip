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
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
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
# on 05-Feb-2012 to check ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4369
#Group Title: The traceroute command ownership
#Rule ID: SV-28392r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003960
#Rule Title: The traceroute command owner must be root.
#
#Vulnerability Discussion: If the traceroute command owner has not 
#been set to root, an unauthorized user could use this command to 
#obtain knowledge of the network topology inside the firewall. This 
#information may allow an attacker to determine trusted routers and 
#other network information that may lead to system and network compromise.
#
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
# ls -lL /bin/traceroute
#If the traceroute command is not owned by root, this is a finding.
#
#
#Fix Text: Change the owner of the traceroute command to root.
#Example:
# chown root /bin/traceroute
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003960

#Start-Lockdown

if [ -a "/bin/traceroute" ]
then
  CUROWN=`stat -c %U /bin/traceroute`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /bin/traceroute
  fi
fi
