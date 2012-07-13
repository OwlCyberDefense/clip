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
#Updated by Vincent C. Passaro on Apr 15th 2012
#	Documentation cleanup and set bluetooth service to be off in 
#	run level 2345
#	Disable hidd (human interface for Bluetooth) in run level 2345
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22539
#Group Title: GEN007660
#Rule ID: SV-26918r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007660
#Rule Title: The Bluetooth protocol handler must be disabled or not 
#installed.
#
#Vulnerability Discussion: Bluetooth is a personal area network (PAN) 
#technology. Binding this protocol to the network stack increases the 
#attack surface of the host. Unprivileged local processes may be able 
#to cause the kernel to dynamically load a protocol handler by opening 
#a socket using the protocol.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that the Bluetooth protocol handler is prevented from dynamic loading.
# grep 'install bluetooth /bin/true' /etc/modprobe.conf /etc/modprobe.d/*
#If no result is returned, this is a finding.
#
#Fix Text: Prevent the Bluetooth protocol handler for dynamic loading.
# echo "install bluetooth /bin/true" >> /etc/modprobe.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007660

TIPC=$( grep 'install bluetooth /bin/true' /etc/modprobe.conf /etc/modprobe.d/* | wc -l )
#Start-Lockdown

if [ $TIPC -eq 0 ]
  then
    echo "#Added for DISA GEN007660" >> /etc/modprobe.conf
    echo "install bluetooth /bin/true" >> /etc/modprobe.conf
fi
	
chkconfig --list bluetooth | grep ':on' > /dev/null
	
if [ $? -eq 0 ]
  then
    chkconfig --level 2345 bluetooth off
	service bluetooth stop
fi
	
chkconfig --list hidd | grep ':on' > /dev/null
	
if [ $? -eq 0 ]
  then
    chkconfig --level 2345 hidd off
	service hidd stop
fi


