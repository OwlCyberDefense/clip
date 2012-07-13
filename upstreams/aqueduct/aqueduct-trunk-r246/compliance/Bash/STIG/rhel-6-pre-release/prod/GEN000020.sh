#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com )
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
#By Shannon Mitchell                                                 #
#shannon.mitchell@fusiontechnology-llc.com                           #
######################################################################
#
#  - Created by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) 
# to add support for upstart.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-756
#Group Title: The UNIX host is bootable in single user mode
#Rule ID: SV-27036r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000020
#Rule Title: The system must require authentication 
#upon booting into single-user and maintenance modes.
#
#Vulnerability Discussion: If the system does not require valid root 
#authentication before it boots into single-user or maintenance mode, 
#anyone who invokes single-user or maintenance mode is granted 
#privileged access to all files on the system.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check if the system requires a password for entering single-user mode.
# grep ':S:' /etc/inittab
#If /sbin/sulogin is not listed, this is a finding.
#
#Fix Text: Edit /etc/inittab and set sulogin to run in single-user mode.
#Example line in /etc/inittab:
#~:S:wait:/sbin/sulogin 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000020

#Start-Lockdown

# Lets check for upstart, and default to inittab
INITTYPE="default"
rpm -qa upstart > /dev/null
if [ $? == 0 ]
then
    INITTYPE="upstart"
fiy

# Upstart has a config file for sulogin in single user mode at /etc/init/rcS-sulogin.conf.
# This sources the /etc/sysconfig/init for the SINGLE variable to decide if you need a
# password(/sbin/sulogin) or no password(/sbin/sushell) in single user mode.
if [ "$INITTYPE" == "upstart" ]
then
  egrep '^SINGLE=/sbin/sushell' /etc/sysconfig/init > /dev/null
  if [ $? == 0 ]
  then
    sed -i -e 's/^SINGLE=\/sbin\/sushell/SINGLE=\/sbin\/sulogin/g' /etc/sysconfig/init
  fi

fi

if [ "$INITTYPE" == "default" ]
then
  SULOGIN=`grep -c "~:S:wait:/sbin/sulogin" /etc/inittab`

  #Start-Lockdown

  if [ $SULOGIN -eq 0 ]
    then
      echo " " >> /etc/inittab
      echo "#Configured to meet GEN000020" >> /etc/inittab
      echo "~:S:wait:/sbin/sulogin" >> /etc/inittab 
  fi
fi

