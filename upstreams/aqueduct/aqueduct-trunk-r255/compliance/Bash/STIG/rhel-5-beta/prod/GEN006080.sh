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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 13-Feb-2012 to move from dev to prod an create the fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1026
#Group Title: Samba Web Administration with SSH Port Forwarding
#Rule ID: SV-1026r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006080
#Rule Title: The Samba Web Administration Tool (SWAT) must be
#restricted to the local host or require SSL.
#
#Vulnerability Discussion: SWAT is a tool used to configure Samba
#which uses its own small web server. As it modifies Samba configuration,
#which can impact system security, it must be protected from
#unauthorized access. SWAT authentication may involve the root
#password, which must be protected by encryption when traversing the network.
#
#Restricting access to the local host allows for the use of SSH
#TCP forwarding, if configured, or administration by a web browser on the local system.
#
#Responsibility: System Administrator
#IAControls: EBRP-1
#
#Check Content: 
#SWAT is a tool for configuring Samba and should only be found
#on a system that has a requirement for Samba. If SWAT is used,
#it must be utilized with SSH to ensure a secure connection between the client and the server.
#
#Procedure:
#
# grep /sbin/swat /etc/xinetd.d/*|cut -d: -f1 |xargs grep port|sed "s/[^0-9]*\([0-9]*\).*/\1/"|xargs -IPORT egrep "^\[|connect.*PORT" /etc/stunnel/stunnel.conf
#
#If the "port" from the xinetd.d file which starts /usr/sbin/swat does not correspond to the "connect =" line of the "[swat]" area of /etc/stunnel/stunnel.conf then SWAT has not been configured to use SSH. This is a finding.
#
#
#Fix Text: Disable SWAT or require that SWAT is only accessed via SSH.
#
#Procedure:
#If swat is not needed for operation of the system remove the swat package:
# rpm -qa|grep swat
#
#Remove "samba-swat" or "samba3x-swat" dependiong on which one is installed
# rpm --erase samba-swat
#or
# rpm --erase samba3x-swat
#
#If swat is required but not at all times disable it when not needed.
#Modify the /etc/xinetd.d file for "swat" to contain a "disable = yes" line.
#
#To access using SSH:
#Follow vendor configuration documentation to create an stunnel for SWAT.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006080

#Start-Lockdown

rpm -q samba-swat > /dev/null
if [ $? -eq 0 ]
then
  yum -y remove samba-swat > /dev/null
fi

rpm -q samba3x-swat > /dev/null
if [ $? -eq 0 ]
then
  yum -y remove samba3x-swat > /dev/null
fi
