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
#Group ID (Vulid): V-936
#Group Title: NFS clients enable nosuid and nosgid
#Rule ID: SV-936r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005900
#Rule Title: The nosuid option must be enabled on all NFS client mounts.
#
#Vulnerability Discussion: Enabling the nosuid mount option prevents the system from granting owner or group-owner privileges to programs with the suid or sgid bit set. If the system does not restrict this access, users with unprivileged access to the local system may be able to acquire privileged access by executing suid or sgid files located on the mounted NFS file system.
#
#Responsibility: System Administrator
#IAControls: ECPA-1
#
#Check Content: 
#Check the system for NFS mounts that do not use the "nosuid" option.
#
#Procedure:
# mount -v | grep " type nfs " | egrep -v "nosuid"
#
#If the mounted file systems do not have the "nosuid" option, this is a finding.
#
#Fix Text: Edit /etc/fstab and add the "nosuid" option for all NFS file systems. Remount the NFS file systems to make the change take effect.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005900

#Start-Lockdown

grep nfs /etc/fstab | grep -v 'nosuid' > /dev/null
if [ $? -eq 0 ]
then
  sed -i -e '/nfs/ s/\(^.*[ \t]*nfs[ \t]*\)\([^ \t]*\)[ \t]*\(.*$\)/\1 \2,nosuid \3/g' /etc/fstab
fi


