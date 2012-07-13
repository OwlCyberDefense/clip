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
# on 18-jan-2012 to reference GEN002320.sh

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1061
#Group Title: Audio device group ownership.
#Rule ID: SV-27255r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002360
#Rule Title: Audio devices must be group-owned by audio, root, sys, 
#bin, or other.
#
#Vulnerability Discussion: Without privileged group owners, audio 
#devices will be vulnerable to being used as eaves-dropping devices 
#by malicious users or intruders to possibly listen to conversations 
#containing sensitive information.
#
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group-owner of audio devices.
#
#Procedure:
# ls -lL /dev/audio* /dev/snd/*
#
#If the group-owner of an audio device is not root, sys, bin, or 
#system, this is a finding.
#
#Fix Text: Change the group-owner of the audio device.
#
#Procedure:
# chgrp root <audio device>
#######################DISA INFORMATION###############################

#Pretty sure audio needs to be owned by audio.  Need to confirm

#Global Variables#
PDI=GEN002360

#Start-Lockdown

# See udev configuration in GEN002320.sh
