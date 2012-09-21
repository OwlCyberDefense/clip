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
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12765
#Group Title: Virus protection software.
#Rule ID: SV-28462r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006640
#Rule Title: The system must use and update a DoD-approved virus scan program.
#
#Vulnerability Discussion: Virus scanning software can be used to protect a system from penetration from computer viruses and to limit their spread through intermediate systems. Virus scanning software is available to DoD on the JTF-GNO website.
#
#The virus scanning software should be configured to perform scans dynamically on accessed files. If this capability is not available, the system must be configured to scan, at a minimum, all altered files on the system on a daily basis.
#
#If the system processes inbound SMTP mail, the virus scanner must be configured to scan all received mail.
#
#Responsibility: System Administrator
#IAControls: ECVP-1
#
#Check Content: 
#Check for the existence of the McAfee command line scan tool to be executed weekly in the cron file. Additional tools specific for each operating system are also available and will have to be manually reviewed if they are installed. In addition, the definitions file should not be older than 14 days.
#
#Check if uvscan scheduled to run:
# grep uvscan /var/spool/cron/*
# grep uvscan /etc/cron.d/*
# grep uvscan /etc/cron.daily/*
# grep uvscan /etc/cron.hourly/*
# grep uvscan /etc/cron.monthly/*
# grep uvscan /etc/cron.weekly/*

#Perform the following command to ensure the virus definition signature files are not older than 14 days.
#
# ls -la clean.dat names.dat scan.dat
#
#If a virus scanner is not being run weekly or the virus definitions are older than 14 days, this is a finding.
#
#Fix Text: Install McAfee command line virus scan tool, or an appropriate alternative from https://www.cybercom.mil. Ensure the virus signature definition files are no older than 14 days. Updates are also available from https://www.cybercom.mil.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006640

#Start-Lockdown

#This is going to be a manual check.  We can't install or update the software without violating softwared agreements for / with the DoD
