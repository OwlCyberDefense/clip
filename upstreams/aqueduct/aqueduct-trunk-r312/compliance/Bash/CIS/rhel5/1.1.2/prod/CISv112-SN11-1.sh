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



# This will enforce auditing minimums.

cat <<EOF > /etc/audit/audit.rules
## This file contains the auditctl rules that are loaded
## whenever the audit daemon is started via the initscripts.
## The rules are simply the parameters that would be passed
## to auditctl.
##
## First rule - delete all
-D
## Increase the buffers to survive stress events.
## Make this bigger for busy systems
-b 8192
## Set failure mode to syslog notice {these two are mutually exclusive}
-f 1
## Set failure mode to panic {these two are mutually exclusive}
## -f 2
## NOTE:
## 1) if this is being used on a 32 bit machine, comment out the b64 lines
## 2) These rules assume that login under the root account is not allowed.
## 3) It is also assumed that 500 represents the first usable user account.
## 4) If these rules generate too much spurious data for your tastes, limit the
## the syscall file rules with a directory, like -F dir=/etc
## 5) You can search for the results on the key fields in the rules
##
## record the following for each audit event:
##- Date and time of the event
##- Userid that initiated the event
##- Type of event
##- Success or failure of the event
##- For I&A events, the origin of the request (e.g., terminal ID)
##- For events that introduce an object into a user’s address space, and
## for object deletion events, the name of the object, and in MLS
## systems, the object’s security level.
##
## Things that could affect time
-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change
#-a always,exit -F arch=b32 -S clock_settime -k time-change
#-a always,exit -F arch=b64 -S clock_settime -k time-change
-w /etc/localtime -p wa -k time-change
## Things that affect identity
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
## Things that could affect system locale
-a exit,always -F arch=b32 -S sethostname -S setdomainname -k system-locale
-a exit,always -F arch=b64 -S sethostname -S setdomainname -k system-locale
-w /etc/issue -p wa -k system-locale
-w /etc/issue.net -p wa -k system-locale
-w /etc/hosts -p wa -k system-locale
-w /etc/sysconfig/network -p wa -k system-locale
## Things that could affect MAC policy
-w /etc/selinux/ -p wa -k MAC-policy
## The SysAdmin will configure the auditing system to audit the following events
## for all users and root:
## - Logon (unsuccessful and successful) and logout (successful)
## This is handled by pam, sshd, login, and gdm
## Might also want to watch these files if needing extra information
# -w /var/log/faillog -p wa -k logins
# -w /var/log/lastlog -p wa -k logins
##- Process and session initiation (unsuccessful and successful)
##
## The session initiation is audited by pam without any rules needed.
## Might also want to watch this file if needing extra information
#-w /var/run/utmp -p wa -k session
#-w /var/log/btmp -p wa -k session
#-w /var/log/wtmp -p wa -k session
##- Discretionary access control permission modification (unsuccessful
## and successful use of chown/chmod)
-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
##- Unauthorized access attempts to files (unsuccessful)
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access
##- Use of privileged commands (unsuccessful and successful)
## use find /bin -type f -perm -04000 2>/dev/null and put all those files in
## a rule like this
-a always,exit -F path=/bin/ping -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged
##- Use of print command (unsuccessful and successful)
##- Export to media (successful)
## You have to mount media before using it. You must disable all automounting
## so that its done manually in order to get the correct user requesting the
## export
-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k export
-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k export
##- System startup and shutdown (unsuccessful and successful)
##- Files and programs deleted by the user (successful and unsuccessful)
-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete
-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete
##- All system administration actions
##- All security personnel actions
##
## Look for pam_tty_audit and add it to your login entry point's pam configs.
## If that is not found, use sudo which should be patched to record its
## commands to the audit system. Do not allow unrestricted root shells or
## sudo cannot record the action.
-w /etc/sudoers -p wa -k actions
## Optional - could indicate someone trying to do something bad or
## just debugging
#-a entry,always -F arch=b32 -S ptrace -k tracing
#-a entry,always -F arch=b64 -S ptrace -k tracing
## Optional - could be an attempt to bypass audit or simply legacy program
#-a always,exit -F arch=b32 -S personality -k bypass
#-a always,exit -F arch=b64 -S personality -k bypass
## Put your own watches after this point
# -w /your-file -p rwxa -k mykey
## Make the configuration immutable - reboot is required to change audit rules
-e 2
EOF

chown root:root /etc/audit/audit.rules

chmod 0600 /etc/audit/audit.rules

#Harde the audit.conf

sed -i "s/num_logs = 4/num_logs = 5/" /etc/audit/auditd.conf

sed -i "s/max_log_file = 5/max_log_file = 100/" /etc/audit/auditd.conf

sed -i "s/space_left = 75/space_left = 125/" /etc/audit/auditd.conf

sed -i "s/admin_space_left = 50/admin_space_left = 75/" /etc/audit/auditd.conf

sed -i "s/space_left_action = SYSLOG/space_left_action = email/" /etc/audit/auditd.conf

chown root:root /etc/audit/auditd.conf

chmod 0600 /etc/audit/auditd.conf

# Part 3

chkconfig --level 35 auditd on
chkconfig --level 35 sysstat on

# Enable auditd and sysstat services, good even if rebooting soon

service auditd restart


