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
#Rule ID: SV-4388r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005020-1
#Rule Title: The anonymous FTP account for vsftp must be configured to use chroot or a similarly isolated environment.
#
#Vulnerability Discussion: If an anonymous FTP account does not use a chroot or similarly isolated environment,
#the system may be more vulnerable to exploits against the FTP service. Such exploits could allow an attacker to gain shell access to the system and view, edit, or remove sensitive files.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Access to the anonymous root directory as defined in "/etc/vsftpd/vsftpd.conf" is made using chroot this is integral to the server.
#
#Fix Text: Configure the anonymous FTP service in vsftp to operate in a chroot environment. 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005020-1

#Start-Lockdown

#This will probably need to be manual until SCAP content is release so they we know exactly what it's checking
