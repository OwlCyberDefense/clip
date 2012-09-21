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
# - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 04-feb-2012 to cut back on the output from sysctl -p.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22410
#Group Title: GEN003603
#Rule ID: SV-26623r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003603
#Rule Title: The system must not respond to ICMPv4 echoes sent to a broadcast address.
#
#Vulnerability Discussion: Responding to broadcast Internet Control Message Protocol (ICMP) echoes facilitates network mapping and provides a vector for amplification attacks.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that the system does not respond to ICMP ECHO_REQUESTs set to broadcast addresses.
#
#Procedure:
# cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
#
#If the result is not 1, this is a finding.
#
#Fix Text: Configure the system to not respond to ICMP ECHO_REQUESTs sent to broadcast addresses. Edit /etc/sysctl.conf and add a setting for "net.ipv4.icmp_echo_ignore_broadcasts=1" and reload the sysctls.
#
#Procedure:
# echo "net.ipv4.icmp_echo_ignore_broadcasts=1" >> /etc/sysctl.conf
# sysctl -p 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003603
ICMPECHO=$( cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts )

#Start-Lockdown

if [ $ICMPECHO -ne 1 ]
then
  echo " " >> /etc/sysctl.conf
  echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
  echo "net.ipv4.icmp_echo_ignore_broadcasts=1" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi

