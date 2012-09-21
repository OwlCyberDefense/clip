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
#  on 04-Feb-2012 to add a check for tcpdump, all related packages after 
# checking if they are installed and remove any binaries that match.
# - Updated by Vincent C. Passaro (vincent.passaro@fotisnetworks.com) on
# 5/1/2012.  Complete script re-write so that errors are suppresed when
# running duck over and over. 

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12049
#Group Title: Network Analysis tools are enabled.
#Rule ID: SV-12550r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003865
#Rule Title: Network analysis tools must not be installed.
#
#Vulnerability Discussion: Network analysis tools allow for the 
#capture of network traffic visible to the system.
#
#Responsibility: System Administrator
#IAControls: DCPA-1
#
#Check Content: 
#Determine if any network analysis tools are installed.
#
#Procedure:
# find / -name ethereal
# find / -name wireshark
# find / -name tshark
# find / -name netcat
# find / -name tcpdump
# find / -name snoop
#
#If any network analysis tools are found, this is a finding.
#
#Fix Text: Remove each network analysis tool binary from the 
#system. Remove items that are part of a package with a package 
#manager, others remove the binary directly.
#
#Procedure:
#Find the binary file:
# find / -name <Item to be removed>
#
#Find the package, if any, to which it belongs:
# rpm -qf <binary file>
#
#Remove the package if it does not also include other 
#software that is used:
# rpm -e <package name>
#or
# yum remove <package name>
#
#If the item to be removed is not in a package, or the entire 
#package cannot be removed because of other software it provides, 
#remove the item's binary file.
# rm <binary file>  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003865

#Start-Lockdown

if [  -f /usr/bin/nc ] &&  rpm -q portmap >/dev/null 2>&1 
	then
		yum -y remove nc
		find / -name nc -exec rm -rf {} \;
fi

if [  -f /usr/sbin/tshark ] &&  rpm -q wireshark >/dev/null 2>&1 
	then
		yum -y remove wireshark
		find / -name wireshark -exec rm -rf {} \;
fi

if [  -f /usr/sbin/wireshark ] &&  rpm -q wireshark-gnome >/dev/null 2>&1 
	then
		yum -y remove wireshark
		find / -name wireshark -exec rm -rf {} \;
fi

if [  -f /usr/sbin/tcpdump ] &&  rpm -q tcpdump >/dev/null 2>&1 
	then
		yum -y remove tcpdump
		find / -name tcpdump -exec rm -rf {} \;
fi


#Snoop is Solaris
#Tshark is the same as wireshark


