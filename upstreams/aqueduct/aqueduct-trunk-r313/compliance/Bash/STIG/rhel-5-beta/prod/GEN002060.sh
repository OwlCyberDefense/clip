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
# Updated by Lee Kinser (lkinser@redhat.com) on 1 May 2012 to squash
# find errors

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4428
#Group Title: Access Control Files Accessibility
#Rule ID: SV-4428r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002060
#Rule Title: All .rhosts, .shosts, .netrc, or hosts.equiv files must
#be accessible by only root or the owner.
#
#Vulnerability Discussion: The Berkeley r-commands are legacy services 
#which allow cleartext remote access and have an insecure trust model 
#and should never be used. However, if there has been a documented 
#exception made for their use if the access control files are accessible 
#by other than root or the owner, they could be used by a malicious user 
#to set up a system compromise.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
# find / -name .rhosts
# ls -al /<directorylocation>/.rhosts
#
# find / -name .shosts
# ls -al /<directorylocation>/.shosts
#
# find / -name hosts.equiv
# ls -l /<directorylocation>/hosts.equiv
#
# find / -name shosts.equiv
# ls -l /<directorylocation>/shosts.equiv
#
#If the .rhosts, .shosts, hosts.equiv, or shosts.equiv files have 
#permissions greater than 700, then this is a finding.
#
#
#Fix Text: Ensure the permission for these files is set at 600 and 
#the owner is the owner of the home directory that it is in. These 
#files, outside of home directories (other than hosts.equiv which is in 
#/etc and owned by root), have no meaning.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002060

GEN002060FILES=$( find / -fstype nfs -prune -o -name .rhosts -o -name  .shosts -o -name  hosts.equiv -o -name shosts.equiv 2> /dev/null )

#Start-Lockdown

for line in $GEN002060FILES
  do
  chmod 700 $line
done








