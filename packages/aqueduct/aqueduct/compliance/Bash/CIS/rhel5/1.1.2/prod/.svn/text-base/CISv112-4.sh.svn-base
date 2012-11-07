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

#4 Minimize boot services

#UD=USER DEFIEND

#CIS benchmarks call two different sections for service configuration.
#The first script below is exactly out of the CIS benchmarks and wants all 
#services disabled....  This will fail during checks because they want services
#like anacron ON...
#
#This is just poor documentation from CIS and should be addressed.
#
#So, to apply some logic.  We will use their script to shut everything OFF
#and then turn the services BACK on that.

#

for SERVICE in \
	acpid \
	amd \
	anacron \
	apmd \
	arptables_jf \
	aprwatch \
	atd \
	autofs \
	avahi-daemon \
	avahi-dnsconfd \
	bpgd \
	bluetooth \
	bootparamd \
	capi \
	conman \
	cups \
	cyrus-imapd \
	dc_client \
	dc_server \
	dhcdbd \
	dhcp6s \
	dhcpd \
	dhcrelay \
	dovecot \
	dund \
	firstboot \
	gpm \
	haldaemon \
	hidd \
	hplip \
	httpd \
	ibmasm \
	ip6tables \
	ipmi \
	irda \
	iscsi \
	iscsid \
	isdn \
	kadmin \
	kdump \
	kprop \
	krb524 \
	krb5kdc \
	kudzu \
	ldap \
	lisa \
	lm_sensors \
	mailman \
	mcstrans \
	mdmonitor \
	mdmpd \
	microcode_ctl \
	multipathd \
	mysqld \
	named \
	netfs \
	netplugd \
	NetworkManager \
	nfs \
	nfslock \
	nscd \
	ntpd \
	openibd \
	ospf6d \
	ospfd \
	pand \
	pcscd \
	portmap \
	postgresql \
	privoxy \
	psacct \
	radvd \
	rarpd \
	rdisc \
	readahead_early \
	readahead_later \
	rhnsd \
	ripd \
	ripngd \
	rpcgssd \
	rpcidmapd \
	rpcsvcgssd \
	rstatd \
	rusersd \
	rwhod \
	saslauthd \
	setroubleshoot \
	smartd \
	smb \
	snmpd \
	snmptrapd \
	spamassassin \
	squid \
	tog-pegasus \
	tomcat5 \
	tux \
	winbind \
	wine \
	wpa_supplicant \
	xend \
	xendomains \
	ypbind \
	yppasswdd \
	ypserv \
	ypxfrd \
	zebra;

	do
		if [ -e /etc/init.d/$SERVICE ]
			then
			# Doing business this way causes less needless errors that a
			# reviewer of the hardening process doesn't need to deal with.
				service $SERVICE stop
				chkconfig --level 12345 $SERVICE off
			else
				echo "SERVICE doesn't exist on this system ($SERVICE)."
		fi
done

chkconfig --level 2345 acpid off
chkconfig --level 2345 amd off
chkconfig --level 2345 anacron on
service anacron start
#chkconfig --level 2345 apmd UD
chkconfig --level 2345 arptables_jf off
chkconfig --level 2345 arpwatch off
chkconfig --level 2345 atd off	
chkconfig --level 2345 auditd on
service auditd start
chkconfig --level 2345 autofs off
chkconfig --level 2345 avahi-daemon off
chkconfig --level 2345 avahi-dnsconfd off
chkconfig --level 2345 bgpd off
chkconfig --level 2345 bluetooth off
chkconfig --level 2345 bootparamd off
chkconfig --level 2345 capi off
chkconfig --level 2345 conman off
chkconfig --level 2345 cpuspeed off
chkconfig --level 2345 crond on
service crond start
chkconfig --level 2345 cups off
chkconfig --level 2345 cyrus-imapd off
chkconfig --level 2345 dc_client off
chkconfig --level 2345 dc_server off
chkconfig --level 2345 dhcdbd off
chkconfig --level 2345 dhcp6s off
chkconfig --level 2345 dhcpd off
chkconfig --level 2345 dhcrelay off
chkconfig --level 2345 dovecot off
chkconfig --level 2345 dund off
chkconfig --level 2345 firstboot on
service firstboot start
chkconfig --level 2345 gpm off
chkconfig --level 2345 haldaemon off
chkconfig --level 2345 hidd off	
chkconfig --level 2345 hplip off
chkconfig --level 2345 httpd off
chkconfig --level 2345 ibmasm off
chkconfig --level 2345 innd off
#chkconfig --level 2345 ip6tables UD
chkconfig --level 2345 ipmi off
#chkconfig --level 2345 iptables UD
chkconfig --level 2345 irda off
chkconfig --level 2345 irqbalance on
#chkconfig --level 2345 iscsi UD
#chkconfig --level 2345 iscsid UD
chkconfig --level 2345 isdn off
chkconfig --level 2345 kadmin off
chkconfig --level 2345 kdump off
chkconfig --level 2345 kprop off
chkconfig --level 2345 krb524 off
chkconfig --level 2345 krb5kdc off
chkconfig --level 2345 kudzu off
chkconfig --level 2345 ldap off
chkconfig --level 2345 lisa off
#chkconfig --level 2345 lm_sensors UD
chkconfig --level 2345 mailman off
#chkconfig --level 2345 mcstrans UD
#chkconfig --level 2345 mdmonitor UD
chkconfig --level 2345 mdmpd off
chkconfig --level 2345 messagebus on
service messagebus start
#chkconfig --level 2345 microcode_ctl UD
chkconfig --level 2345 multipathd off
chkconfig --level 2345 mysqld off
chkconfig --level 2345 named off
chkconfig --level 2345 netfs off
chkconfig --level 2345 netplugd off
chkconfig --level 2345 network on #This was UD..you're kidding me right?  No network?
chkconfig --level 2345 NetworkManager off
chkconfig --level 2345 NetworkManagerDispatcher on
service NetworkManagerDispatcher start
chkconfig --level 2345 nfs off
chkconfig --level 2345 nfslock off
chkconfig --level 2345 nscd off
chkconfig --level 2345 ntpd on
service ntpd start
chkconfig --level 2345 openibd off
chkconfig --level 2345 ospf6d off
chkconfig --level 2345 ospfd off
chkconfig --level 2345 pand off
chkconfig --level 2345 pcscd off
chkconfig --level 2345 portmap off
chkconfig --level 2345 postfix off
chkconfig --level 2345 postgresql off
chkconfig --level 2345 privoxy off
chkconfig --level 2345 psacct off
chkconfig --level 2345 radiusd off
chkconfig --level 2345 radvd off
chkconfig --level 2345 rarpd off
chkconfig --level 2345 rdisc off
#chkconfig --level 2345 readahead_early UD
#chkconfig --level 2345 readahead_later UD
chkconfig --level 2345 restorecond on
service restorecond start
#chkconfig --level 2345 rhnsd UD
chkconfig --level 2345 ripd off
chkconfig --level 2345 ripngd off
chkconfig --level 2345 rpcgssd off
chkconfig --level 2345 rpcidmapd off
chkconfig --level 2345 rpcsvcgssd off
chkconfig --level 2345 rstatd off
chkconfig --level 2345 rusersd off
chkconfig --level 2345 rwhod off
chkconfig --level 2345 saslauthd off
chkconfig --level 2345 sendmail off
chkconfig --level 2345 setroubleshoot off
chkconfig --level 2345 smartd off
chkconfig --level 2345 smb off							
chkconfig --level 2345 snmpd off
chkconfig --level 2345 snmptrapd off
chkconfig --level 2345 spamassassin off
chkconfig --level 2345 squid off
chkconfig --level 2345 sshd on
service sshd start
chkconfig --level 2345 syslog on
service syslog start
chkconfig --level 2345 sysstat on
service sysstat start
chkconfig --level 2345 tog-pegasus off
chkconfig --level 2345 tomcat5 off
chkconfig --level 2345 tux off
chkconfig --level 2345 vncserver off
chkconfig --level 2345 vsftpd off
chkconfig --level 2345 winbind off
chkconfig --level 2345 wpa_supplicant off
chkconfig --level 2345 xend off
chkconfig --level 2345 xendomains off
chkconfig --level 2345 xfs off
chkconfig --level 2345 xinetd off
chkconfig --level 2345 ypbind off
chkconfig --level 2345 yppasswdd off
chkconfig --level 2345 ypserv off
chkconfig --level 2345 ypxfrd off
chkconfig --level 2345 yum-updatesd on
service yum-updatesd start
chkconfig --level 2345 zebra off
