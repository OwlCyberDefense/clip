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
# on 14-jan-2012 to fix a couple of bash typos.
#
# 1 May 2012 / Lee Kinser / lkinser@redhat.com:  corrected erroneous 
# null redirect


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11982
#Group Title: Global Initialization Files Ownership
#Rule ID: SV-12483r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001740
#Rule Title: All global initialization files must be owned by root.
#
#Vulnerability Discussion: Global initialization files are used to 
#configure the user's shell environment upon login. Malicious modification 
#of these files could compromise accounts upon logon. Failure to give 
#ownership of sensitive files or utilities to root or bin provides the 
#designated owner and unauthorized users with the potential to access 
#sensitive information or change the system configuration which could 
#weaken the system's security posture.
#

#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of global initialization files.
#
#Procedure:
# ls -lL /etc/.login /etc/profile /etc/bashrc /etc/environment 
#/etc/security/environ
#
#or:
# ls /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment 
#/etc/.login /etc/security/environ 2>null|xargs stat -L -c %U:%n|egrep -v "^root"
#will show you only the owner and filename of files not owned by root.
#
#If any global initialization file is not owned by root, this is a finding.
#
#Fix Text: Change the ownership of global initialization files with 
#incorrect ownership.
#
#Procedure:
# chown root <global initialization files>
#
#or:
# ls /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment 
#/etc/.login /etc/security/environ 2>null|xargs stat -L -c %U:%n|egrep -v 
#"^root"|cut -d: -f2|xargs chown root
#will set the owner of all files not currently owned by root to root.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001740
GLOBALINIT=$( ls /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment /etc/.login /etc/security/environ /etc/profile.d/* 2> /dev/null | xargs stat -L -c %U:%n|egrep -v "^root"|cut -d: -f2 )

#Start-Lockdown

#THE PROVIDED SUGGESTION ACTUALLY WORK!!! 

for line in $GLOBALINIT
  do
    chown root $line
done
