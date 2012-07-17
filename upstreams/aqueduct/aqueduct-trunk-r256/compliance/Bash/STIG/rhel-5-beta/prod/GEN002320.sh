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
# on 18-jan-2012 to update udev and pam_console rules for audio devices.
#
#
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 18-jan-2012 to remove pam_console rules and change the udev rule to run
# after the default audio rules.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1048
#Group Title: An audio device is more permissive than 644.
#Rule ID: SV-27245r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002320
#Rule Title: Audio devices must have mode 0664 or less permissive.
#
#Vulnerability Discussion: Audio and video devices that are globally 
#accessible have proven to be another security hazard. There is 
#software that can activate system microphones and video devices 
#connected to user workstations and/or X terminals. Once the 
#microphone has been activated, it is possible to eavesdrop on 
#otherwise private conversations without the victim being aware of 
#it. This action effectively changes the user's microphone to a 
#bugging device.
#
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the mode of audio devices.
# ls -lL /dev/audio* /dev/snd/*
#If the mode of audio devices are more permissive than 0644, this 
#is a finding.
#
#Fix Text: Change the mode of audio devices.
# chmod 0644 <audio device>
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002320

# Start Lockdown

# We are taking the audio rules from the 50-udev.rules default file and
# overriding them.
if [ ! -e "/etc/udev/rules.d/99-GEN002320.rules" ]
then

cat << EOF > /etc/udev/rules.d/99-GEN002320.rules

# audio devices
KERNEL=="dsp*",                 OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="audio*",               OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="midi*",                OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="mixer*",               OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="sequencer*",           OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="sound/*",              OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="snd/*",                OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="beep",                 OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="admm*",                OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="adsp*",                OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="aload*",               OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="amidi*",               OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="dmfm*",                OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="dmmidi*",              OWNER="root", GROUP="audio", MODE="0640"
KERNEL=="sndstat",              OWNER="root", GROUP="audio", MODE="0640"
EOF

  chown root:root /etc/udev/rules.d/99-GEN002320.rules
  chmod 644 /etc/udev/rules.d/99-GEN002320.rules
  chcon system_u:object_r:etc_t /etc/udev/rules.d/99-GEN002320.rules

fi

