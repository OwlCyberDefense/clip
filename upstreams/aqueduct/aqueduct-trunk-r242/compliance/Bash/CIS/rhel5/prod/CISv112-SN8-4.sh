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
#By Tummy a.k.a Vincent C. Passaro                                   #
#Vincent[.]Passaro[@]gmail[.]com                                     #
#www.vincentpassaro.com                                              #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 06-dec-2011|
#|          |   Creation            |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#8.4 Restrict at/cron To Authorized Users
#Description:
#The cron.allow and at.allow files are a list of users who are allowed 
#to run the crontab and at commands to submit jobs to be run at scheduled
#intervals. On many systems, only the SysAdmin needs the ability to 
# schedule jobs.

# With x.allow only users listed can use 'at' or 'cron'
# {where 'x' indicates either 'at' or 'cron'}
# Without x.allow then x.deny is checked, members of x.deny are excluded
# Without either (x.allow and x.deny), then only root can use 'at' and 'cron'
# At a minimum x.allow should exist and list root


echo "Attempting to list the following files for the 'before' picture."
echo "Any 'errors' are alright, as we are simply looking to see what exists."

rm -f /etc/at.deny /etc/cron.deny

echo root > /etc/at.allow

echo root > /etc/cron.allow

chown root:root /etc/at.allow /etc/cron.allow

chmod 0400 /etc/at.allow /etc/cron.allow
