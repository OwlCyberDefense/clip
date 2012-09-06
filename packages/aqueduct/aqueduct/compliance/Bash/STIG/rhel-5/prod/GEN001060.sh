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
# |    1.0   |   Initial Script      | Shannon Mitchell   | 28-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-11980
# Group Title: GEN001060
# Rule ID: SV-37378r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001060
# Rule Title: The system must log successful and unsuccessful access to 
# the root account.
#
# Vulnerability Discussion: If successful and unsuccessful logins and 
# logouts are not monitored or recorded, access attempts cannot be tracked. 
#  Without this logging, it may be impossible to track unauthorized access 
# to the system.
#
# Responsibility: System Administrator
# IAControls: ECAR-1, ECAR-2, ECAR-3
#
# Check Content:
#
# Check the log files to determine if access to the root account is being 
# logged.

# Procedure:
# Examine /etc/syslog.conf to confirm the location to which "authpriv" 
# messages will be directed. The default syslog.conf uses /var/log/messages 
# and /var/log/secure but this needs to be confirmed.

# grep @ /etc/syslog.conf
# If a line starting with "*.*" is returned then all syslog messages will 
# be sent to system whose address appears after the "@". In this case 
# syslog may or may not be configured to also log "authpriv" messages 
# locally.

# grep authpriv /etc/syslog.conf
# If any lines are returned which do not start with "#" the "authpriv" 
# messages will be sent to the indicated files or remote systems.

# Try to "su -" and enter an incorrect password.

# If there are no records indicating the authentication failure, this is a 
# finding.
#
# Fix Text: 
#
# Troubleshoot the system logging configuration to provide for logging of 
# root account login attempts.
# Procedure:
# Edit /etc/syslog.conf to make sure "authpriv.*" messages are directed to 
# a file or remote system.
# Examine /etc/audit/audit.rules to ensure user authentication messages 
# have not been specifically excluded.
# There remove any entries that correspond to:
# -a exclude,never -Fmsgtype=USER_START
# -a exclude,never -Fmsgtype=USER_LOGIN
# -a exclude,never -Fmsgtype=USER_AUTH
# -a exclude,never -Fmsgtype=USER_END
# -a exclude,never -Fmsgtype=USER_ACCT  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001060
	
# Start-Lockdown

for LCONF in /etc/syslog.conf /etc/rsyslog.conf
do
  if [ -e "$LCONF" ]
  then
    egrep '^[^#]?authpriv\.\*[[:space:]]+/var/log/secure' $LCONF > /dev/null
    if [ $? != 0 ]
    then
      # comment out any non-matching
      sed -i -e 's/^\(authpriv.*\)/#\1/' $LCONF
      # add the correct line
      echo "" >> $LCONF
      echo "# Line added for STIG GEN001060 compliance" >> $LCONF
      echo "authpriv.*                                              /var/log/secure" >> $LCONF
    fi
  fi
done


for MSGTYP in USER_START USER_LOGIN USER_AUTH USER_END USER_ACCT
do
  egrep "^[^#]?-a exclude,never -Fmsgtype=${MSGTYP}" /etc/audit/audit.rules > /dev/null
  if [ $? == 0 ]
  then
    sed -i -e "s/^\(\-a exclude\,never \-Fmsgtype=${MSGTYP}\)/#\1/g" /etc/audit/audit.rules
  fi
done
