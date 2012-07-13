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
# on 12-Feb-2012 to move from manual production and add the fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-927
#Group Title: NFS Port Monitoring
#Rule ID: SV-28443r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005720
#Rule Title: NFS servers must only accept NFS requests from privileged ports on client systems.
#
#Vulnerability Discussion: If clients are not required to use privileged ports to get NFS services, then exported file systems may be in danger of mounting by malicious users and intruders that do not have access to privileged ports.
# Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
# grep insecure /etc/exports
#If any of the file systems are exported with the 'insecure' option, this is a finding.
#
#Fix Text: Edit /etc/exports and remove the "insecure" option.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005720

#Start-Lockdown

grep insecure /etc/exports > /dev/null
if [ $? -eq 0 ]
then
  sed -i -e 's/insecure,//g' /etc/exports
  sed -i -e 's/,insecure)/)/g' /etc/exports
fi
