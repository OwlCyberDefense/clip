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
#####################Fotis Networks LLC###############################
#By Tummy a.k.a Vincent C. Passaro															     #
#Fotis Networks LLC						   																	   #
#Vincent[.]Passaro[@]fotisnetworks[.]com												     #
#www.fotisnetworks.com						   															   #
######################Fotis Networks LLC##############################

#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	   		  |   Creation	 			    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11941-3
#Group Title: Maintain System Baseline
#Rule ID: SV-12442-3r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000140-3
#Rule Title: A file integrity baseline maintained.
#
#Vulnerability Discussion: A file integrity baseline is a collection 
#of file metadata which is to evaluate the integrity of the system. A 
#minimal baseline must contain metadata for all device files, setuid 
#files, setgid files, system libraries, system binaries, and system 
#configuration files. The minimal metadata must consist of the mode, 
#owner, group owner, and modification times. For regular files, 
#metadata must also include file size and a cryptographic hash of 
#the file’s contents.
#
#Responsibility: System Administrator
#IAControls: DCSW-1
#
#Check Content: 
#Determine if a file integrity baseline, which includes cryptographic 
#hashes, has been maintained for the system.
#
#Procedure:
#If the file integrity baseline is not maintained (that is, the 
#baseline has not been updated to be consistent with the latest 
#approved system configuration changes), this is a finding.
#
#Fix Text: Rebuild the integrity baseline, including cryptographic 
#hashes, for the system to be consistent with the latest approved 
#system configuration.   _
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000140-3

#Start-Lockdown

