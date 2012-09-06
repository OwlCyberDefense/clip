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
#10.1 Create Warnings For Network And Physical Access Services
#Description:
#The contents of the /etc/issue file are displayed prior to the login 
#prompt on the system's console and serial devices. /etc/motd is generally 
#displayed after all successful logins, no matter where the user is 
#logging in from, but is thought to be less useful because it only provides 
#notification to the user after the machine has been accessed.

cat <<EOF > /etc/issue.net

        You are accessing a <COMPANY NAME> Information System (IS) that is
        provided for authorized use only.

        By using this IS (which includes any device attached to this IS), you
        consent to the following conditions:

        -The <COMPANY NAME> routinely intercepts and monitors communications on this IS for
        purposes including, but not limited to, penetration testing, COMSEC
        monitoring, network operations and defense, personnel misconduct (PM),
        law enforcement (LE), and counterintelligence (CI) investigations.

        -At any time, the <COMPANY NAME> may inspect and seize data stored on this IS.

        -Communications using, or data stored on, this IS are not private, are
        subject to routine monitoring, interception, and search, and may be
        disclosed or used for any <COMPANY NAME>-authorized purpose.

        -This IS includes security measures (e.g., authentication and access
        controls) to protect <COMPANY NAME> interests--not for your personal benefit or
        privacy.

        -Notwithstanding the above, using this IS does not constitute consent to
        PM, LE or CI investigative searching or monitoring of the content of
        privileged communications, or work product, related to personal
        representation or services by attorneys, psychotherapists, or clergy, and
        their assistants. Such communications and work product are private and
        confidential. See User Agreement for details.

EOF


cat <<EOF > /etc/motd

        You are accessing a <COMPANY NAME> Information System (IS) that is
        provided for authorized use only.

        By using this IS (which includes any device attached to this IS), you
        consent to the following conditions:

        -The <COMPANY NAME> routinely intercepts and monitors communications on this IS for
        purposes including, but not limited to, penetration testing, COMSEC
        monitoring, network operations and defense, personnel misconduct (PM),
        law enforcement (LE), and counterintelligence (CI) investigations.

        -At any time, the <COMPANY NAME> may inspect and seize data stored on this IS.

        -Communications using, or data stored on, this IS are not private, are
        subject to routine monitoring, interception, and search, and may be
        disclosed or used for any <COMPANY NAME>-authorized purpose.

        -This IS includes security measures (e.g., authentication and access
        controls) to protect <COMPANY NAME> interests--not for your personal benefit or
        privacy.

        -Notwithstanding the above, using this IS does not constitute consent to
        PM, LE or CI investigative searching or monitoring of the content of
        privileged communications, or work product, related to personal
        representation or services by attorneys, psychotherapists, or clergy, and
        their assistants. Such communications and work product are private and
        confidential. See User Agreement for details.

EOF

# Protect banner files:
chown root:root /etc/issue /etc/issue.net /etc/motd

chmod 0644 /etc/issue /etc/issue.net /etc/motd