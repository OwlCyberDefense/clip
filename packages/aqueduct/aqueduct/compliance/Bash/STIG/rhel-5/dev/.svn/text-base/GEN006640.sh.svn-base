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
# Group ID (Vulid): V-12765
# Group Title: GEN006640
# Rule ID: SV-37760r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006640
# Rule Title: The system must use and update a DoD-approved virus scan 
# program.
#
# Vulnerability Discussion: Virus scanning software can be used to 
# protect a system from penetration from computer viruses and to limit 
# their spread through intermediate systems.  

# The virus scanning software should be configured to perform scans 
# dynamically on accessed files.  If this capability is not available, the 
# system must be configured to scan, at a minimum, all altered files on the 
# system on a daily basis.

# If the system processes inbound SMTP mail, the virus scanner must be 
# configured to scan all received mail.
#
# Responsibility: System Administrator
# IAControls: ECVP-1
#
# Check Content:
#
# Check for the existence of a cron job to execute the McAfee command 
# line scan tool (uvscan) daily. Other tools may be available but will have 
# to be manually reviewed if they are installed. In addition, the 
# definitions files should not be older than 7 days. 

# Check if uvscan scheduled to run:
# grep uvscan /var/spool/cron/*
# grep uvscan /etc/cron.d/*
# grep uvscan /etc/cron.daily/*
# grep uvscan /etc/cron.hourly/*
# grep uvscan /etc/cron.monthly/*
# grep uvscan /etc/cron.weekly/*

# If a virus scanner is not being run daily and an exception has not been 
# documented with the IAO, this is a finding.

# Perform the following command to ensure the virus definition signature 
# files are not older than 7 days.
# The default uvscan install directory is /usr/local/uvscan.

# cd <uvscan install directory>
# ls -la avvscan.dat avvnames.dat avvclean.dat

# If the virus definitions are older than 7 days, this is a finding.


#
# Fix Text: 
#
# Install McAfee command line virus scan tool, or an appropriate 
# alternative. Ensure the virus signature definition files are no older 
# than 7 days. Configure the system to run a virus scan on altered files 
# dynamically or daily. If daily scans impede operations, justify, 
# document, and obtain IAO approval for alternate scheduling.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006640
	
# Start-Lockdown

