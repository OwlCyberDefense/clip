#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
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
##########################################################################

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-1048
# Group Title: GEN002320
# Rule ID: SV-37566r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002320
# Rule Title: Audio devices must have mode 0660 or less permissive.
#
# Vulnerability Discussion: Audio and video devices that are globally 
# accessible have proven to be another security hazard.  There is software 
# that can activate system microphones and video devices connected to user 
# workstations and/or X terminals.  Once the microphone has been activated, 
# it is possible to eavesdrop on otherwise private conversations without 
# the victim being aware of it.  This action effectively changes the user's 
# microphone into a bugging device.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the mode of audio devices.
# ls -lL /dev/audio* /dev/snd/*
# If the mode of audio devices are more permissive than 660, this is a 
# finding.
#
# Fix Text: 
#
# Change the mode of audio devices.
# chmod 0660 <audio device>  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002320
	
# Start-Lockdown

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

