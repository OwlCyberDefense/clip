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
# Group ID (Vulid): V-4692
# Group Title: GEN004660
# Rule ID: SV-37510r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN004660
# Rule Title: The SMTP service must not have the EXPN feature active.
#
# Vulnerability Discussion: The SMTP EXPN function allows an attacker to 
# determine if an account exists on a system, providing significant 
# assistance to a brute force attack on user accounts. EXPN may also 
# provide additional information concerning users on the system, such as 
# the full names of account owners.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# This vulnerability is applicable only to sendmail. If Postfix is the 
# SMTP service for the system this will never be a finding.

# Procedure:
# Determine if EXPN is disabled.
# grep -v "^#" /etc/mail/sendmail.cf |grep -i PrivacyOptions

# If nothing is returned or the returned line does not contain "noexpn", 
# this is a finding.
#
# Fix Text: 
#
# Rebuild /etc/mail/sendmail.cf with the "noexpn" Privacy Flag set.

# Procedure:
# Edit /etc/mail/sendmail.mc resetting the Privacy Flags to the default:

# define('confPRIVACYFLAGS', 'authwarnings,novrfy,noexpn,restrictqrun')dnl

# Rebuild the sendmail.cf file with:
# make -C /etc/mail

# Restart the sendmail service.
# service sendmail restart

  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004660
	
# Start-Lockdown
if [ -f /etc/mail/sendmail.cf ]
then
	NOEXPN=$( grep -v "^#" /etc/mail/sendmail.cf |grep -ci noexpn )
else
	exit 0
fi

#Start-Lockdown

#Off by default in RHEL 5

if [ $NOEXPN -eq 0 ]
  then
    sed -i '/.*O PrivacyOptions.*/s/$/,noexpn/' /etc/mail/sendmail.cf
fi


