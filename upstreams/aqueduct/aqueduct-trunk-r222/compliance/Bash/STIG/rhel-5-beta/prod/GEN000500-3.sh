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
#
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
#  on 01-jan-2012 to add a value check before running the fix.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4083-3
#Group Title: Inactivity timeout. Enable screen locking.
#Rule ID: SV-29796r3_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000500-3
#Rule Title: Graphical desktop environments provided by the system must 
#have automatic lock enabled.
#
#Vulnerability Discussion: If graphical desktop sessions do not lock the 
#session after 15 minutes of inactivity, requiring re-authentication to 
#resume operations, the system or individual data could be compromised by 
#an alert intruder who could exploit the oversight. This requirement 
#applies to graphical desktop environments provided by the system to 
#locally attached displays and input devices as well as to graphical 
#desktop environments provided to remote systems, including thin clients.
#
#Responsibility: System Administrator
#IAControls: PESL-1
#
#Check Content: 
#For the Gnome screen saver, check the lock_enabled flag.
#
#Procedure:
# gconftool-2 --direct --config-source 
#xml:readwrite:/etc/gconf/gconf.xml.mandatory --get /apps/gnome-screensaver/lock_enabled
#If this does not return "true", this is a finding.
#
#
#Fix Text: For the Gnome screen saver, set the lock_enabled flag.
#
#Procedure:
# gconftool-2 --direct --config-source 
#xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gnome-screensaver/lock_enabled true
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000500-3

#Start-Lockdown

LOCKENABLED=`gconftool-2 --direct --config-source xml:read:/etc/gconf/gconf.xml.mandatory --get /apps/gnome-screensaver/lock_enabled 2> /dev/null | awk '!/^Resolved/'`
if [ "$LOCKENABLED" != 'true' ]
then
  gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gnome-screensaver/lock_enabled true > /dev/null
fi


