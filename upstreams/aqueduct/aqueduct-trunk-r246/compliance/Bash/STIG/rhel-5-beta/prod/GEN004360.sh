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
# on 05-Feb-2012 to check ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-831
#Group Title: aliases ownership
#Rule ID: SV-831r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004360
#Rule Title: The sendmail alias files must be owned by root.
#
#Vulnerability Discussion: If the alias and aliases.db files are not 
#owned by root, an unauthorized user may modify the file to add aliases 
#to run malicious code or redirect e-mail.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the alias file.
#
#Procedure:
# ls -lL /etc/aliases /etc/aliases.db;
#
#If the files are not owned by root, this is a finding.
#
#Fix Text: Change the owner of the /etc/aliases file to root.
#
#Procedure:
# chown root /etc/aliases /etc/aliases.db   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004360

#Start-Lockdown

if [ -a "/etc/aliases" ]
then
  CUROWN=`stat -c %U /etc/aliases`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /etc/aliases
  fi
fi

if [ -a "/etc/aliases.db" ]
then
  CUROWN=`stat -c %U /etc/aliases.db`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /etc/aliases.db
  fi
fi
