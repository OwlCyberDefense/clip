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
# Group ID (Vulid): V-11946
# Group Title: GEN000340
# Rule ID: SV-37155r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000340
# Rule Title: UIDs reserved for system accounts must not be assigned to 
# non-system accounts.
#
# Vulnerability Discussion: Reserved UIDs are typically used by system 
# software packages.  If non-system accounts have UIDs in this range, they 
# may conflict with system software, possibly leading to the user having 
# permissions to modify system files.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the UID assignments for all accounts.

# cut -d: -f 1,3 /etc/passwd | egrep ":[1-4][0-9]{2}$|:[0-9]{1,2}$"

# Confirm all accounts with a UID of 499 and below are used by a system 
# account. If a UID reserved for system accounts (0 - 499) is used by a 
# non-system account, then this is a finding.
#
# Fix Text: 
#
# Change the UID numbers for non-system accounts with reserved UIDs 
# (those less or equal to 499).     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000340
	
# Start-Lockdown

# Standard user list defined in the RHEL5 deployment guide
STANDUSERS="root bin daemon adm lp sync shutdown halt mail news uucp operator games gopher ftp nobody rpm vcsa dbus ntp canna nscd rpc postfix mailman named amanda postgres exim sshd rpcuser nsfnobody pvm apache xfs gdm htt mysql webalizer mailnull smmsp squid ldap netdump pcap radiusd"

# Add other system accounts not in the RHEL5 deployment guide
STANDUSERS="$STANDUSERS ident sys smtp nuucp listen lpd ingres oracle oracle7 oracle8 oracle9 informix nobody4 noaccess sybase tivoli mqm www ftp tftp hpdb invscout gccs secman sysadmin install staff COE predmail snmp sm share BIF GCCS JDISS SA SSO SM gccsrv gtnsmint irc Imadmin netadmin haldaemon dovecot cyrus pegasus HPSMH hpsmh webadmind webadmin webservd avahi beagleidx hsqldb svctag ids IDS distcache DISTCACHE wnn fax quagga avahi-autoipd sabayon puppet abrt saslauth tcpdump rtkit pulse"

# The check wants to check any users that are in the system account range
# to make sure they are valid user accounts. So lets parse through the 
# /etc/passwd for all UIDs under 500 and check the user agains the list.
INVALIDUSERS=""
VALIDUSER=0
for SYSUSER in `awk -F ':' '{if($3 < 500) print $1}' /etc/passwd`
do
  # Compare the user against the valid system account list
  for STANDUSER in $STANDUSERS
  do
    # If there is a match set the validuser var to 1
    if [ "$SYSUSER" = "$STANDUSER" ]
    then
      VALIDUSER=1
    fi
  done

  # Check the validuser var, add to the invalidusers list if 0 then reset
  # the valiuser var to 0
  if [ $VALIDUSER -ne 1 ]
  then
    INVALIDUSERS="$INVALIDUSERS $SYSUSER"
  fi
  VALIDUSER=0
  
done



if [ "$INVALIDUSERS" != "" ]
then
  echo "------------------------------" > $PDI-error.log
  date >> $PDI-error.log
  echo " " >> $PDI-error.log
  echo "${PDI}: The following accounts have a UID below 500" >> $PDI-error.log
  echo "and are not valid system accounts" >> $PDI-error.log
  echo "$INVALIDUSERS" >> $PDI-error.log
  echo "Please review these accounts" >> $PDI-error.log
  echo "------------------------------" >> $PDI-error.log
fi

