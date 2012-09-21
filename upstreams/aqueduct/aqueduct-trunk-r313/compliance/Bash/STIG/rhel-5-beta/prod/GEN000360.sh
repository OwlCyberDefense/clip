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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 30-dec-11 to fix the logic to catch all accounts below gid 499 that are not
# system accounts and to added users from the standard user list in the RHEL5 
# deployment guide.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-780
#Group Title: Reserved System Account GIDs
#Rule ID: SV-28657r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000360
#Rule Title: GIDs reserved for system accounts must not be assigned 
#to non-system groups.
#
#Vulnerability Discussion: Reserved GIDs are typically used by system 
#software packages. If non-system groups have GIDs in this range, they 
#may conflict with system software, possibly leading to the group 
#having permissions to modify system files.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
# more /etc/passwd
#Confirm all accounts with a GID of 499 and below are used by a system 
#account. If a GID reserved for system accounts (0 - 499) is used by a 
#non-system account, this is a finding.
#
#Fix Text: Change the primary group GID numbers for non-system accounts
#with reserved primary group GIDs (those less or equal to 499).   _
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000360

#Start-Lockdown

# Standard group list defined in the RHEL5 deployment guide
STANDUSERS="root bin daemon adm lp sync shutdown halt mail news uucp operator games gopher ftp nobody rpm vcsa dbus ntp canna nscd rpc postfix mailman named amanda postgres exim sshd rpcuser nsfnobody pvm apache xfs gdm htt mysql webalizer mailnull smmsp squid ldap netdump pcap radiusd"

# Add other possible system groups not in the RHEL5 deployment guide
STANDUSERS="$STANDUSERS ident sys smtp nuucp listen lpd ingres oracle oracle7 oracle8 oracle9 informix nobody4 noaccess sybase tivoli mqm www ftp tftp hpdb invscout gccs secman sysadmin install staff COE predmail snmp sm share BIF GCCS JDISS SA SSO SM gccsrv gtnsmint irc Imadmin netadmin haldaemon dovecot cyrus pegasus HPSMH hpsmh webadmind webadmin webservd avahi beagleidx hsqldb svctag ids IDS distcache DISTCACHE wnn fax quagga avahi-autoipd sabayon"

# The check wants to check any users that are in the system gid range
# to make sure they are valid user accounts. So lets parse through the 
# /etc/passwd for all GIDs under 500 and check the user against the list.
INVALIDUSERS=""
VALIDUSER=0
for SYSUSER in `awk -F ':' '{if($4 < 500) print $1}' /etc/passwd`
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
  echo "${PDI}: The following accounts have a GID below 500" >> $PDI-error.log
  echo "and are not valid system accounts" >> $PDI-error.log
  echo "$INVALIDUSERS" >> $PDI-error.log
  echo "Please review these accounts" >> $PDI-error.log
  echo "------------------------------" >> $PDI-error.log
fi

