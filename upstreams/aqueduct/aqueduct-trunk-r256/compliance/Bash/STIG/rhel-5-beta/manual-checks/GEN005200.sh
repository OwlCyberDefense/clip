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
#Group ID (Vulid): V-4697
#Group Title: X Displays Exporting
#Rule ID: SV-4697r6_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN005200
#Rule Title: X displays must not be exported to the world.
#
#Vulnerability Discussion: Open X displays allow an attacker to capture keystrokes and to execute commands remotely. Many users have their X Server set to xhost +, permitting access to the X Server by anyone, from anywhere.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If Xwindows is not used on the system, this is not applicable.
#
#Check the output of the "xhost" command from an X terminal.
#
#Procedure:
# xhost
#If the output reports access control is enabled (and possibly lists the hosts that can receive X window logins), this is not a finding. If the xhost command returns a line indicating access control is disabled, this is a finding.
#
#Note: It may be necessary to define the display if the command reports it cannot open the display.
#
#Procedure:
#$ DISPLAY=MachineName:0.0; export DISPLAY
#MachineName may be replaced with an Internet Protocol Address. Repeat the check procedure after setting the display.
#
#Fix Text: If using an xhost-type authentication the "xhost -" command can be used to remove current trusted hosts and then selectively allow only trusted hosts to connect with "xhost +" commands. A cryptographically secure authentication, such as provided by the xauth program, is always preferred. Refer to your X11 server's documentation for further security information.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005200

#Start-Lockdown
