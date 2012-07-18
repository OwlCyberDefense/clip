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
#
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-jan-2012 to dump unwanted output to /dev/null. 
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-785
#Group Title: Unowned Files
#Rule ID: SV-785r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001160
#Rule Title: All files and directories must have a valid owner.
#
#Vulnerability Discussion: Unowned files and directories may be 
#unintentionally inherited if a user is assigned the same UID as the 
#UID of the unowned files.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check the system for files with no assigned owner.
#
#Procedure:
# find / -nouser
#
#If any files have no assigned owner, this is a finding.
#
#
#
#Fix Text: All directories and files (executable and data) will have 
#an identifiable owner and group name. Either trace files to an 
#authorized user, change the file’s owner to root, or delete them. 
#Determine the legitimate owner of the files and use the chown command 
#to set the owner and group to the correct value. If the legitimate 
#owner cannot be determined, change the owner to root (but make sure 
#none of the changed files remain executable because they could be 
#Trojan horses or other malicious code). Examine the files to determine 
#their origin and the reason for their lack of an owner/group.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001160
NOUSERS=`find / -fstype nfs -prune -o -nouser 2>/dev/null | wc -l 2>/dev/null`
#Start-Lockdown

if [ $NOUSERS -ge 1 ]
  then
    echo "------------------------------" > $PDI-NOUSER.log
    date >> $PDI-NOUSER.log
    echo " " >> $PDI-NOUSER.log
    echo "The following files don't have proper USER ownership." >> $PDI-NOUSER.log
    echo "Please review and fix as needed" >> $PDI-NOUSER.log
    echo " " >> $PDI-NOUSER.log
    find / -fstype nfs -prune -o -nouser 2>/dev/null >> $PDI-NOUSER.log
    echo "------------------------------" >> $PDI-NOUSER.log
fi


