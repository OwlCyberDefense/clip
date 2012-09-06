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
#Group ID (Vulid): V-11988
#Group Title: Access Control Files Documentation
#Rule ID: SV-12489r5_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN002040
#Rule Title: There must be no .rhosts, .shosts, hosts.equiv, or 
#shosts.equiv files on the system.
#
#Vulnerability Discussion:  The Berkeley r-commands are legacy services 
#which allow cleartext remote access and have an insecure trust model and 
#should never be used. Unless there has been a documented exception made 
#for their use the .rhosts, .shosts, hosts.equiv, and shosts.equiv files 
#which are used to configure host-based authentication for individual 
#users on the system must not exist.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check for the existence of the files.
#
# find / -name .rhosts
# find / -name .shosts
# find / -name hosts.equiv
# find / -name shosts.equiv
#
#If .rhosts, .shosts, hosts.equiv, or shosts.equiv are found, this is a finding.
#
#
#
#Fix Text: Remove the .rhosts, .shosts, hosts.equiv, and/or shosts.equiv files.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002040

GEN002060FILES=$( find / -fstype nfs -prune -o -name .rhosts -o -name  .shosts -o -name  hosts.equiv -o -name shosts.equiv 2> /dev/null )

#Start-Lockdown

for line in $GEN002060FILES
  do
  rm -f $line
done
