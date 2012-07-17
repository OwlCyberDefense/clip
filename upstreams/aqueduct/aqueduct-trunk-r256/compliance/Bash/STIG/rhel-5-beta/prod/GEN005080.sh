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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-847
#Group Title: TFTP Secure Mode
#Rule ID: SV-28421r1_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN005080
#Rule Title: The TFTP daemon must operate in "secure mode" which provides access only to a single directory on the host file system.
#
#Vulnerability Discussion: Secure mode limits TFTP requests to a specific directory. If TFTP is not running in secure mode, it may be able to write to any file or directory and may seriously impair system integrity, confidentiality, and availability.
#
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
# grep server_args /etc/xinetd.d/tftp
#If the "-s" parameter is not specified, this is a finding.
#
#Fix Text: Edit /etc/xinetd.d/tftp file and specify the "-s" parameter in server_args.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005080
ISS=$(grep server_args /etc/xinetd.d/tftp | egrep '(-s)' | wc -l )

#Start-Lockdown

if [ $ISS -lt 1 ]
  then
    sed  -i "/server_args/ c\        server_args             = -s /tftpboot" /etc/xinetd.d/tftp
fi

    