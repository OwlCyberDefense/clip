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
#   - Update Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on
# 02-jan-2012 to add some checks before running the chmod.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-775
#Group Title: The root account home directory (other than /) has
#Rule ID: SV-775r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000920
#Rule Title: The root account's home directory (other than /) must 
#have mode 0700.
#
#Vulnerability Discussion: Permissions greater than 0700 could allow 
#unauthorized users access to the root home directory.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check the mode of the root home directory.
#
#Procedure:
# grep "^root" /etc/passwd | awk -F":" '{print $6}'
# ls -ld <root home directory>
#
#If the mode of the directory is not equal to 0700, this is a finding. 
#If the home directory is /, this check will be marked Not Applicable.
#
#Fix Text: The root home directory will have permissions of 0700. Do 
#not change the protections of the / directory. Use the following 
#command to change protections for the root home directory:
# chmod 0700 /rootdir.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000920

#Start-Lockdown
if [ -e "/root" ]
then

  FILEPERMS=`stat -L --format='%04a' /root`

  if [ "$FILEPERMS" != "0700" ]
  then
    chmod 0700 /root
  fi

fi

