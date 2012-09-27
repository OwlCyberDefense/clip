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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 13-Feb-2012 to move from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-932
#Group Title: Deny NFS Client Access Without Userid
#Rule ID: SV-28449r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005820
#Rule Title: The NFS anonymous UID and GID must be configured to values that have no permissions.
#
#Vulnerability Discussion: When an NFS server is configured to deny remote root access, a selected UID and GID are used to handle requests from the remote root user. The UID and GID should be chosen from the system to provide the appropriate level of non-privileged access.
#
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check if the 'anonuid' and 'anongid' options are set correctly for exported file systems.
#List exported filesystems:
# exportfs -v
#
#Each of the exported file systems should include an entry for the 'anonuid=' and 'anongid=' options set to -1 or an equivalent (60001, 65534, or 65535). If appropriate values for 'anonuid' or 'anongid' are not set, this is a finding.
#
#Fix Text: Edit /etc/exports and set the "anonuid=-1" and "anongid=-1" options for exports lacking it. Re-export the filesystems.  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005820

#Start-Lockdown
grep -v anongid /etc/exports > /dev/null
if [ $? -eq 0 ]
then
  sed -i -e '/anongid/! s/\(.*\))/\1,anongid=-1\)/g' /etc/exports
  exportfs -a
fi

grep -v anonuid /etc/exports > /dev/null
if [ $? -eq 0 ]
then
  sed -i -e '/anonuid/! s/\(.*\))/\1,anonuid=-1\)/g' /etc/exports
  exportfs -a
fi
