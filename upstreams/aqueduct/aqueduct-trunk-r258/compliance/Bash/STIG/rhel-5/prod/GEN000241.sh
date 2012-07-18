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
# Group ID (Vulid): V-22290
# Group Title: GEN000241
# Rule ID: SV-26292r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000241
# Rule Title: The system clock must be synchronized continuously, or at 
# least daily.

#
# Vulnerability Discussion: A synchronized system clock is critical for 
# the enforcement of time-based policies and the correlation of logs and 
# audit records with other systems.  Internal system clocks tend to drift 
# and require periodic resynchronization to ensure their accuracy.  
# Software, such as ntpd, can be used to continuously synchronize the 
# system clock with authoritative sources.  Alternatively, the system may 
# be synchronized periodically, with a maximum of one day between 
# synchronizations.

# If the system is completely isolated (i.e., it has no connections to 
# networks or other systems), time synchronization is not required as no 
# correlation of events or operation of time-dependent protocols between 
# systems will be necessary. If the system is completely isolated, this 
# requirement is not applicable.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the root crontab (crontab -l) and the global crontabs in 
# /etc/crontab, /etc/cron.d/* for the presence of an "ntpd -qg" job to run 
# at least daily, which should have asterisks (*) in columns 3, 4, and 5.

# Check the daily cron directory (/etc/cron.daily) for any script running 
# "ntpd -qg".

# Check for a running NTP daemon.
# ps ax | grep ntpd

# If none of the above checks are successful, this is a finding.
#
# Fix Text: 
#
# Enable the NTP daemon for continuous synchronization.
# service ntpd start ; chkconfig ntpd on

# OR

# Add a daily or more frequent cronjob to perform synchronization using 
# ntpdate.
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000241
	
# Start-Lockdown


# Even though the GEN000240 is a manual check, lets go ahead and make
# sure ntpd os enabled in this one.
chkconfig --list ntpd | grep ':on' > /dev/null
if [ $? != 0 ]
then
  chkconfig ntpd on
  service ntpd start > /dev/null
fi
