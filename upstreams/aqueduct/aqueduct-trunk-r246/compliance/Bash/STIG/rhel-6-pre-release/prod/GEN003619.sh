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
#                                                                    #
#Modified by David Wagenheim, dwagenheim@owlcti.com                  #
#Changed to use a module specific file within /etc/modprobe.d        #
#                                                                    #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22421
#Group Title: GEN003619
#Rule ID: SV-26636r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003619
#Rule Title: The system must not be configured for network bridging.
#
#Vulnerability Discussion: Some systems have the ability to bridge or switch frames (link-layer forwarding) between multiple interfaces. This can be useful in a variety of situations, but if enabled when not needed, has the potential to bypass network partitioning and security.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that the system is not configured for bridging.
# ls /proc/sys/net/bridge
#If the directory exists, this is a finding.
# lsmod | grep '^bridge '
#If any results are returned, this is a finding.
#
#Fix Text: Configure the system to not use bridging.
# rmmod bridge
#Edit /etc/modprobe.conf and add a line such as "install bridge /bin/false" to prevent the loading of the bridge module.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003619

#Check if bridge is disabled
NOBRIDGE=$( egrep -l 'install bridge /bin/(false|true)' /etc/modprobe.conf /etc/modprobe.d/* 2>/dev/null )
#Start-Lockdown

if [[ -d /proc/sys/net/bridge || $(lsmod | grep -c '^bridge ') -gt 0 ]]
then
    rmmod bridge
fi

if [[ ${NOBRIDGE} ]]
then
    # we have a file disabling the module
    if [[ ${NOBRIDGE} != "/etc/modprobe.d/bridge.conf" ]]
    then
        # the file preventing the loading is /etc/modprobe.conf which is being removed in favor of separate
        # files in /etc/modprobe.d.  Clear the entry there.  The entry will be recreated where it belongs at
        # the end of the script.
        /bin/sed --in-place '/install bridge \/bin\/true/d' ${NOBRIDGE}
    else
        # Nothing to do, the rule is in the right place
        exit
    fi
else
    # play it safe and remove any entries for bridge in any modprobe files
    /bin/sed --in-place '/.* bridge .*/d' /etc/modprobe.conf /etc/modprobe.d/* 2>/dev/null
fi

echo "# Added for DISA ${PDI}" > /etc/modprobe.d/bridge.conf
echo "install bridge /bin/true" >> /etc/modprobe.d/bridge.conf
