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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4304
#Group Title: Root Filesystem Logging
#Rule ID: SV-4304r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003640
#Rule Title: The root file system must employ journaling or another mechanism that ensures file system consistency.
#
#Vulnerability Discussion: File system journaling, or logging, can allow reconstruction of file system data after a system crash, thus, preserving the integrity of data that may have otherwise been lost. Journaling file systems typically do not require consistency checks upon booting after a crash, which can improve system availability. Some file systems employ other mechanisms to ensure consistency which also satisfy this requirement.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Logging should be enabled for those types of files systems that do not turn on logging by default.
#
#Procedure:
# mount
#
#JFS, VXFS, HFS, XFS, reiserfs, EXT3 and EXT4 all turn logging on by default and will not be a finding. The ZFS file system uses other mechanisms to provide for file system consistency, and will not be a finding. For other file systems types, if the root file system does not support journaling this is a finding. If the ‘nolog’ option is set on the root file system that does support journaling, this is a finding.
#
#Fix Text: Implement file system journaling for the root file system, or use a file system that uses other mechanisms to ensure file system consistency. If the root file system supports journaling, enable it. If the file system does not support journaling or another mechanism to ensure file system consistency, a migration to a different file system will be necessary.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003640

#Start-Lockdown
