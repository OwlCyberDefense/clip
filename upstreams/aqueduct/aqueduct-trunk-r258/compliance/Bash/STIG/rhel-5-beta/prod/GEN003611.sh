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
# on 04-feb-2012 to cut back on the output from sysctl -p.  Also split up
# check for the default and all entries.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22418
#Group Title: GEN003611
#Rule ID: SV-26633r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN003611
#Rule Title: The system must log martian packets.
#
#Vulnerability Discussion: Martian packets are packets that contain 
#addresses known by the system to be invalid. Logging these messages 
#allows the SA to identify misconfigurations or attacks in progress.
#
#Responsibility: System Administrator
#IAControls: ECAT-1
#
#Check Content: 
#Check that the system logs martian packets.
#
#Procedure:
# cat /proc/sys/net/ipv4/conf/all/log_martians
#
#If the result is not 1, this is a finding.
#
#Fix Text: Configure the system to log martian packets.
#Edit /etc/sysctl.conf and add a setting for 
#"net.ipv4.conf.all.log_martians=1" and "net.ipv4.conf.default.log_martians=1".
#
#Reload the sysctls.
#Procedure:
# sysctl -p  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003611
martian=$( cat /proc/sys/net/ipv4/conf/all/log_martians )
martiandef=$( cat /proc/sys/net/ipv4/conf/default/log_martians )

#Start-Lockdown

if [ $martian -ne 1 ]
then
  echo " " >> /etc/sysctl.conf
  echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
  echo "net.ipv4.conf.all.log_martians=1" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi

if [ $martiandef -ne 1 ]
then
  echo " " >> /etc/sysctl.conf
  echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
  echo "net.ipv4.conf.default.log_martians=1" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi

