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
# Updated by Vincent C. Passaro (vincent.passaro@fotisnetworks.com) on
# 5/3/2012 to included checking for file before applying configuration
# as pointed out by Scott Shinn

#######################DISA INFORMATION###############################
#SN.2 Change Default Greeting String For sendmail
#Description:
#The default SMTP greeting string displays the version of the Sendmail 
#software running on the remote system. Hiding this information is generally 
#considered to be good practice, since it can help attackers target attacks 
#at machines running a vulnerable version of Sendmail. However, the actions 
#in the Benchmark document completely disable Sendmail on the system, so 
#changing this default greeting string is something of a moot point unless 
#the machine happens to be an email server.


#Bye Bye Decod
sed --in-place s/^decode\:/\#decode\:/ /etc/aliases

if [ -f /usr/bin/newaliases ]
	then
		/usr/bin/newaliases
		
		chown root:root /etc/aliases

		chmod 0644 /etc/aliases
fi



#Remove Version info From Greet line 
sed -i '/SmtpGreetingMessage/ c\
O SmtpGreetingMessage= Mail Server Ready ; $b' /etc/mail/sendmail.cf

#No help for you

mv /etc/mail/helpfile /etc/mail/helpfile.bak

echo "" > /etc/mail/helpfile

sed -i '/HelpFile/s/^/#/' /etc/mail/sendmail.cf


chown root:bin /etc/mail/sendmail.cf
chmod 0444     /etc/mail/sendmail.cf
