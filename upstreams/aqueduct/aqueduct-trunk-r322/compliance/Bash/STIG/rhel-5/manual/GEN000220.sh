#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
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
##########################################################################

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-11945
# Group Title: GEN000220
# Rule ID: SV-38178r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000220
# Rule Title: A file integrity tool must be used at least weekly to check 
# for unauthorized file changes, particularly the addition of unauthorized 
# system libraries or binaries, or for unauthorized modification to 
# authorized system libraries or binaries.
#
# Vulnerability Discussion: Changes in system libraries, binaries and 
# other critical system files can indicate compromise or significant system 
# events such as patching needing to be checked by automated processes and 
# the results reviewed by the SA.

# NOTE: For MAC I systems, increase the frequency to daily.
#
# Responsibility: System Administrator
# IAControls: DCSL-1
#
# Check Content:
#
# Determine if there is an automated job, scheduled to run weekly or more 
# frequently, to run the file integrity tool to check for unauthorized 
# additions to system libraries. The check can be done using Advanced 
# Intrusion Detection Environment (AIDE) which is part of the Red Hat 
# Enterprise Linux (RHEL)  distribution. Other file integrity software may 
# be used but must be checked manually. 

# Procedure:
# Check the root crontab (crontab -l) and the global crontabs in 
# /etc/crontab, /etc/cron.d/* for the presence of an "aide" job to run at 
# least weekly, which should have asterisks (*) in columns 3, 4, and 5.

# Check the weekly cron directory (/etc/cron.weekly) for any script running 
# "aide --check" or "aide -C" or simply "aide". If there is not, this is a 
# finding.

# NOTE: For MAC I systems, increase the frequency to daily.

#
# Fix Text: 
#
# Establish an automated job, scheduled to run weekly or more frequently, 
# to run "aide --check" which is the file integrity tool to check for 
# unauthorized system libraries or binaries.

# NOTE: For MAC I systems, increase the frequency to daily.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000220
	
# Start-Lockdown

