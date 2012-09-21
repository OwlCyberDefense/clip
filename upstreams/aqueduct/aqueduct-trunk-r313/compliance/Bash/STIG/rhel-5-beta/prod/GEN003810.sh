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
# on 04-Feb-2012 to check service status before disabling it.
#
# Updated by Vincent C. Passaro (vincent.passaro@fotisnetworks.com)
# on 5/1/2012 for error suppression and to check for portmap before running


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22429
#Group Title: GEN003810
#Rule ID: SV-26662r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003810
#Rule Title: The portmap or rpcbind service must not be running unless 
#needed.
#
#Vulnerability Discussion: The portmap and rpcbind services increase 
#the attack surface of the system and should only be used when needed. 
#The portmap or rpcbind services are used by a variety of services 
#using remote procedure calls (RPCs).
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the status of the portmap service.
# service portmap status
#If the service is running, this is a finding.
#
#Fix Text: Shutdown and disable the portmap service.
# service portmap stop; chkconfig portmap off   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003810

#Start-Lockdown
if [ ! -f /etc/rc.d/init.d/portmap ] && ! rpm -q portmap >/dev/null 2>&1 
	then
		exit 0
fi
chkconfig --list portmap | grep ':on' > /dev/null
if [ $? -eq 0 ]
then
  service portmap stop
  chkconfig portmap off
fi

