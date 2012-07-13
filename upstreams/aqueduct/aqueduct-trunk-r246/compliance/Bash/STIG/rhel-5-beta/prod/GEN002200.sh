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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 16-jan-2012 to fix hanging-non-execute issue and simplify the script.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-921
#Group Title: Shell Ownership
#Rule ID: SV-921r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002200
#Rule Title: All shell files must be owned by root or bin.
#
#Vulnerability Discussion: If shell files are owned by users other than 
#root or bin, they could be modified by intruders or malicious users to 
#perform unauthorized actions.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the system shells.
# cat /etc/shells | xargs -n1 ls -l
#If any shell is not owned by root or bin, this is a finding.
#
#Fix Text: Change the ownership of the shell with incorrect ownership.
# chown root <shell>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002200


#Start-Lockdown
find /bin/bash /sbin/nologin /bin/tcsh /bin/csh /bin/ksh /bin/sync /sbin/shutdown /sbin/halt ! -user root ! -user bin -exec chown root {} \; 2> /dev/null
