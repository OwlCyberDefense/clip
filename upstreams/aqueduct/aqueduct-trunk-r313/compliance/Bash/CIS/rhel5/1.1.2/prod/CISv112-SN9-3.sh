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
#9.3 Set Account Expiration Parameters On Active Accounts
#Description:
#It is a good idea to force users to change passwords on a regular basis. 
#The commands below will set all active accounts (except system accounts) 
#to force password changes every 90 days (-M 90), and then prevent password 
#changes for seven days (-m 7) thereafter. Users will begin receiving 
#warnings 14 days (-W 14) before their password expires. Once the password 
#expired, the account will be locked out after 7 days (-I 7). Finally, 
#the instructions below set a minimum password length of 9 characters.
#These are recommended starting values. Some regulated industries require 
#more restrictive values – ensure they comply with the local Enterprise 
#security policy.


sed -i '/^PASS_MIN_DAYS/ c\PASS_MIN_DAYS\t7' /etc/login.defs

sed --in-place "s/PASS_MIN_LEN[ \t]*[0-9]*/PASS_MIN_LEN\t9/" /etc/login.defs

sed -i '/^PASS_MAX_DAYS/ c\PASS_MAX_DAYS\t90' /etc/login.defs

sed -i '/^PASS_WARN_AGE/ c\PASS_WARN_AGE\t14' /etc/login.defs

for NAME in `cut -d: -f1 /etc/passwd`; do
uid=`id -u $NAME`
if [ $uid -ge 500 -a $uid != 65534 ]; then
chage -m 7 -M 90 -W 14 -I 7 $NAME
fi
done

cat <<END_SCRIPT >> /etc/login.defs
# The following 2 lines added, per CIS Red Hat Enterprise Linux Benchmark sec 9.3
# Establish a forced five-second minimum delay between failed logins
FAIL_DELAY 5
END_SCRIPT

chown root:root /etc/login.defs
chmod 0640 /etc/login.defs
