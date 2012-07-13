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
# on 18-Feb-2012 to add a check before running the fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22546
#Group Title: GEN007800
#Rule ID: SV-26925r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007800
#Rule Title: The system must not have Teredo enabled.
#
#Vulnerability Discussion: Teredo is an IPv6 transition mechanism that involves tunneling IPv6 packets encapsulated in IPv4 packets. Unauthorized tunneling may circumvent network security.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that the Miredo service is not running.
# ps ax | grep miredo | grep -v grep
#If the miredo process is running, this is a finding.
#
#Fix Text: Kill the miredo service. Edit startup scripts to prevent the service from running on startup.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007800

#Start-Lockdown

#This isn't in the default RHEL 5 repo, might be for RHEL 6.

rpm -q miredo-server > /dev/null
if [ $? -eq 0 ]
then
  yum remove miredo-server -y
fi

