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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 01-Mar-2012 to disable iscsi and iscsid daemons as they rely on the
# ipv6 kernel module.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22542
#Group Title: GEN007720
#Rule ID: SV-26919r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007720
#Rule Title: The IPv6 protocol handler must be prevented from dynamic loading unless needed.
#
#Vulnerability Discussion: IPv6 is the next generation of the Internet protocol. Binding this protocol to the network stack increases the attack surface of the host. Unprivileged local processes may be able to cause the system to dynamically load a protocol handler by opening a socket using the protocol.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If this system uses IPv6, this is not applicable.
#
#Check that the IPv6 protocol handler is prevented from dynamic loading.
# grep 'install ipv6 /bin/true' /etc/modprobe.conf /etc/modprobe.d/*
#If no result is returned, this is a finding.
#
#Fix Text: Prevent the IPv6 protocol handler for dynamic loading.
# echo "install ipv6 /bin/true" >> /etc/modprobe.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007720

IPV6=$( grep 'install ipv6 /bin/true' /etc/modprobe.conf /etc/modprobe.d/* | wc -l )
#Start-Lockdown

if [ $IPV6 -eq 0 ]
  then
    echo "#Added for DISA GEN007720" >> /etc/modprobe.conf
    echo "install ipv6 /bin/true" >> /etc/modprobe.conf 
fi

# iscsi and iscsid depend on ipv6. Lets make sure they are disabled.
chkconfig --list iscsi | grep ':on' > /dev/null
if [ $? -eq 0 ]
then
  chkconfig iscsi off
fi
chkconfig --list iscsid | grep ':on' > /dev/null
if [ $? -eq 0 ]
then
  chkconfig iscsid off
fi
