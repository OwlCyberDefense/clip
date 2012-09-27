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
#Group ID (Vulid): V-4091
#Group Title: Run Control Scripts Execute Programs
#Rule ID: SV-27223r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001700
#Rule Title: System start-up files must only execute programs owned by a privileged UID or an application.
#
#Vulnerability Discussion: System start-up files that execute programs owned by other than root (or another privileged user) or an application indicate that the system may have been compromised.
#
#
#Responsibility: System Administrator
#IAControls: DCSL-1
#
#Check Content: 
#Determine the programs executed by system start-up files. Determine the ownership of the executed programs.
#
# cat /etc/rc*/* /etc/init.d/* | more
# ls -l <executed program>
#
#Alternatively:
# for FILE in `egrep -r "/" /etc/rc.* /etc/init.d|awk '/^.*[^\/][0-9A-Za-z_\/]*/{print $2}'|egrep "^/"|sort|uniq`;do if [ -e $FILE ]; then stat -L -c '%U:%n' $FILE;fi;done
#
#This provides a list of files referenced by initialization scripts and their associated UIDs.
#If any file is run by an initialization file and is not owned by root, sys, bin, or in rare cases, an application account, this is a finding.
#
#Fix Text: Change the ownership of the file executed from system startup scripts to root, bin, sys, or other.
# chown root <executed file>
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001700

#Start-Lockdown

# Moving this to a manual check for now.
