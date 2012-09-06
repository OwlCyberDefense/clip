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
# Group ID (Vulid): V-846
# Group Title: GEN004820
# Rule ID: SV-37526r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004820
# Rule Title: Anonymous FTP must not be active on the system unless 
# authorized.
#
# Vulnerability Discussion: Due to the numerous vulnerabilities inherent 
# in anonymous FTP, it is not recommended. If anonymous FTP must be used on 
# a system, the requirement must be authorized and approved in the system 
# accreditation package.
#
# Responsibility: Information Assurance Officer
# IAControls: ECSC-1
#
# Check Content:
#
# Attempt to log into this host with a user name of anonymous and a 
# password of guest (also try the password of guest@mail.com). If the logon 
# is successful and the use of anonymous ftp has not been documented and 
# approved by the IAO, this is a finding.

# Procedure:
# ftp localhost
# Name: anonymous
# 530 Guest login not allowed on this machine.


#
# Fix Text: 
#
# Configure the FTP service to not permit anonymous logins.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004820
	
# Start-Lockdown
# Confirm that we actually have vsftpd installed.  Both the file required for this GEN as well
# as the vsftpd RPM must be missing in order for this check to stop execution of the script
if [ ! -f /etc/vsftpd/vsftpd.conf ] && ! rpm -q vsftpd >/dev/null 2>&1 ; then
	exit 0
fi


# Check if we are already set properly
FTPANON=$(grep -c "anonymous_enable=YES" /etc/vsftpd/vsftpd.conf )


# If we get here and the file does not exist, that means the package is installed but has
# no config file... odd situation, so we do nothing in that case.  Otherwise, we modify
# the file as required
if [ -e /etc/vsftpd/vsftpd.conf ]
  then
    if [ $FTPANON -eq 1 ]
      then
        sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' /etc/vsftpd/vsftpd.conf
    fi
fi

