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
# on 06-Feb-2012 to look for both .mib files and the .txt files under 
# /usr/share/snmp/mibs that show up in nessus scans.
#
# Updated by Lee Kinser (lkinser@redhat.com) on 1 May 2012 to squash
# find errors



#######################DISA INFORMATION###############################
#Group ID (Vulid): V-995
#Group Title: MIB File Permissions
#Rule ID: SV-995r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005340
#Rule Title: Management Information Base (MIB) files must have mode 0640 or less permissive.
#
#Vulnerability Discussion: The ability to read the MIB file could impart special knowledge to an intruder or malicious user about the ability to extract compromising information about the system or network.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the modes for all Management Information Base (MIB) files on the system.
#
#Procedure:
# find / -name *.mib
# ls -lL <mib file>
#
#If any file is returned that does not have mode 0640 or less permissive, this is a finding.
#
#Fix Text: Change the mode of MIB files to 0640.
#
#Procedure:
# chmod 0640 <mib file>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005340


#Start-Lockdown

find / -name *.mib -type f -exec chmod u-xs,g-wxs,o-rwxt {} \;
find /usr/share/snmp/mibs/ -type f -name '*.txt' -exec chmod u-xs,g-wxs,o-rwxt {} \; 2> /dev/null 
