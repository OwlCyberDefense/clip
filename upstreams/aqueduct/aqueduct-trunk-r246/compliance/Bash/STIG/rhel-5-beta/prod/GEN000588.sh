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
#
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com
#  on 06-apr-2012 to add raid modules to the initrd if needed.

								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-23825
#Group Title: GEN000588
#Rule ID: SV-28761r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000588
#Rule Title: The system must use a FIPS 140-2 validated cryptographic 
#module (operating in FIPS mode) for generating system password hashes.
#
#Vulnerability Discussion: Cryptographic modules used by the system 
#must be validated by the NIST CVMP as compliant with FIPS 140-2. 
#Cryptography performed by modules that are not validated is viewed by 
#NIST as providing no protection for the data.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Determine if the system uses a FIPS 140-2 validated cryptographic 
#module (operating in FIPS mode) for generating system password hashes. 
#The NIST CVMP web site provides a list of validated modules and the 
#required security policies for the compliant use of such modules. 
#Verify that the module is on this list and configured in accordance 
#with the validated security policy.
#
#If the system does not use a FIPS 140-2 validated cryptographic module
#(operating in FIPS mode) for generating system password hashes, this 
#is a finding.
#
#Fix Text: Configure the system to use a FIPS 140-2 validated 
#cryptographic module (operating in FIPS mode) for generating system 
#password hashes.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000588
FIPSENABLE=$( cat /proc/sys/crypto/fips_enabled )
SSHDFIPS=$( grep -c "Ciphers aes128-ctr,aes192-ctr,aes256-ctr" /etc/ssh/sshd_config )
SSHFIPS=$( grep -c "Ciphers aes128-ctr,aes192-ctr,aes256-ctr" /etc/ssh/ssh_config )

#Start-Lockdown

if [ $FIPSENABLE = 0 ]
  then
#ALL ITEMS MUST REMAIN IN THIS ORDER....... Otherwise FIPS is not installed correctly
#and your newly STIG'd system will STB @ Boot.
    sed -i 's/PRELINKING=yes/PRELINKING=no/g' /etc/sysconfig/prelink
    prelink -u -a
    for RMOD in `lsmod | grep ^raid | cut -d " " -f 1`
    do
      RAID_ADDITIONS="$RAID_ADDITIONS --preload $RMOD --with=$RMOD"
    done
    if [ -z RAID ]
    then
      mkinitrd --with-fips -f /boot/initrd-$(uname -r).img $(uname -r)
    else
      mkinitrd $RAID_ADDITIONS --with-fips -f /boot/initrd-$(uname -r).img $(uname -r)
    fi
    sed -i '/kernel/ {/fips=1/! s/.*/& fips=1/}' /boot/grub/grub.conf  
fi

if [ $SSHDFIPS = 0 ]
  then
    echo " " >> /etc/ssh/sshd_config
    echo "#Added by Vincent C. Passaro" >> /etc/ssh/sshd_config
    echo "#For compliance of GEN000588 (FIPS 140-2)" >> /etc/ssh/sshd_config
    echo "Ciphers aes128-ctr,aes192-ctr,aes256-ctr" >> /etc/ssh/sshd_config
    echo "MACs hmac-sha1" >> /etc/ssh/sshd_config
fi

if [ $SSHFIPS = 0 ]
  then
    echo " " >> /etc/ssh/ssh_config
    echo "#Added by Vincent C. Passaro" >> /etc/ssh/ssh_config
    echo "#For compliance of GEN000588 (FIPS 140-2)" >> /etc/ssh/ssh_config
    echo "Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc" >> /etc/ssh/ssh_config
    echo "MACs hmac-sha1" >> /etc/ssh/ssh_config
fi

