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
#By Tummy a.k.a Vincent C. Passaro				    										   #
#Fotis Networks LLC						    																	 #
#Vincent[.]Passaro[@]fotisnetworks[.]com			  									   #
#www.fotisnetworks.com						   															   #
######################Fotis Networks LLC##############################

#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	  		  |   Creation				    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1015
#Group Title: Journaling
#Rule ID: SV-1015r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000000-LNX00240
#Rule Title: The ext3 filesystem type must be used for the primary 
#Linux file system partitions.
#
#Vulnerability Discussion: The ext3 type is most suitable for securing 
#a Linux installation. It also offers the immutable and append only 
#file attributes which are most useful in protecting system logs and 
#other files. A file with the append only attribute may only be 
#modified by appending data to the end of the file. The immutable 
#attribute protects a file from being modified, deleted, or renamed. 
#In addition, links may not be created to the file.
#
#Responsibility: System Administrator
#IAControls: ECAR-1, ECAR-2, ECAR-3
#
#Check Content: 
#Perform the following to check for ext3 filesystems:
#
# more /etc/fstab
#
#If a local filesystem on a Linux platform is not using ext3, this 
#is a finding.
#
#Note: The CD, floppy drives, proc, swap, tmp, dev and sys 
#entries do not support ext3.
#
#
#Fix Text: Use the ext3 filesystem type for Linux partitions.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00240

#Start-Lockdown



