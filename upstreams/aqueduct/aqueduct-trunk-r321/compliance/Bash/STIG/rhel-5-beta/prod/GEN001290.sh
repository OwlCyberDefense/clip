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
# on 09-jan-2011 to include an ACL check before running setfacl.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22316
#Group Title: GEN001290
#Rule ID: SV-26371r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN001290
#Rule Title: All manual page files must not have extended ACLs.
#
#Vulnerability Discussion: If manual pages are compromised, misleading 
#information could be inserted, causing actions that may compromise the system.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that all manual page files have no extended ACLs.
# ls -lL /usr/share/man /usr/share/info /usr/share/infopage
#If the permissions include a '+', the file has an extended ACL this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /usr/share/man/* /usr/share/info/* /usr/share/infopage/*    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001290

#Start-Lockdown
for MANDIR in /usr/share/man /usr/share/info /usr/share/infopage
do
  if [ -d $MANDIR ]
  then
    for MANPAGEFILE in `find $MANDIR -type f`
    do
      ACLOUT=`getfacl --skip-base $MANPAGEFILE 2>/dev/null`;
      if [ "$ACLOUT" != "" ]
      then
        setfacl --remove-all $MANPAGEFILE
      fi
    done
  fi
done
