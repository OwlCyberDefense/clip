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

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-11995
# Group Title: GEN003060
# Rule ID: SV-27338r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003060
# Rule Title: Default system accounts (with the exception of root) must 
# not be listed in the cron.allow file or must be included in the cron.deny 
# file, if cron.allow does not exist.
#
# Vulnerability Discussion: To centralize the management of privileged 
# account crontabs, of the default system accounts, only root may have a 
# crontab.
#
# Responsibility: System Administrator
# IAControls: ECPA-1
#
# Check Content:
#
# Check the cron.allow and cron.deny files for the system.
# more /etc/cron.allow
# more /etc/cron.deny
# If a default system account (such as bin, sys, adm, or others, 
# traditionally UID less than 500) is listed in the cron.allow file, or not 
# listed in the cron.deny file and if no cron.allow file exists, this is a 
# finding.
#
# Fix Text: 
#
# Remove default system accounts (such as bin, sys, adm, or others, 
# traditionally UID less than 500) from the cron.allow file if it exists, 
# or add those accounts to the cron.deny file.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003060
	
# Start-Lockdown
for SYSUSER in `awk -F ':' '!/^root:/{if($3 < 500) print $1}' /etc/passwd`
do
  grep $SYSUSER /etc/cron.allow > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i "/$SYSUSER/d" /etc/cron.allow
  fi
done
