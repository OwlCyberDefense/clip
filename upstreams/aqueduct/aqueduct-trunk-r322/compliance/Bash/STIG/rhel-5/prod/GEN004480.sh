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
# Group ID (Vulid): V-837
# Group Title: GEN004480
# Rule ID: SV-37501r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004480
# Rule Title: The SMTP service log file must be owned by root.
#
# Vulnerability Discussion: If the SMTP service log file is not owned by 
# root, then unauthorized personnel may modify or delete the file to hide a 
# system compromise.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Locate any mail log files by checking the syslog configuration file.

# Procedure:
# The check procedure is the same for both sendmail and Postfix.
# Identify any log files configured for the "mail" service (excluding 
# mail.none) at any severity level and check the ownership 
# egrep "mail\.[^n][^/]*" /etc/syslog.conf|sed 's/^[^/]*//'|xargs ls -lL

# If any mail log file is not owned by root, this is a finding.


#
# Fix Text: 
#
# Change the ownership of the sendmail log file.

# Procedure:
# The fix procedure is the same for both sendmail and Postfix.
# chown root <sendmail log file>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004480
if [ -f /etc/mail/sendmail.cf ]
then
	MAILOWNER=$(egrep "mail\.[^n][^/]*" /etc/syslog.conf|sed 's/^[^/]*//'|xargs ls -lL | awk '{print $3}' )
	MAILFILE=$(egrep "mail\.[^n][^/]*" /etc/syslog.conf|sed 's/^[^/]*//'|xargs ls -lL | awk '{print $9}' )
else
	exit 0
fi

#Start-Lockdown

#Check if root owns the file
if [ $MAILOWNER != root ]
  then
    chown root $MAILFILE
fi
	
# Start-Lockdown

