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
#Group ID (Vulid): V-22580
#Group Title: GEN008500
#Rule ID: SV-26971r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN008500
#Rule Title: The system must have IEEE 1394 (Firewire) disabled unless needed.
#
#Vulnerability Discussion: Firewire is a common computer peripheral interface.
#Firewire devices may include storage devices that could be used to install
#malicious software on a system or exfiltrate data.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If the system needs IEEE 1394 (Firewire), this is not applicable.
#Check if the firewire module is not disabled.
# grep 'install ieee1394 /bin/true' /etc/modprobe.conf /etc/modprobe.d/*
#If no results are returned, this is a finding.
#
#Fix Text: Prevent the system from loading the firewire module.
# echo 'install ieee1394 /bin/true' >> /etc/modprobe.conf
  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008500
FIREWIRE=$( grep 'install ieee1394 /bin/true' /etc/modprobe.conf /etc/modprobe.d/* | wc -l )
#Start-Lockdown

if [ $FIREWIRE -eq 0 ]
  then
    echo "#Added for DISA GEN008500" >> /etc/modprobe.conf
    echo 'install ieee1394 /bin/true' >> /etc/modprobe.conf
fi
