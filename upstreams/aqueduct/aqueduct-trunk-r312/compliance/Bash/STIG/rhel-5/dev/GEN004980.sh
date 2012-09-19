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
# Group ID (Vulid): V-845
# Group Title: GEN004980
# Rule ID: SV-37547r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN004980
# Rule Title: The FTP daemon must be configured for logging or verbose 
# mode.
#
# Vulnerability Discussion: The -l option allows basic logging of 
# connections.  The verbose (on HP) and the debug (on Solaris) allow 
# logging of what files the ftp session transferred.  This extra logging 
# makes it possible to easily track which files are being transferred onto 
# or from a system.  If they are not configured, the only option for 
# tracking is the audit files.  The audit files are much harder to read.  
# If auditing is not properly configured, then there would be no record at 
# all of the file transfer transactions.
#
# Responsibility: System Administrator
# IAControls: ECAR-1, ECAR-2, ECAR-3
#
# Check Content:
#
# Find if logging is applied to the ftp daemon. The procedure depends on 
# the implementation of ftpd used by the system. 

# Procedures:

# For vsftpd: 
# If vsftpd is started by xinetd:

#grep vsftpd /etc/xinetd.d/*
# This will indicate the xinetd.d startup file

#grep server_args <vsftpd xinetd.d startup file>
# This will indicate the vsftpd config file used when starting through 
# xinetd. 
# If the line is missing then "/etc/vsftpd/vsftpd.conf", the default config 
# file, is used.

#grep xferlog_enable <vsftpd config file>
# If "xferlog_enable" is missing or is not set to "yes", this is a finding.

# If vsftp is not started by xinetd:
#grep xferlog_enable /etc/vsftpd/vsftpd.conf
# If "xferlog_enable" is missing or is not set to "yes", this is a finding.


# For gssftp:
# Find if the -l option will be applied when xinetd starts gssftp
# grep server_args /etc/xinetd.d/gssftp
# If the line is missing or does not contain at least one -l, this is a 
# finding.


#
# Fix Text: 
#
# Enable logging by changing ftpd startup or config files.

# Procedure:
# The procedure depends on the implementation of ftpd used by the system. 

# For vsftpd: 

# Ensure the server settings in "/etc/vsftpd.conf" (or other configuration 
# file specified by the vaftpd xinetd.d startup file) contains:

# xferlog_enable = yes

# For gssftp:
# If the "disable" server setting is missing or set to "no" in 
# "/etc/xinetd.d/gssftp" then
# ensure the server settings in "/etc/xinetd.d/gssftp" contains:

# server_args = -l 

# The -l option may be added up to three times. Each -l will provide 
# increasing verbosity on the log. Refer to the main page for ftpd for more 
# information.

# For both if started using xinetd:
# If the "disable" server setting is missing or set to "no" in the 
# /etc/xinetd.d startup file then
# ensure the server settings contains:

# log_on_success += DURATION USERID
# This will log the startup and shutdown of the daemon.

# log_on_failure += HOST USERID  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004980
	
# Start-Lockdown

