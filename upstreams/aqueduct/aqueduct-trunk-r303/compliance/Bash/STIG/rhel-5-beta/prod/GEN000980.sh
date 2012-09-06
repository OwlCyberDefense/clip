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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-778
#Group Title: The root account can be directly logged into
#Rule ID: SV-27146r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000980
#Rule Title: The system must prevent the root account from directly 
#logging in except from the system console.
#
#Vulnerability Discussion: Limiting the root account direct logins to 
#only system consoles protects the root account from direct unauthorized 
#access from a non-console device.
#
#
#Responsibility: System Administrator
#IAControls: ECPA-1
#
#Check Content: 
#Confirm /etc/securetty exists and is empty or contains only the word 
#console or a single tty device.
# more /etc/securetty
#
#Fix Text: Edit /etc/securetty to contain only "console".
# echo console > /etc/securetty    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000980

#Start-Lockdown

#echo console > /etc/securetty

#This is going to be addressed in GEN001000 since we need a TTY for Virt systems.

