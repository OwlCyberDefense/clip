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

#7.2 Add 'nosuid' and 'nodev' Option For Removable Media In /etc/fstab
#Description:
#Removable media is one vector by which malicious software can be introduced 
#onto the system. By forcing these file systems to be mounted with appropriate 
#secure options, the administrator prevents users from bringing hostile 
#programs onto the system via CDROMs, floppy disks, USB drives, etc.


FSTAB=/etc/fstab
SED=/bin/sed

    #nosuid and acl on /home
    if [ $(grep " \/home " ${FSTAB} | grep -c "nosuid") -eq 0 ]; then
            MNT_OPTS=$(grep " \/home " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/home.*${MNT_OPTS}\)/\1,nosuid,acl/" ${FSTAB}
    fi

    #nosuid and acl on /sys
    if [ $(grep " \/sys " ${FSTAB} | grep -c "nosuid") -eq 0 ]; then
            MNT_OPTS=$(grep " \/sys " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/sys.*${MNT_OPTS}\)/\1,nosuid,acl/" ${FSTAB}
    fi

    #nosuid and acl on /boot
    if [ $(grep " \/boot " ${FSTAB} | grep -c "nosuid") -eq 0 ]; then
            MNT_OPTS=$(grep " \/boot " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/boot.*${MNT_OPTS}\)/\1,nosuid,acl/" ${FSTAB}
    fi

    #nodev and acl on /usr
    if [ $(grep " \/usr " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/usr " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/usr.*${MNT_OPTS}\)/\1,nodev,acl/" ${FSTAB}
    fi

    #nodev and acl on /home
    if [ $(grep " \/home " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/home " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/home.*${MNT_OPTS}\)/\1,nodev,acl/" ${FSTAB}
    fi

    #nodev and acl on /usr/local
    if [ $(grep " \/usr\/local " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/usr\/local " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/usr\/local.*${MNT_OPTS}\)/\1,nodev,acl/" ${FSTAB}
    fi