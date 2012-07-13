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
# on 09-jan-2012 to change the exact match in find to any file matching the 
# unwanted bits.  Added check to skip a check directory if it doesn't exist 
# before running the find.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-792
#Group Title: Manual Page File Permissions
#Rule ID: SV-792r7_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN001280
#Rule Title: Manual page files must have mode 0644 or less permissive.
#
#Vulnerability Discussion: If manual pages are compromised, misleading 
#information could be inserted, causing actions that may compromise the system.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check the mode of the manual page files.
#
#Procedure:
# ls -lL /usr/share/man /usr/share/info /usr/share/infopage
#
#If any of the manual page files have a mode more permissive than 0644, 
#this is a finding.
#
#Fix Text: Change the mode of manual page files to 0644 or less permissive.
#
#Procedure (example):
# chmod 0644 /path/to/manpage   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001280

#Start-Lockdown
for MANDIR in /usr/share/man /usr/share/info /usr/share/infopage
do
  if [ -d $MANDIR ]
  then
    for BADMANPAGEFILE in `find $MANDIR -type f -perm /7133`
    do
      chmod u-x,g-wx,o-wx $BADMANPAGEFILE
    done
  fi
done
