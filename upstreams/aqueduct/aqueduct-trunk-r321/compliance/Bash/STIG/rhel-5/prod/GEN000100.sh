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
# Group ID (Vulid): V-11940
# Group Title: GEN000100
# Rule ID: SV-27049r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN000100
# Rule Title: The operating system must be a supported release.
#
# Vulnerability Discussion: An operating system release is considered 
# "supported" if the vendor continues to provide security patches for the 
# product.  With an unsupported release, it will not be possible to resolve 
# security issues discovered in the system software.
#
# Responsibility: System Administrator
# IAControls: VIVM-1
#
# Check Content:
#
# Check the version of the operating system.

# Example:
# cat /etc/redhat-release

# Vendor End-of-Support Information:
# Red Hat Enterprise 5: 31 Mar 2014

# Check with the vendor for additional information.

# If the version installed is not supported, this is a finding.
#
# Fix Text: 
#
# Upgrade to a supported version of the operating system.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000100
	
# Start-Lockdown

CURRENTDATE=`date +%F`
RHEL6EOL="2020-11-30"
RHEL5EOL="2017-03-31"
RHEL4EOL="2012-02-29"
RHEL3EOL="2010-10-31"
RELEASE6=`grep -c "6." /etc/redhat-release`
RELEASE5=`grep -c "5." /etc/redhat-release`
RELEASE4=`grep -c "4." /etc/redhat-release`
RELEASE3=`grep -c "3." /etc/redhat-release`

if [ $RELEASE6 -eq 1 ]
then
  if [[ "$CURRENTDATE" > "$RHEL6EOL" ]]
    then
      echo "------------------------------" > $PDI-error.log
      date >> $PDI-error.log
      echo " " >> $PDI-error.log
      echo "RHEL 6 is no longer supported." >> $PDI-error.log
      echo "THIS IS A CAT I FINDING" >> $PDI-error.log
      echo "------------------------------" >> $PDI-error.log
 fi
fi

if [ $RELEASE5 -eq 1 ]
then
  if [[ "$CURRENTDATE" > "$RHEL5EOL" ]]
    then
      echo "------------------------------" > $PDI-error.log
      date >> $PDI-error.log
      echo " " >> $PDI-error.log
      echo "RHEL 5 is no longer supported." >> $PDI-error.log
      echo "THIS IS A CAT I FINDING" >> $PDI-error.log
      echo "------------------------------" >> $PDI-error.log
 fi
fi

if [ $RELEASE4 -eq 1 ]
then
  if [[ "$CURRENTDATE" > "$RHEL4EOL" ]]
    then
      echo "------------------------------" > $PDI-error.log
      date >> $PDI-error.log
      echo " " >> $PDI-error.log
      echo "RHEL 4 is no longer supported." >> $PDI-error.log
      echo "THIS IS A CAT I FINDING" >> $PDI-error.log
      echo "------------------------------" >> $PDI-error.log
 fi
fi

if [ $RELEASE3 -eq 1 ]
then
  if [[ "$CURRENTDATE" > "$RHEL3EOL" ]]
    then
      echo "------------------------------" > $PDI-error.log
      date >> $PDI-error.log
      echo " " >> $PDI-error.log
      echo "RHEL 3 is no longer supported." >> $PDI-error.log
      echo "THIS IS A CAT I FINDING" >> $PDI-error.log
      echo "------------------------------" >> $PDI-error.log
 fi
fi

