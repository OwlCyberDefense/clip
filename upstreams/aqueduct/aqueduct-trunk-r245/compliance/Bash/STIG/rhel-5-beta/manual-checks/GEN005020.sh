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
#Group ID (Vulid): V-4388
#Group Title: Anonymous FTP Configuration
#Rule ID: SV-4388r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005020
#Rule Title: The anonymous FTP account for gssftp must be configured to use chroot or a similarly isolated environment.
#
#Vulnerability Discussion: If an anonymous FTP account does not use a chroot or similarly isolated environment, the system may be more vulnerable to exploits against the FTP service. Such exploits could allow an attacker to gain shell access to the system and view, edit, or remove sensitive files.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#The RHEL5 distrubution includes a kerberized version of gssftp as its ftp server. The use of the designated home directory via chroot is integral to server. There is no way to disable this.
#
#Fix Text: Configure the anonymous FTP service in gssftp to operate in a chroot environment.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005020

#Start-Lockdown

#Moving to manual check until SCAP is release to confirm what is being checked
