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

#SN.8 Lockout Accounts After 3 Failures
#Description:
#A system policy of locking out an account 
#that fails several successive authentication 
#attempts is an industry best practice, and 
#is easily implemented in this Benchmark. 
#The below value (deny=3) will cause the 
#account to be locked out after 3 successive 
#failed login attempts. This value is chosen 
#as it is a common value used in some 
#Federally-regulated industries it can be 
#increased, if that is desired.

cat <<EOF > /etc/pam.d/system-auth
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required      pam_env.so
auth        sufficient    pam_unix.so try_first_pass
auth        requisite     pam_succeed_if.so uid >= 500 quiet
# The following line added, per CIS Red Hat Enterprise Linux Benchmark sec SN.8, to harden the baseline image:
auth required pam_tally2.so onerr=fail no_magic_root
auth        required      pam_deny.so

account     required      pam_unix.so
account     sufficient    pam_succeed_if.so uid < 500 quiet
# The following line added, per CIS Red Hat Enterprise Linux Benchmark sec SN.8, to harden the baseline image:
account required pam_tally2.so deny=2 no_magic_root reset
account     required      pam_permit.so

password    requisite     pam_cracklib.so try_first_pass dcredit=-1 lcredit=-1 ocredit=-1 ucredit=-1 minlen=9
password    sufficient    pam_unix.so md5 shadow try_first_pass use_authtok
password    required      pam_deny.so

session     optional      pam_keyinit.so revoke
session     required      pam_limits.so
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     required      pam_unix.so

EOF

chown root:root /etc/pam.d/system-auth

chmod 0644 /etc/pam.d/system-auth
