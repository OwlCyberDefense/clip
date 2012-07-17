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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on
# 16-jan-2012 to remove the /sbin/nologin from the shells list.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-916
#Group Title: The /etc/shells file does not exist
#Rule ID: SV-916r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002120
#Rule Title: The /etc/shells (or equivalent) file must exist.
#
#Vulnerability Discussion: The shells file (or equivalent) lists 
#approved default shells. It helps provide layered defense to the 
#security approach by ensuring users cannot change their default shell 
#to an unauthorized shell that may not be secure.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that /etc/shells exists.
# ls -l /etc/shells
#If the file does not exist, this is a finding.
#
#Fix Text: Create an /etc/shells file that contains a list of valid 
#system shells. Consult vendor documentation for an appropriate list 
#of system shells.
#
#Procedure:
# echo "/bin/bash" >> /etc/shells
# echo "/bin/csh" >> /etc/shells
#(Repeat as necessary for other shells.)    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002120

#Start-Lockdown

if [ ! -f /etc/shells ];
  then
	cat <<-EOF >> /etc/shells
	/bin/sh
	/bin/bash
	/bin/tcsh
	/bin/csh
	/bin/ksh
	EOF

fi


