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
# Group ID (Vulid): V-27251
# Group Title: GEN000140-3
# Rule ID: SV-34550r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000140-3
# Rule Title: A file integrity baseline including cryptographic hashes 
# must be maintained.


#
# Vulnerability Discussion: A file integrity baseline is a collection of 
# file metadata which is to evaluate the integrity of the system. A minimal 
# baseline must contain metadata for all device files, setuid files, setgid 
# files, system libraries, system binaries, and system configuration files. 
# The minimal metadata must consist of the mode, owner, group owner, and 
# modification times. For regular files, metadata must also include file 
# size and a cryptographic hash of the file’s contents.


#
# Responsibility: System Administrator
# IAControls: DCSW-1
#
# Check Content:
#
# Verify a system integrity baseline is maintained. The baseline has been 
# updated to be consistent with the latest approved system configuration 
# changes. The Advanced Intrusion Detection Environment (AIDE) is included 
# in the distribution of RHEL-5. Other host intrusion detection system 
# (HIDS) software is available but must be checked manually.

# Procedure:
# grep DBDIR /etc/aide.conf

# If /etc/aide.conf does not exist AIDE has not been installed. Unless 
# another HIDS is used on the system, this is a finding.

# Examine the response for "database" indicates the location of the system 
# integrity baseline database used as input to a comparison. 
# ls -la <DBDIR>

# If the no "database" file as defined in /etc/aide.conf a system integrity 
# baseline has not been created, this is a finding.

# Ask the SA when the last approved system configuration changes occurred. 
# If the modification date of the AIDE database is prior to the last 
# approved configuration change, this is a finding.


#
# Fix Text: 
#
# Regularly rebuild the integrity baseline, including cryptographic 
# hashes, for the system to be consistent with the latest approved system 
# configuration.

# Procedure:
# After an approved modification to the system configuration has been made 
# perform:

# aide -u
# This will update the database.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000140-3
	
# Start-Lockdown
if [ -e /etc/aide.conf ]
then

  grep '^@@define DBDIR' /etc/aide.conf > /dev/null
  if [ $? != 0 ]
  then
    echo "#Updating for GEN000140-3 DISA STIG Check" >> /etc/aide.conf
    echo '@@define DBDIR /var/lib/aide' >> /etc/aide.conf
  fi

  grep '^database=' /etc/aide.conf > /dev/null
  if [ $? != 0 ]
  then
    echo "#Updating for GEN000140-3 DISA STIG Check" >> /etc/aide.conf
    echo 'database=file:@@{DBDIR}/aide.db.gz' >> /etc/aide.conf
  fi

  grep '^database_out=' /etc/aide.conf > /dev/null
  if [ $? != 0 ]
  then
    echo "#Updating for GEN000140-3 DISA STIG Check" >> /etc/aide.conf
    echo 'database_out=file:@@{DBDIR}/aide.db.new.gz' >> /etc/aide.conf
  fi

  OUTD=`awk '/^@@define DBDIR/{print $3}' /etc/aide.conf`
  if [ ! -e "$OUTD" ]
  then
    mkdir $OUTD
    chmod 700 $OUTD
    chown root:root $OUTD
  fi

  if [ ! -e "/var/lib/aide/aide.db.gz" ]
  then
    if [ ! -e "/var/lib/aide/aide.db.new.gz" ]
    then
      aide --init > /dev/null 2>&1
    fi
    cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz 
  fi

fi
