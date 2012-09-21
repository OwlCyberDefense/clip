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
# on 04-feb-2012 to check for acls before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22424
#Group Title: GEN003745
#Rule ID: SV-26651r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003745
#Rule Title: The xinetd.conf files must not have extended ACLs.
#
#Vulnerability Discussion: The Internet service daemon configuration 
#files must be protected as malicious modification could cause denial 
#of service or increase the attack surface of the system.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the xinetd configuration files. RHEL5 does 
#not include inetd service in its distribution. It has been replaced 
#by xinetd.
#
#Procedure:
# ls -alL /etc/xinetd.conf
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/xinetd.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003745

#Start-Lockdown
if [ -e "/etc/xinetd.conf" ]
  then
    ACLOUT=`getfacl --skip-base /etc/xinetd.conf 2>/dev/null`;
    if [ "$ACLOUT" != "" ]
      then
      setfacl --remove-all /etc/xinetd.conf
    fi
fi
