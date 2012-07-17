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
#Group ID (Vulid): V-22511
#Group Title: GEN007020
#Rule ID: SV-26865r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007020
#Rule Title: The Stream Control Transmission Protocol (SCTP) must be disabled unless required.
#
#Vulnerability Discussion: The Stream Control Transmission Protocol (SCTP) is an IETF-standardized transport layer protocol. This protocol is not yet widely used. Binding this protocol to the network stack increases the attack surface of the host. Unprivileged local processes may be able to cause the kernel to dynamically load a protocol handler by opening a socket using the protocol.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that the SCTP protocol handler is prevented from dynamic loading.
# grep 'install sctp /bin/true' /etc/modprobe.conf /etc/modprobe.d/*
#If no result is returned, this is a finding.
#
#Fix Text: Prevent the SCTP protocol handler for dynamic loading.
# echo "install sctp /bin/true" >> /etc/modprobe.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007020
SCTPINSTALL=$( grep 'install sctp /bin/true' /etc/modprobe.conf /etc/modprobe.d/* | wc -l )
#Start-Lockdown

if [ $SCTPINSTALL -eq 0 ]
  then
    echo "#Added for DISA GEN007020" >> /etc/modprobe.conf 
    echo "install sctp /bin/true" >> /etc/modprobe.conf
fi

    
