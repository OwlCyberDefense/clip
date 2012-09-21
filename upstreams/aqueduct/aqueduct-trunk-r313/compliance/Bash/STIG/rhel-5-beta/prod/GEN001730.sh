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
# - updated by Lee Kinser (lkinser@redhat.com) on 30-apr-2012 to fix
#   redirection to null file instead of /dev/null issue



#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22356
#Group Title: GEN001730
#Rule ID: SV-26469r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001730
#Rule Title: All global initialization files must not have extended ACLs.
#
#Vulnerability Discussion: Global initialization files are used to 
#configure the user's shell environment upon login. Malicious modification 
#of these files could compromise accounts upon logon.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check global initialization files for extended ACLs:
#
# ls -l /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc 
#/etc/environment /etc/.login /etc/security/environ /etc/profile.d/* 2>null|grep "\+ "
#
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
#
# ls -l /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc 
#/etc/environment /etc/.login /etc/security/environ /etc/profile.d/* 
#2>null|grep "\+ "|sed "s/^.* \///g"|xargs setfacl --remove-all
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001730
GLOBALINIT=$( ls -l /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment /etc/.login /etc/security/environ /etc/profile.d/* 2>/dev/null|grep "\+ "|awk '{print $9}' )
#Start-Lockdown	

#THE DISA PROVIDED SUGGESTION DOES NOT WORK # TYPICAL

for line in $GLOBALINIT
  do
  setfacl --remove-all $line
done
