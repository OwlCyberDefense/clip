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
# Group ID (Vulid): V-849
# Group Title: GEN005120
# Rule ID: SV-37674r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005120
# Rule Title: The TFTP daemon must be configured to vendor 
# specifications, including a dedicated TFTP user account, a non-login 
# shell such as /bin/false, and a home directory owned by the TFTP user.
#
# Vulnerability Discussion: If TFTP has a valid shell, it increases the 
# likelihood someone could log on to the TFTP account and compromise the 
# system.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the /etc/passwd file to determine if TFTP is configured properly.

# Procedure:
# Check if TFTP if used.
# grep disable /etc/xinetd.d/tftp
# If the file does not exist or the returned line indicates "yes", then 
# this is not a finding.
# Otherwise, if the returned line indicates "no" then TFTP is enabled and 
# must use a dedicated "tftp" user.

# grep user /etc/xinetd.d/tftp
# If the returned line indicates a user other than the dedicated "tftp" 
# user, this is a finding.

# grep tftp /etc/passwd

# If a "tftp" user account does not exist and TFTP is active, this is a 
# finding.

# Check the user shell for the "tftp" user. If it is not /bin/false or 
# equivalent, this is a finding.

# Check the home directory assigned to the "tftp" user. If no home 
# directory is set, or the directory specified is not dedicated to the use 
# of the TFTP service, this is a finding.
#
# Fix Text: 
#
# Configure TFTP to use a dedicated "tftp" user.

# Procedure:
# Create a dedicated "tftp" user account if none exists.
# Assign a non-login shell to the "tftp" user account, such as /bin/false.
# Assign a home directory to the "tftp" user account.
# Edit /etc/xinetd.d/tftp to have "tftp" as the value of the "user" 
# parameter.
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005120
TFTPACCOUNT=$(cat /etc/passwd | grep -i tftp| wc -l)

#Start-Lockdown

#Check if tftp server is installed
if [ -a /etc/xinetd.d/tftp ]
  then
    #check if tftp account isn't already there.
    if [ $TFTPACCOUNT -ne 1 ]
      then
        #Create the user account
        useradd -r -s /bin/false -c "tftp account used for GEN005120" -d /tftpboot/ tftp
        #Lock the account
        usermod -L tftp
    fi
fi

