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
#Group ID (Vulid): V-1049
#Group Title: Audio device ownership.
#Rule ID: SV-27250r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002340
#Rule Title: Audio devices must be owned by root.
#
#Vulnerability Discussion: Audio and video devices that are globally 
#accessible have proven to be another security hazard. There is software 
#that can activate system microphones and video devices connected to 
#user workstations and/or X terminals. Once the microphone has been 
#activated, it is possible to eavesdrop on otherwise private conversations 
#without the victim being aware of it. This action effectively changes 
#the user's microphone to a bugging device.
#
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the owner of audio devices.
# ls -lL /dev/audio* /dev/snd/*
#If the owner of any audio device file is not root, this is a finding.
#
#Fix Text: Change the owner of the audio device.
# chown root <audio device>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002340


#Start-Lockdown

# See udev configuration in GEN002320.sh

