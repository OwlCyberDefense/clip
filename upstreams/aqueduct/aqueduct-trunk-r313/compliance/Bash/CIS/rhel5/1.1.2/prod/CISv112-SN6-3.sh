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
#6.3 Confirm Permissions On System Log Files
#Description:
#It is critical to protect system log files from being modified by 
#unauthorized individuals. Also, certain logs contain sensitive data 
#that should only be available to the System Administrator.


touch /var/log/btmp

chown root:root /var/log/btmp

chmod 0600 /var/log/btmp

# Part 2
#echo "LogPerms Part 1."
	for LogFile in \
		/var/log/boot.log \
		/var/log/btmp \
		/var/log/cron \
		/var/log/dmesg \
		/var/log/ksyms \
		/var/log/httpd \
		/var/log/lastlog \
		/var/log/maillog \
		/var/log/mailman \
		/var/log/messages \
		/var/log/news \
		/var/log/pgsql \
		/var/log/rpmpkgs \
		/var/log/sa \
		/var/log/samba \
		/var/log/scrollkeeper.log \
		/var/log/secure \
		/var/log/spooler \
		/var/log/squid \
		/var/log/vbox \
		/var/log/wtmp
	do
		# This check allows only entries that exist to have permissions set.
		# Visually cleaner for the person running it.
		if [ -e ${LogFile} ]; then
		# Utilizing recursive here is harmless when applied to a single file.
			chmod -R o-rwx ${LogFile}*
		else
			echo "LogFile didn't exist ($LogFile)."
		fi
done

#echo "LogPerms Part 3."
	for LogFile in \
		/var/log/boot.log \
		/var/log/cron \
		/var/log/httpd \
		/var/log/lastlog \
		/var/log/maillog \
		/var/log/mailman \
		/var/log/messages \
		/var/log/pgsql \
		/var/log/sa \
		/var/log/samba \
		/var/log/secure \
		/var/log/spooler
	do
		if [ -e ${LogFile} ]; then
			chmod -R g-rx ${LogFile}*
		else
			echo "LogFile didn't exist ($LogFile)."
		fi
done

#echo "LogPerms Part 4."
	for LogFile in \
		/var/log/gdm \
		/var/log/httpd \
		/var/log/news \
		/var/log/samba \
		/var/log/squid \
		/var/log/sa \
		/var/log/vbox
	do
		if [ -e ${LogFile} ]; then
			chmod -R o-w ${LogFile}*
		else
			echo "LogFile didn't exist ($LogFile)."
		fi
done

#echo "LogPerms Part 5."
	for LogFile in \
		/var/log/httpd \
		/var/log/samba \
		/var/log/squid \
		/var/log/sa
	do
		if [ -e ${LogFile} ]; then
			chmod -R o-rx ${LogFile}*
		else
			echo "LogFile didn't exist ($LogFile)."
		fi
done

#echo "LogPerms Part 6."
	for LogFile in \
		/var/log/kernel \
		/var/log/lastlog \
		/var/log/mailman \
		/var/log/syslog \
		/var/log/loginlog
	do
		if [ -e ${LogFile} ]; then
			chmod -R u-x ${LogFile}*
		else
			echo "LogFile didn't exist ($LogFile)."
		fi
done

#echo "LogPerms Part 7."
# Removing group write permissions to btmp and wtmp

chmod g-w /var/log/btmp

chmod g-w /var/log/wtmp

	awk '( $1 == "chmod" && $2 == "0664" && $3 == "/var/run/utmp" && $4 == "/var/log/wtmp" ) {
	print "chmod 0600 /var/run/utmp /var/log/wtmp"; next };
	( $1 == "chmod" && $2 == "0664" && $3 == "/var/run/utmpx" && $4 == "/var/log/wtmpx" ) {
	print " chmod 0600 /var/run/utmpx /var/log/wtmpx"; next };
	{ print }' /etc/rc.d/rc.sysinit > /etc/rc.d/rc.sysinit.new

	mv /etc/rc.d/rc.sysinit.new /etc/rc.d/rc.sysinit

	
	chown root:root /etc/rc.d/rc.sysinit
	chmod 0700 /etc/rc.d/rc.sysinit

[ -e /var/log/news ] && chown -R news:news /var/log/news
[ -e /var/log/pgsql ] && chown postgres:postgres /var/log/pgsql
[ -e /var/log/squid ] && chown -R squid:squid /var/log/squid
[ -e /var/log/lastlog ] && chmod 0600 /var/log/lastlog



