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
#Group ID (Vulid): V-12016
#Group Title: X Client Authorization via X*.hosts
#Rule ID: SV-12517r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005220
#Rule Title: .Xauthority or X*.hosts (or equivalent) file(s) must be used to restrict access to the X server.
#
#Vulnerability Discussion: If access to the X server is not restricted, the user's X session may be compromised.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Determine if the X server is running.
#Procedure:
# ps -ef |grep Xorg
#
#Determine if xauth is being used.
#Procedure:
# xauth
#xauth> list
#
#If the above command sequence does not show any host other than the localhost, then xauth is not being used.
#
#Search the system for an X*.hosts files, where * is a display number that may be used to limit X window connections. If no files are found, X*.hosts files are not being used. If the X*.hosts files contain any unauthorized hosts, this is a finding.
#
#If both xauth and X*.hosts files are not being used, this is a finding.
#
#Fix Text: Create an X*.hosts file, where * is a display number that may be used to limit X window connections. Add the list of authorized X clients to the file.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005220

#Start-Lockdown

# Can't find much info on X*.hosts files other then several forums that mention
# that they do not work properly in various distributions.  By default when 
# using xhost it looks like access control is enabled.  Moving this to manual
# checks for now.
