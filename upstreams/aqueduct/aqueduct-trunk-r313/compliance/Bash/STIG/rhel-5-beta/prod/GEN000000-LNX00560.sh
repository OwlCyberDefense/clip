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
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4339
#Group Title: The insecure_locks option
#Rule ID: SV-4339r5_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN000000-LNX00560
#Rule Title: The Linux NFS Server must not have the insecure file 
#locking option.
#
#Vulnerability Discussion: Insecure file locking could allow for 
#sensitive data to be viewed or edited by an unauthorized user.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Determine if an NFS server is running on the system by:
#     
# ps -ef |grep nfsd
#
#If an NFS server is running, confirm that it is not configured 
#with the insecure_locks option by:
#
# exportfs -v
#
#The example below would be a finding:
#
#      /misc/export       speedy.example.com(rw,insecure_locks)
#
#
#Fix Text: Remove the "insecure_locks" option from all NFS exports 
#on the system.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00560
INSECURELOCK=`grep -c "insecure_locks" /etc/exports`

#Start-Lockdown

if [ $INSECURELOCK -ne 0 ]
  then
    sed -i 's/,insecure_locks//g' /etc/exports 
fi
