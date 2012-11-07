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

###########################################
# Aqueduct Firefox Lockdown
# home: https://fedorahosted.org/aqueduct/wiki
# mailing list: https://fedorahosted.org/mailman/listinfo/aqueduct
#
#By Vincent C. Passaro
#vincent.passaro@fotisnetworks.com
############################################


1. Disclaimer
2. Firefox lockdown overview
3. Things the script does not do. 
3. Help

############################################
1. Disclaimer

If you haven't read the DISA Firefox STIG, don't run this script.  

Go read the STIG so you can understand what is happening.

############################################
2. Firefox lockdown overview

To lock down Firefox you must first have the settings you want to adjust.  
This can be obtained from the IASE DISA website.  

After you have identified what settings you want to adjust, a config
file must be created declaring the settings.  For the Aqueduct
lockdown content we call the config file mozilla-aqueduct-stig.cfg.  

The mozilla-aqueduct-stig.cfg file must reside in the following directory:

/usr/lib64/firefox-3.6/

*NOTE*  The version of Firefox will change the directory name <firefox-3.6>.  
I'm only using this as an example as it was the current version installed on
RHEL 6 at the time of writing.

Global configuration settings are contained in the all-redhat.js file. 

For 64 bit systems this file is located in:

	/usr/lib64/firefox-3.6/defaults/preferences/all-redhat.js

For 32 bit systems this file is located in: 

	/usr/lib/firefox-3.6/defaults/preferences/all-redhat.js

*NOTE*  The version of firefox will change the directory name <firefox-3.6>.  
I am only using this as an example as it was the current version installed on
RHEL 6 at the time of writing.


The following lines point firefox to the mozilla-aqueduct-stig.cfg file:

	pref("general.config.filename", "mozilla-aqueduct-stig.cfg");

The next line needed tells Firefox is the config file is encoded:

	pref("general.config.obscure_value", 0);

A quick overview on encoding.

Config files can be obscured from view by doing a 13-byte shift encoding. 

Now many security people are going to argue that Aqueduct should obscure the
config so that users on the system cannot figure out what has been locked down. 

HOWEVER, any user with 1/2 a brain that understands how Firefox works will easily be able to see
what settings are globally set (shows value italicized). So please do not even bring it up!

############################################
3. Things the script does not do

One of the requirements for the Firefox STIG is to install the DoD root Certs.  At
this time the Aqueduct Firefox lockdown script does not do this.  

This is extremely complicated to accomplish since the STIG is vague.  
If an auditor were to do this checklist to the letter of the law they
would have to log into the system with EVERY user account and 
verify that the settings are applied and that the DoD Certs have been 
installed. Hence why we do this from a global configuration perspective. 

For more information on which checks are not addressed, see mozilla-aqueduct-stig.cfg

############################################
4. Help
	aqueduct@lists.fedorahosted.org
	Mailing List: https://fedorahosted.org/mailman/listinfo/aqueduct



