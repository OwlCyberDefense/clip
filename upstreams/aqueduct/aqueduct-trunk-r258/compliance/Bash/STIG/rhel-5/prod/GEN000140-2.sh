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
# Group ID (Vulid): V-27250
# Group Title: GEN000140-2
# Rule ID: SV-34549r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000140-2
# Rule Title: A file integrity baseline including cryptographic hashes 
# must be created.
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
# Verify a system integrity baseline exists. The Advanced Intrusion 
# Detection Environment (AIDE) is included in the distribution of RHEL. 
# Other host intrusion detection system (HIDS) software is available but 
# must be checked manually.

# Procedure:
# grep DBDIR /etc/aide.conf

# If /etc/aide.conf does not exist AIDE has not been installed. Unless 
# another HIDS is used on the system, this is a finding.

# Examine the response for "database" this indicates the location of the 
# system integrity baseline database used as input to a comparison. 
# ls -la <DBDIR>

# If no "database" file as defined in /etc/aide.conf exists a system 
# integrity baseline has not been created, this is a finding.

# Examine /etc/aide.conf to ensure some form of cryptographic hash (i.e. 
# md5,rmd168,sha256) is used for files. In the default /etc/aide.conf the 
# "NORMAL" or "LSPP" rules which are used for virtually all files DO 
# include some form of cryptographic hash.

# If the site has defined rules to replace the functionality provided by 
# the default "NORMAL" and "LSPP" rules but DOES NOT include cryptographic 
# hashes, this is a finding.

# Otherwise, if any element used to define the "NORMAL" and "LSPP" rules 
# has been modified resulting in cryptographic hashes not being used, this 
# is a finding.

# If any other modification to the default /etc/aide.conf file have been 
# made resulting in rules which do not include cryptographic hashes on 
# appropriate files, this is a finding.
#
# Fix Text: 
#
# Use AIDE to create a file integrity baseline, including cryptographic 
# hashes, for the system.

# Configure the /etc/aide.conf file to ensure some form of cryptographic 
# hash (ie. md5,rmd168,sha256) is used for files. In the default 
# /etc/aide.conf the "NORMAL" or "LSPP" rules which are used for virtually 
# all files DO include some form of cryptographic hash.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000140-2
	
# Start-Lockdown

# install if not already
rpm -q aide > /dev/null
if [ $? != 0 ]
then

  yum install aide -y 
  aide --init > /dev/null 2>&1
  cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz 

else

  # check for database files and fix if needed
  if [ ! -e "/var/lib/aide/aide.db.gz" ]
  then
    if [ ! -e "/var/lib/aide/aide.db.new.gz" ]
    then
      aide --init > /dev/null 2>&1
    fi
    cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz 
  fi

fi 



# Set up daily reports.  Sticking with original rpt command for now, but 
# will probably need some sort of reporting set up for differences and
# some sort of log rotation set up.
if [ ! -d "/var/log/aide/reports" ]
then
  mkdir -p /var/log/aide/reports/
  chmod 700 /var/log/aide/reports/
  chown root:root /var/log/aide/reports
fi

if [ ! -e "/etc/cron.daily/gen000140.cron" ]
then

  cat <<EOF > /etc/cron.daily/gen000140.cron
#Configured to meet GEN000140{2,3}
/usr/sbin/aide --check > /var/log/aide/reports/\${HOSTNAME}-AIDEREPORT.txt 2>&1
EOF

  chmod 700 /etc/cron.daily/gen000140.cron
fi
