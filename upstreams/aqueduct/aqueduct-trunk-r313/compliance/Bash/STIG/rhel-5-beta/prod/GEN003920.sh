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
# on 04-Feb-2012 to check ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-828
#Group Title: hosts.lpd ownership
#Rule ID: SV-828r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003920
#Rule Title: The printers.conf file must be owned by root.
#
#Vulnerability Discussion: Failure to give ownership of the printers.conf 
#file to root provides the designated owner, and possible unauthorized 
#users, with the potential to modify the printer.conf file. Unauthorized 
#modifications could disrupt access to local printers from authorized 
#remote hosts or permit unauthorized remote access to local printers.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the print service configuration file.
#
#Procedure:
# ls -lL /etc/cups/printers.conf;
#
#If no print service configuration file is found, this is not applicable.
#If the owner of the file is not root, this is a finding.
#
#Fix Text: Change the owner of the /etc/cups/printers.conf to root.
#
#Procedure:
# chown root /etc/cups/printers.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003920

#Start-Lockdown

if [ -a "/etc/cups/printers.conf" ]
then
  CUROWN=`stat -c %U /etc/cups/printers.conf`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /etc/cups/printers.conf
  fi
fi

