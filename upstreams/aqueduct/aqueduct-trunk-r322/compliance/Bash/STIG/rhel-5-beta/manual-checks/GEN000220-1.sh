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
#By Tummy a.k.a Vincent C. Passaro				 											     #
#Fotis Networks LLC																							     #
#Vincent[.]Passaro[@]fotisnetworks[.]com											 	     #
#www.fotisnetworks.com						    															 #
######################Fotis Networks LLC##############################

#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    		|   Creation	  			  |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11945-1
#Group Title: Baseline Check for Unauthorized Additions to System 
#Libraries and Binaries
#Rule ID: SV-30006-1r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000220-1
#Rule Title: A file integrity tool must be used at least daily to 
#check for unauthorized file changes, particularly the addition of 
#unauthorized system libraries or binaries.
#
#Vulnerability Discussion: Changes in system libraries and binaries 
#and other critical system files can indicate compromise or significant 
#system events such as patching that need to be checked by automated 
#processes and the results reviewed by the SA.
#
#Note: This requirement applies to MAC I systems.
#
#Responsibility: System Administrator
#IAControls: DCSL-1
#
#Check Content: 
#Determine if there is an automated job, scheduled to run weekly or 
#more frequently, to run the file integrity tool to check for 
#unauthorized additions to system libraries. If there is not, 
#this is a finding.
#
#
#Fix Text: Establish an automated job, scheduled to run weekly or 
#more frequently, to run the file integrity tool to check for 
#unauthorized system libraries or binaries. 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000220-1

#Start-Lockdown

