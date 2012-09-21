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
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.1   | Move sendmail file    | Leam Hall          | 13-APR-2012|
#|          |  checks.              |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-23952
#Group Title: GEN004710
#Rule ID: SV-28908r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004710
#Rule Title: Mail relaying must be restricted.
#
#Vulnerability Discussion: If unrestricted mail relaying is permitted, unauthorized senders could use this host as a mail relay for the purpose of sending SPAM or other unauthorized activity.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If the system uses Sendmail, locate the sendmail.cf file.
#Procedure:
#Determine if Sendmail only binds to loopback addresses by examining the "DaemonPortOptions" configuration options.
#Procedure:
# grep -i "O DaemonPortOptions" /setc/mail/sendmail.cf;
#
#If there are uncommented DaemonPortOptions lines, and all such lines specify system loopback addresses, this is not a finding.
#
#Otherwise, determine if Sendmail is configured to allow open relay operation.
#Procedure:
# grep -i promiscuous_relay /etc/mail/sendmail.mc;
#
#If the promiscuous relay feature is enabled, this is a finding.
#
#If the system uses Postfix, locate the main.cf file.
#Procedure:
# find / -name main.cf
#
#Determine if Postfix only binds to loopback addresses by examining the "inet_interfaces" line.
#Procedure:
# grep inet_interfaces </path/to/main.cf>
#
#If "inet_interfaces" is set to "loopback-only" or contains only loopback addresses such as 127.0.0.1 and [::1], Postfix is not listening on external network interfaces, and this is not a finding.
#
#Otherwise, determine if Postfix is configured to restrict clients permitted to relay mail by examining the "smtpd_client_restrictions" line.
#Procedure:
# grep smtpd_client_restrictions </path/to/main.cf>
#
#If the "smtpd_client_restrictions" line is missing, or does not contain "reject", this is a finding. If the line contains "permit" before "reject", this is a finding.
#
#If the system is using other SMTP software, consult the software's documentation for procedures to verify that mail relaying is restricted.
#
#
#Fix Text: If the system uses Sendmail, edit the sendmail.mc file and remove the "promiscuous_relay" configuration.
#Rebuild the sendmail.cf file from the modified sendmail.mc and restart the service. If the system does not need to
#receive mail from external hosts, add one or more DaemonPortOptions lines referencing system loopback addresses
#(such as "O DaemonPortOptions=Addr=127.0.0.1,Port=smtp,Name=MTA") and remove lines containing non-loopback
#addresses. Restart the service.
#
#If the system uses Postfix, edit the main.cf file and add or edit the "smtpd_client_restrictions"
#line to have contents "permit mynetworks, reject" or a similarly restrictive rule. If the system does
#not need to receive mail from external hosts, add or edit the "inet_interfaces" line to have contents
#"loopback-only" or a set of loopback addresses for the system. Restart the service.
#
#If the system is using other SMTP software, consult the software's documentation for procedures to restrict mail relaying.  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004710

#Start-Lockdown

#This is going to assume that any configuration outside the default (localhost only) was done on purpose and we will not adjust any of it, only the insecure options. 

#
#
#SENDMAIL SECTION
#
#
#
#Check if sendmail is installed
if [ -a '/etc/mail/sendmail.mc' ]
  then
    #Check if promiscuous relay is enabled
	RELAYON=$( grep -i promiscuous_relay /etc/mail/sendmail.mc | wc -l )
	SENDMAILON=$( service sendmail status | grep -c running )
    if [ $RELAYON -ne 0 ]
      then
        sed "/promiscuous_relay/d" /etc/mail/sendmail.mc
        
        #Check if sendmail service is running
          if [ $SENDMAILON -eq 1 ]
            then
              service sendmail restart
          fi
    fi
fi

#This really cant be done as we dont know all the address spaces that would be used with postfix. 




    
