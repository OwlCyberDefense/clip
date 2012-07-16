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
#Group ID (Vulid): V-805
#Group Title: File systems mounted with nosuid
#Rule ID: SV-805r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002420
#Rule Title: Removable media, remote file systems, and any file system 
#that does not contain approved setuid files must be mounted with the 
#"nosuid" option.
#
#Vulnerability Discussion: The "nosuid" mount option causes the system 
#to not execute setuid files with owner privileges. This option must be 
#used for mounting any file system that does not contain approved setuid 
#files. Executing setuid files from untrusted file systems, or file 
#systems that do not contain approved setuid files, increases the 
#opportunity for unprivileged users to attain unauthorized administrative 
#access.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check /etc/fstab and verify that the "nosuid" mount option is used on 
#file systems mounted from removable media, network shares, or any other 
#file system that does not contain approved setuid or setgid files.
#
#Fix Text: Edit /etc/fstab and add the "nosuid" mount option to all file 
#systems mounted from removable media or network shares, and any file 
#system that does not contain approved setuid or setgid files.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002420
FSTAB=/etc/fstab
#Start-Lockdown

    # removed the acl option as the initial install has acl's enabled by
    # default and I can't find a STIG check that wants us to add the acl
    # option to filesystems.

    #nosuid on /home
    if [ $(grep " \/home " ${FSTAB} | grep -c "nosuid") -eq 0 ]; then
            MNT_OPTS=$(grep " \/home " ${FSTAB} | awk '{print $4}')
            sed -i "s/\( \/home.*${MNT_OPTS}\)/\1,nosuid/" ${FSTAB}
    fi

    #nosuid on /sys
    if [ $(grep " \/sys " ${FSTAB} | grep -c "nosuid") -eq 0 ]; then
            MNT_OPTS=$(grep " \/sys " ${FSTAB} | awk '{print $4}')
            sed -i "s/\( \/sys.*${MNT_OPTS}\)/\1,nosuid/" ${FSTAB}
    fi

    #nosuid on /boot
    if [ $(grep " \/boot " ${FSTAB} | grep -c "nosuid") -eq 0 ]; then
            MNT_OPTS=$(grep " \/boot " ${FSTAB} | awk '{print $4}')
            sed -i "s/\( \/boot.*${MNT_OPTS}\)/\1,nosuid/" ${FSTAB}
    fi

    #nodev on /usr
    if [ $(grep " \/usr " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/usr " ${FSTAB} | awk '{print $4}')
            sed -i "s/\( \/usr.*${MNT_OPTS}\)/\1,nodev/" ${FSTAB}
    fi

    #nodev on /home
    if [ $(grep " \/home " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/home " ${FSTAB} | awk '{print $4}')
            sed -i "s/\( \/home.*${MNT_OPTS}\)/\1,nodev/" ${FSTAB}
    fi

    #nodev on /usr/local
    if [ $(grep " \/usr\/local " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/usr\/local " ${FSTAB} | awk '{print $4}')
            sed -i "s/\( \/usr\/local.*${MNT_OPTS}\)/\1,nodev/" ${FSTAB}
    fi


