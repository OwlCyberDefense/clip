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
# Group ID (Vulid): V-24331
# Group Title: GEN000402
# Rule ID: SV-37171r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000402
# Rule Title: The Department of Defense (DoD) login banner must be 
# displayed immediately prior to, or as part of, graphical desktop 
# environment login prompts.
#
# Vulnerability Discussion: Failure to display the logon banner prior to 
# a logon attempt will negate legal proceedings resulting from unauthorized 
# access to system resources.

# This requirement applies to graphical desktop environments provided by 
# the system to locally attached displays and input devices as well as to 
# graphical desktop environments provided to remote systems, including thin 
# clients.
#
# Responsibility: System Administrator
# IAControls: ECWM-1
#
# Check Content:
#
# Access the graphical desktop environment(s) provided by the system and 
# attempt to log in. Check for either of the following login banners based 
# on the character limitations imposed by the system. An exact match is 
# required. If one of these banners is not displayed, this is a finding.

# You are accessing a U.S. Government (USG) Information System (IS) that is 
# provided for USG-authorized use only.

# By using this IS (which includes any device attached to this IS), you 
# consent to the following conditions:

# -The USG routinely intercepts and monitors communications on this IS for 
# purposes including, but not limited to, penetration testing, COMSEC 
# monitoring, network operations and defense, personnel misconduct (PM), 
# law enforcement (LE), and counterintelligence (CI) investigations.

# -At any time, the USG may inspect and seize data stored on this IS.

# -Communications using, or data stored on, this IS are not private, are 
# subject to routine monitoring, interception, and search, and may be 
# disclosed or used for any USG-authorized purpose.

# -This IS includes security measures (e.g., authentication and access 
# controls) to protect USG interests- -not for your personal benefit or 
# privacy.

# -Notwithstanding the above, using this IS does not constitute consent to 
# PM, LE or CI investigative searching or monitoring of the content of 
# privileged communications, or work product, related to personal 
# representation or services by attorneys, psychotherapists, or clergy, and 
# their assistants. Such communications and work product are private and 
# confidential. See User Agreement for details. 

# OR

# I've read & consent to terms in IS user agreem't.
#
# Fix Text: 
#
# Configure the system to display one of the DoD login banners prior to, 
# or as part of, the graphical desktop environment login process.

# Procedure:
# Modify /usr/share/gdm/themes/RHEL/RHEL.xml by adding the following xml 
# after the first two "pixmap" entries.

# <item type="rect" id="custom-dod-banner">
# <pos anchor="nw" x="20%" y="10" width="80%" height="100%"/>
# <box>
# <item type="label">
# <normal font="Sans Bold 9" color="#ffffff"/>
# <text>
# Insert the "approved text" here based on the character limitations 
# imposed by the system.
# </text>
# </item>
# </box>
# </item>


# Approved text:

# DoD Login Banners:

# You are accessing a U.S. Government (USG) Information System (IS) that is 
# provided for USG-authorized use only.

# By using this IS (which includes any device attached to this IS), you 
# consent to the following conditions:

# -The USG routinely intercepts and monitors communications on this IS for 
# purposes including, but not limited to, penetration testing, COMSEC 
# monitoring, network operations and defense, personnel misconduct (PM), 
# law enforcement (LE), and counterintelligence (CI) investigations.

# -At any time, the USG may inspect and seize data stored on this IS.

# -Communications using, or data stored on, this IS are not private, are 
# subject to routine monitoring, interception, and search, and may be 
# disclosed or used for any USG-authorized purpose.

# -This IS includes security measures (e.g., authentication and access 
# controls) to protect USG interests--not for your personal benefit or 
# privacy.

# -Notwithstanding the above, using this IS does not constitute consent to 
# PM, LE or CI investigative searching or monitoring of the content of 
# privileged communications, or work product, related to personal 
# representation or services by attorneys, psychotherapists, or clergy, and 
# their assistants. Such communications and work product are private and 
# confidential. See User Agreement for details. 

# OR

# I've read & consent to terms in IS user agreem't.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000402
	
# Start-Lockdown

grep 'release 6' /etc/redhat-release > /dev/null
if [ $? == 0 ]
then

  # If GEN000400 has been run then the banner sould be in /etc/issue. To 
  # keep the text space down we have cut it down to 77 chars and remove 
  # empty lines. 
  BANNERTXT=`sed -e 's/#//g' /etc/issue | fmt -w 77 | sed -e '/^$/d'`

  # Break it down to a floating point num
  GDMVERS=`gdm --version | awk '{print $2}' | awk -F '.' '{print $1"."$2}'`
  # bc will return a 1 if it matches
  BCRES=`echo "$GDMVERS >= 2.22" | bc`
  if [ "$BCRES" ]
  then

    # Set the default message text without the chooser
    NCTXT=`gconftool-2 --direct --config-source xml:read:/etc/gconf/gconf.xml.mandatory --get /apps/gdm/simple-greeter/banner_message_text_nochooser 2> /dev/null`
    if [ "$NCTXT" != "$BANNERTXT" ]
    then
      gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --set /apps/gdm/simple-greeter/banner_message_text_nochooser --type string "$BANNERTXT" > /dev/null
    fi

    # Set the default message text
    MSGTXT=`gconftool-2 --direct --config-source xml:read:/etc/gconf/gconf.xml.mandatory --get /apps/gdm/simple-greeter/banner_message_text 2> /dev/null`
    if [ "$MSGTXT" != "$BANNERTXT" ]
    then
      gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --set /apps/gdm/simple-greeter/banner_message_text --type string "$BANNERTXT" > /dev/null
    fi

    # Enable the banner
    ENABLED=`gconftool-2 --direct --config-source xml:read:/etc/gconf/gconf.xml.mandatory --get /apps/gdm/simple-greeter/banner_message_enable 2> /dev/null`
    echo $ENABLED | grep 'true' > /dev/null
    if [ $? -ne 0 ]
    then
      gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gdm/simple-greeter/banner_message_enable 'true' > /dev/null
    fi

    # Disable the user list
    DISABLED=`gconftool-2 --direct --config-source xml:read:/etc/gconf/gconf.xml.mandatory --get /apps/gdm/simple-greeter/disable_user_list 2> /dev/null`
    echo $DISABLED | grep 'true' > /dev/null
    if [ $? -ne 0 ]
    then
      gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gdm/simple-greeter/disable_user_list 'true' > /dev/null
    fi

    # Left justify the text
    grep '<property name="justify">center</property>' /usr/share/gdm/gdm-greeter-login-window.ui > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/<property name="justify">center<\/property>/<property name="justify">left<\/property>/g' /usr/share/gdm/gdm-greeter-login-window.ui
    fi


  else

    GDMCONFIGURE=`grep -c '/usr/bin/gdialog --infobox "Logging out in 10 Seconds" 1 20 &' /etc/gdm/PreSession/Default`
    if [ $GDMCONFIGURE -eq 0 ]
    then
      sed -i  "s/^\(PATH=.*\)/\/usr\/bin\/gdialog --yesno \"\`cat \/etc\/issue\`\"\nif( test 1 -eq \$\? ); then\n  \/usr\/bin\/gdialog --infobox \"Logging out in 10 Seconds\" 1 20 \&\n  sleep 10\n  exit 1\nfi\n\n\1/" /etc/gdm/PreSession/Default 
    fi
  fi


# Default to RHEL5
else

  if [ -e /etc/gdm/PreSession/Default ]
  then

    GDMCONFIGURE=$( grep -c '/usr/bin/gdialog --infobox "Logging out in 10 Seconds" 1 20 &' /etc/gdm/PreSession/Default )

    if [ $GDMCONFIGURE -eq 0 ]
    then
      #sed -i  "s/^\(PATH=.*\)/\/usr\/bin\/gdialog --yesno \"\`cat \/etc\/issue\`\"\nif( test 1 -eq \$\? ); then\n  \/usr\/bin\/gdialog --infobox \"Logging out in 10 Seconds\" 1 20 \&\n  sleep 10\n  exit 1\nfi\n\n\1/" /etc/gdm/PreSession/Default 
      sed -i  "s/^\(PATH=.*\)/\/usr\/bin\/gdialog --yesno \"\`cat \/etc\/issue \| sed \-e \'s\/#\$\/\/g\' \-e \'s\/##\\\+\/###############################################\/g\'\`\"\nif( test 1 -eq \$\? ); then\n  \/usr\/bin\/gdialog --infobox \"Logging out in 10 Seconds\" 1 20 \&\n  sleep 10\n  exit 1\nfi\n\n\1/" /etc/gdm/PreSession/Default 
    fi

  fi # We don't do anything else becuase we assume GDM isn't installed
fi
