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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22432
#Group Title: GEN003830
#Rule ID: SV-26671r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003830
#Rule Title: The rlogind service must not be running.
#
#Vulnerability Discussion: The rlogind process provides a typically 
#unencrypted, host-authenticated remote access service. SSH should be 
#used in place of this service.
#
#Responsibility: System Administrator
#IAControls: DCPP-1
#
#Check Content: 
#Check the rlogind configuration.
# cat /etc/xinetd.d/rlogin
#If the file exists and does not contain "disable = yes" this is a finding.
#
#Fix Text: Remove or disable the rlogin configuration and restart xinetd.
# rm /etc/xinetd.d/rlogin ; service xinetd restart    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003830

#Start-Lockdown
RLOGIN='/etc/xinetd.d/rlogin'

if [ -a $RLOGIN ]
  then
    rm -f /etc/xinetd.d/rlogin
    service xinetd restart
fi

