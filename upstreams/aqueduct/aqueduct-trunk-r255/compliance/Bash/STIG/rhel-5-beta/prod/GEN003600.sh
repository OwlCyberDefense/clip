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
#Group ID (Vulid): V-12002
#Group Title: Network Security Settings
#Rule ID: SV-29795r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003600
#Rule Title: The system must not forward IPv4 source-routed packets.
#
#Vulnerability Discussion: Source-routed packets allow the source of the packet to suggest that routers forward the packet along a different path than configured on the router, which can be used to bypass network security measures. This requirement applies only to the forwarding of source-routed traffic, such as when IPv4 forwarding is enabled and the system is functioning as a router.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that the system does not accept source-routed IPv4 packets.
#
#Procedure:
# cat /proc/sys/net/ipv4/conf/all/accept_source_route
#
#If the result is not 0, this is a finding.
#
#Note: The same setting is used by Linux for both the local acceptance and forwarding of source-routed IPv4 packets.
#
#Fix Text: Configure the system to not accept source-routed IPv4 packets.
#Edit /etc/sysctl.conf and add a setting for "net.ipv4.conf.all.accept_source_route=0" and "net.ipv4.conf.default.accept_source_route=0".
#
#Reload the sysctls.
#Procedure:
# sysctl -p   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003600
SOURCEROUTE=$( cat /proc/sys/net/ipv4/conf/all/accept_source_route )
#Start-Lockdown

if [ $SOURCEROUTE -ne 0 ]
  then
    echo " "  >> /etc/sysctl.conf
    echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
    echo "net.ipv4.conf.all.accept_source_route=0" >> /etc/sysctl.conf
    sysctl -p > /dev/null
fi

