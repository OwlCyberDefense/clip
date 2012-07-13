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
# on 14-Feb-2012 to add service check before fix.
#
#
# Updated by Lee Kinser (lkinser@redhat.com) on 1 May 2012 to squash
# chkconfig missing service errors


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-867
#Group Title: NIS Documentation
#Rule ID: SV-867r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006400
#Rule Title: The Network Information System (NIS) protocol must not be used.
#
#Vulnerability Discussion: Due to numerous security vulnerabilities that exist
#within Linux NIS and its successor NIS+, neither should ever be used. Both NIS
#and NIS+ have been obsoleted by newer authentication services such as Kerberos and LDAP.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Perform the following to determine if NIS is active on the system:
#
# ps -ef | grep ypbind
#
#If NIS is found active on the system, this is a finding.
#
#Fix Text: Disable the use of NIS/NIS+. Use as a replacement Kerberos or LDAP.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006400

#Start-Lockdown

chkconfig --list ypbind 2> /dev/null | egrep -e '[2345]:on' > /dev/null
if [ $? -eq 0 ]
then
  service ypbind stop > /dev/null
  chkconfig --level 2345 ypbind off
fi

