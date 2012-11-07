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
#Group ID (Vulid): V-913
#Group Title: A .netrc file exists
#Rule ID: SV-913r8_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002000
#Rule Title: There must be no .netrc files on the system.
#
#Vulnerability Discussion: Unencrypted passwords for remote FTP servers 
#may be stored in .netrc files. Policy requires that passwords be encrypted 
#in storage and not used in access scripts.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check the system for the existence of any .netrc files.
#
#Procedure:
# find / -name .netrc
#
#If any .netrc file exists, this is a finding.
#
#Fix Text: Remove the .netrc file(s).
#
#Procedure:
# find / -name .netrc
# rm <.netrc file>
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002000

NETRCFILE=$( find / -fstype nfs -prune -o -name .netrc 2> /dev/null )

#Start-Lockdown

for line in $NETRCFILE
  do
    rm -f $line
done

