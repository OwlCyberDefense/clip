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
#Group ID (Vulid): V-22578
#Group Title: GEN008460
#Rule ID: SV-26967r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN008460
#Rule Title: The system must have USB disabled unless needed.
#
#Vulnerability Discussion: USB is a common computer peripheral interface. USB devices may include storage devices that could be used to install malicious software on a system or exfiltrate data.
#
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If the system needs USB, this vulnerability is not applicable.
#Check if the directory /proc/bus/usb exists. If so, this is a finding.
#
#Fix Text: Edit the grub bootloader file /boot/grub/grub.conf or /boot/grub/menu.lst by appending the "nousb" parameter to the kernel boot line.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008460

NOUSB=$( cat /boot/grub/grub.conf |grep -i kernel | grep -i nousb | wc -l )
#Start-Lockdown

if [ $NOUSB -eq 0 ]
  then
    sed -i '/kernel/ {/nousb/! s/.*/& nousb/}' /boot/grub/grub.conf
fi

