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
# on 18-jan-2012 to remove the acl option.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22368
#Group Title: GEN002430
#Rule ID: SV-26498r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002430
#Rule Title: Removable media, remote file systems, and any file system 
#that does not contain approved device files must be mounted with the "nodev" 
#option.
#
#Vulnerability Discussion: The "nodev" (or equivalent) mount option 
#causes the system to not handle device files as system devices. This 
#option must be used for mounting any file system that does not contain 
#approved device files. Device files can provide direct access to system 
#hardware and can compromise security if not protected.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check /etc/fstab and verify that the "nodev" mount option is used on any 
#filesystems mounted from removable media or network shares. If any filesystem 
#mounted from removable media or network shares does not have this option, 
#this is a finding.
#
#Fix Text: Edit /etc/fstab and add the "nodev" option to any filesystems 
#mounted from removable media or network shares.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002430

#Start-Lockdown

 FSTAB=/etc/fstab
    SED=/bin/sed
    #nosuid on /home
    if [ $(grep " \/home " ${FSTAB} | grep -c "nosuid") -eq 0 ]; then
            MNT_OPTS=$(grep " \/home " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/home.*${MNT_OPTS}\)/\1,nosuid/" ${FSTAB}
    fi

    #nosuid on /sys
    if [ $(grep " \/sys " ${FSTAB} | grep -c "nosuid") -eq 0 ]; then
            MNT_OPTS=$(grep " \/sys " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/sys.*${MNT_OPTS}\)/\1,nosuid/" ${FSTAB}
    fi

    #nosuid on /boot
    if [ $(grep " \/boot " ${FSTAB} | grep -c "nosuid") -eq 0 ]; then
            MNT_OPTS=$(grep " \/boot " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/boot.*${MNT_OPTS}\)/\1,nosuid/" ${FSTAB}
    fi

    #nodev on /usr
    if [ $(grep " \/usr " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/usr " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/usr.*${MNT_OPTS}\)/\1,nodev/" ${FSTAB}
    fi

    #nodev on /home
    if [ $(grep " \/home " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/home " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/home.*${MNT_OPTS}\)/\1,nodev/" ${FSTAB}
    fi

    #nodev on /usr/local
    if [ $(grep " \/usr\/local " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/usr\/local " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/usr\/local.*${MNT_OPTS}\)/\1,nodev/" ${FSTAB}
    fi
