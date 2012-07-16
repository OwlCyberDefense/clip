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
#
#
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 04-Feb-2012 to check if the log exists before running fix and to fix a
# bug with the mask check.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-838
#Group Title: Critical Sendmail Log File Permissions
#Rule ID: SV-838r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004500
#Rule Title: The SMTP service log file must have mode 0644 or less permissive.
#
#Vulnerability Discussion: If the SMTP service log file is more permissive than 0644, unauthorized users may be allowed to change the log file.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the mode of the SMTP service log file.
#
#Procedure:
#Identify any log files configured for the "mail" service (excluding mail.none) at any severity level and check the permissions
# egrep "mail\.[^n][^/]*" /etc/syslog.conf|sed 's/^[^/]*//'|xargs ls -lL
#
#If the log file permissions are greater than 0644, this is a finding.
#
#Fix Text: Change the mode of the SMTP service log file.
#
#Procedure:
# chmod 0644 <sendmail log file>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004500

MAILLOG=$( egrep "mail\.[^n][^/]*" /etc/syslog.conf|sed 's/^[^/]*//' )

#Start-Lockdown

if [ -a "$MAILLOG" ]
then
  # Pull the actual permissions
  FILEPERMS=`stat -L --format='%04a' $MAILLOG`
	
  # Break the actual file octal permissions up per entity
  FILESPECIAL=${FILEPERMS:0:1}
  FILEOWNER=${FILEPERMS:1:1}
  FILEGROUP=${FILEPERMS:2:1}
  FILEOTHER=${FILEPERMS:3:1}
	
  # Run check by 'and'ing the unwanted mask(7133)
  if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&7)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
  then
    chmod u-xs,g-rwxs,o-rwxt $MAILLOG
  fi
fi
