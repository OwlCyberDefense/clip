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
# on 13-Feb-2012 to move from dev to prod an create the fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4321
#Group Title: Samba is enabled
#Rule ID: SV-4321r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006060
#Rule Title: The system must not run the Samba service unless needed.
#
#Vulnerability Discussion: Samba is a tool used for the sharing of files and
#printers between Windows and UNIX operating systems. It provides access to
#sensitive files and, therefore, poses a security risk if compromised.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the system for a running Samba server.
#
#Procedure:
# ps -ef |grep smbd
#
#If the Samba server is running, ask the SA if the Samba server is
#operationally required. If it is not, this is a finding.
#
#Fix Text: If there is no functional need for Samba and the daemon is
#running, disable the daemon by killing the process ID as noted from
#the output of ps -ef |grep smbd. The samba package should also be
#removed or not installed if there is no functional requirement.
#
#Procedure:
#rpm -qa |grep samba
#
#this will show whether "samba" or "samba3x" is installed. To remove:
#
#rpm --erase samba
#or
#rpm --erase samba3x
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006060

#Start-Lockdown

rpm -q samba > /dev/null
if [ $? -eq 0 ]
then
  yum -y remove samba > /dev/null
fi

rpm -q samba3x > /dev/null
if [ $? -eq 0 ]
then
  yum -y remove samba3x > /dev/null
fi
