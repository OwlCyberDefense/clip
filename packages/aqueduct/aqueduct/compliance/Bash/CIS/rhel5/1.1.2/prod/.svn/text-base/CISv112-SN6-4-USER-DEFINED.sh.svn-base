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
#By Tummy a.k.a Vincent C. Passaro                                   #
#Vincent[.]Passaro[@]gmail[.]com                                     #
#www.vincentpassaro.com                                              #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 06-dec-2011|
#|          |   Creation            |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#6.4 Configure syslogd to Send Logs to a Remote LogHost
#Description:
#Remote logging is essential in detecting intrusion and monitoring 
#several servers operating in concert. An intruder – once he/she has 
#obtained root – can edit the system logs to remove all traces of the 
#attack. If the logs are stored off the machine, those logs can be 
#analyzed for anomalies and used for prosecuting the attacker.

#In the script below, replace loghost with the proper name (FQDN, as necessary) of the loghost in this systems environment.

#printf "# Following 6 lines added per CIS RHEL5 Benchmark sec 6.4 \
#kern.warning;*.err\t\t\t@loghost\n \
#*.info;mail.none;authpriv.none;cron.none\t@loghost\n \
#*.emerg\t@loghost\n \
#auth.*\t\t\t\t@loghost\n \
#authpriv.*\t\t\t\t@loghost\n \
#local7.*\t@loghost\n " >> /etc/syslog.conf