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
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11941-1
#Group Title: Create System Baseline
#Rule ID: SV-12442-1r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000140-1
#Rule Title: A file integrity baseline must be created.
#
#Vulnerability Discussion: A file integrity baseline is a collection 
#of file metadata which is to evaluate the integrity of the system. 
#A minimal baseline must contain metadata for all device files, 
#setuid files, setgid files, system libraries, system binaries, 
#and system configuration files. The minimal metadata must consist 
#of the mode, owner, group owner, and modification times. For 
#regular files, metadata must also include file size and a cryptographic 
#hash of the file’s contents.
#
#Responsibility: System Administrator
#IAControls: DCSW-1
#
#Check Content: 
#Determine if a file integrity baseline, which includes cryptographic 
#hashes, has been created for the system.
#
#Procedure:
#If no file integrity baseline exists for the system, this is a finding.
#
#
#Fix Text: Create a file integrity baseline, including cryptographic 
#hashes, for the system.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000140-1
AIDE=`rpm -qa | grep -c aide`
#Start-Lockdown

if [ $AIDE -eq 0 ]
  then
    yum install aide -y
    aide --init 
    cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz 

      if [ -a "/var/spool/cron/root" ]
	then
	  echo "0 0 * * 0	     /usr/sbin/aide --check > /var/log/aide/reports/$HOSTNAME-AIDEREPORT.txt 2>&1" >> /var/spool/cron/root
      else
	mkdir -p /var/log/aide/reports/
	chmod 700 /var/log/aide/reports/
	echo "Configured to meet GEN000140{1,2,3}'" > /var/spool/cron/root
	echo "0 0 * * 0	     /usr/sbin/aide --check > /var/log/aide/reports/$HOSTNAME-AIDEREPORT.txt 2>&1" >> /var/spool/cron/root
	chmod 600 /var/spool/cron/root
      fi
   else
     echo "------------------------------" > $PDI-error.log
     date >> $PDI-error.log
     echo " " >> $PDI-error.log
     echo "AIDE is already installed" >> $PDI-error.log
     echo "Assuming this has been configured properly, please check" >> $PDI-error.log
     echo "------------------------------" >> $PDI-error.log
fi 

