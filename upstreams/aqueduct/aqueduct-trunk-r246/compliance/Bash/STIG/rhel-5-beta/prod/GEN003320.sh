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
# on 02-jan-2011 to add content and move from dev to prod.
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 02-feb-2011 to remove at.deny content as it exists in GEN003300.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-986
#Group Title: Default System Accounts and At
#Rule ID: SV-27387r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003320
#Rule Title: Default system accounts (with the exception of root) must 
#not be listed in the at.allow file or must be included in the at.deny 
#file if the at.allow file does not exist.
#
#Vulnerability Discussion: Default accounts, such as bin, sys, adm, 
#uucp, daemon, and others, should never have access to the "at" facility. 
#This would create a possible vulnerability open to intruders or 
#malicious users.
#
#Responsibility: System Administrator
#IAControls: ECPA-1
#
#Check Content: 
# more /etc/at.allow
#If default accounts (such as bin, sys, adm, and others) are listed 
#in the at.allow file, this is a finding.
#
#Fix Text: Remove the default accounts (such as bin, sys, adm, and 
#others, traditionally UID less than 500) from the at.allow file.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003320

#Start-Lockdown
for CURUSER in `awk -F ':' '!/^root/{if($3 < 500) print $1}' /etc/passwd`
do

  # If the at.allow exists remove the user if there
  if [ -e "/etc/at.allow" ]
  then
    grep "$CURUSER" /etc/at.allow > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e "/${CURUSER}/d" /etc/at.allow
    fi
  fi

done

# Remove emtpy lines
if [ -e "/etc/at.allow" ]
then
  sed -i -e '/^\s*$/d' /etc/at.allow
fi

