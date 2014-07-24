# Copyright (C) 2012 Tresys Technology, LLC
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1) Distributed source includes this license and disclaimer,
# 2) Binary distributions must reproduce the license and disclaimer in the 
#    documentation and/or other materials provided with the distribution,
# 3) Tresys and contributors may not be used to endorse or promote products 
#    derived from this software without specific prior written permission
#
# THIS SOFTWARE IS PROVIDED BY TRESYS ``AS IS'' AND ANY EXPRESS OR IMPLIED 
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO 
# EVENT SHALL  TRESYS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND 
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#################### START CLIP CONFIGURATION ######################
# SEARCH THIS FILE FOR "FIXME" AND YOU WILL FIND THE FIELDS YOU
# NEED TO ADJUST.
#

# FIXME: Set your initial bootloader password below.
bootloader --location=mbr --timeout=5 --append="audit=1" --password=neutronbass

# FIXME: Change the root password.
#        CLIP locks the root account in the post below so this password won't 
#        work.  However, if the field is missing you will be prompted during 
#        installation for a password so specify one to avoid install-time 
#        questions.
# rootpw correctbatteryhorsestaple
rootpw neutronbass

lang en_US.UTF-8
keyboard us

#text - is broken bz 785400 anaconda abrt - No module named textw.netconfig_text
cdrom
install
timezone --utc Etc/GMT
auth --useshadow --passalgo=sha512

selinux --enforcing
firewall --enabled
reboot

# DO NOT REMOVE THE FOLLOWING LINE. NON-EXISTENT WARRANTY VOID IF REMOVED.
#REPO-REPLACEMENT-PLACEHOLDER

zerombr
clearpart --all --initlabel
part /boot --size=200 --fstype ext4 --asprimary
part pv.os --size=1   --grow        --asprimary

volgroup vg00 --pesize=65536 pv.os
logvol /              --vgname=vg00 --name=root  --fstype=ext4 --size 5500 --maxsize 21000 --grow
logvol /var           --vgname=vg00 --name=var   --fstype=ext4 --size 4000 --fsoptions=defaults,nosuid --grow
logvol /home          --vgname=vg00 --name=home  --fstype=ext4 --size=1    --fsoptions=defaults,nosuid,nodev --percent=10 --grow
logvol swap           --vgname=vg00 --name=swap  --fstype=swap --recommended

logvol /var/log       --vgname=vg00 --name=log   --fstype=ext4 --size 1500 --fsoptions=defaults,nosuid,noexec,nodev --maxsize 25000 --grow
logvol /var/log/audit --vgname=vg00 --name=audit --fstype=ext4 --size 1500 --fsoptions=defaults,nosuid,noexec,nodev --maxsize 25000 --grow
#logvol /tmp           --vgname=vg00 --name=tmp   --fstype=ext4 --size 100  --fsoptions=defaults,bind,nosuid,noexec,nodev --maxsize 6000  --grow
#logvol /var/tmp       --vgname=vg00 --name=vtmp  --fstype=ext4 --size 100  --fsoptions=defaults,nosuid,noexec,nodev --maxsize 5000  --grow
logvol /tmp           --vgname=vg00 --name=tmp   --fstype=ext4 --size 100  --maxsize 6000  --grow
logvol /var/tmp       --vgname=vg00 --name=vtmp  --fstype=ext4 --size 100  --maxsize 5000  --grow

%packages --excludedocs
#CONFIG-BUILD-ADDTL-PACKAGES
clip-selinux-policy
# by default use MCS policy (clip-selinux-policy-clip)
-clip-selinux-policy-mls
clip-selinux-policy-clip
m4
scap-security-guide
aqueduct
aqueduct-SSG
dracut
webpageexample
clip-dracut-module
#aqueduct-ssg-bash
secstate

#####
cacti
mysql
mysql-server
mysql-test
httpd
php
php-cli
php-common
php-gd
php-imap
php-intl
php-ldap
php-mbstring
php-mysql
php-pdo
php-pear
php-pecl-apc
php-pecl-memcache
php-pecl-Fileinfo
php-pgsql
php-process
php-pspell
php-recode
php-snmp
php-soap
php-tidy
php-xml
php-xmlrpc
php-zts
php-devel
#####

acl
aide
attr
audit
authconfig
basesystem
bash
bind-libs
bind-utils
chkconfig
coreutils
cpio
device-mapper
e2fsprogs
filesystem
glibc
initscripts
iproute
iptables
iptables-ipv6
iputils
kbd
kernel
ncurses
openscap
openscap-content
openscap-utils
openswan
passwd
pam_passwdqc
perl
policycoreutils
policycoreutils-newrole
policycoreutils-python
procps
rootfiles
rpm
rsyslog
ruby
-selinux-policy-targeted
setup
setools-console
shadow-utils
sudo
util-linux-ng
vim-minimal
vlock
yum
-Red_Hat_Enterprise_Linux-Release_Notes-6-en-US
-abrt-addon-ccpp
-abrt-addon-kerneloops
-abrt-addon-python
-abrt-cli
-acpid
-alsa-utils
-authconfig
-b43-fwcutter
-b43-openfwwf
-blktrace
-bridge-utils
-cryptsetup-luks
-dbus
dhclient
-dmraid
-dosfstools
-fprintd
-fprintd-pam
-hicolor-icon-theme
-kexec-tools
-man
-man-pages
-man-pages-overrides
-mdadm
-mlocate
-mtr
-nano
-ntsysv
-pinfo
-postfix
-prelink
psacct
-pm-utils
-redhat-indexhtml
-rdate
-readahead
-rhnsd
-setserial
-setuptool
-strace
-subscription-manager
-sysstat
-systemtap-runtime
-system-config-firewall-tui
-system-config-network-tui
-tcpdump
-traceroute
-vconfig
-virt-what
-wget
-yum-rhn-plugin

-libreport

-aic94xx-firmware
-at
-atmel-firmware
-bfa-firmware
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl100-firmware
-iwl1000-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-iwl6000g2a-firmware
-iwl6000g2b-firmware
-iwl6050-firmware
-kernel-firmware
-libertas-usb8388-firmware
-ql2100-firmware
-ql2200-firmware
-ql23xx-firmware
-ql2400-firmware
-ql2500-firmware
-rt61pci-firmware
-rt73usb-firmware
-xorg-x11-drv-ati-firmware
-zd1211-firmware

%end

%post --interpreter=/bin/bash
# DO NOT REMOVE THE FOLLOWING LINE. NON-EXISTENT WARRANTY VOID IF REMOVED.
#CONFIG-BUILD-PLACEHOLDER
export PATH="/sbin:/usr/sbin:/usr/bin:/bin:/usr/local/bin"
if [ x"$CONFIG_BUILD_LIVE_MEDIA" != "y" ]; then
	exec >/root/clip_post_install.log 2>&1
	# Print the log to tty7 so that the user know what's going on
	tail -f /root/clip_post_install.log >/dev/tty7 &
	TAILPID=$!
	chvt 7
fi

echo "Installation timestamp: `date`" > /root/clip-info.txt
echo "#CONFIG-BUILD-PLACEHOLDER" >> /root/clip-info.txt

#####
chkconfig httpd on
chkconfig php on
chkconfig mysql-server on
chkconfig mysqld on
#####

# FIXME: Change the username and password.
#        If a hashed password is specified it will be used
#        and the PASSWORD field will be ignored.
#
#        To generate a SHA512 hashed password try something like this:
#           python -c "import crypt; print crypt.crypt('neutronbass', '\$6\$314159265358\$')"
#        Note that the "\$6" indicates it is SHA512 and must remain in place.
#        Further, make sure you specify a salt such as "314159265358."
#        Finally, make sure the hashed password is in single quotes to prevent expansion of the dollar signs.
USERNAME="toor"
PASSWORD="neutronbass"
HASHED_PASSWORD='$6$314159265358$ytgatj7CAZIRFMPbEanbdi.krIJs.mS9N2JEl0jkPsCvtwC15z07JLzFLSuqiCdionNZ1XNT3gPKkjIG0TTGy1'

######## START DEFAULT USER CONFIG ##########
# NOTE: The root account is *locked*.  You must create an unprivileged user 
#       and grant that user administrator capabilities through sudo.
#       An account will be created below.  This account will be allowed to 
#       change to the SELinux system administrator role, and become root via 
#       sudo.  The information used to create the account comes from the 
#       USERNAME and PASSWORD values defined a few lines above.
#
# Don't get lost in the 'if' statement - basically map $USERNAME to the unconfined toor_r:toor_t role if it is enabled.  
if [ x"$CONFIG_BUILD_UNCONFINED_TOOR" == "xy" ]; then
	semanage user -a -R toor_r -R staff_r -R sysadm_r "${USERNAME}_u" 
else
	semanage user -a -R staff_r -R sysadm_r "${USERNAME}_u" || semanage user -a -R staff_r "${USERNAME}_u"
fi
useradd -m "$USERNAME" -G wheel -Z "${USERNAME}_u"

if [ x"$HASHED_PASSWORD" == "x" ]; then
	passwd --stdin "$USERNAME" <<< "$PASSWORD"
else
	usermod --pass="$HASHED_PASSWORD" "$USERNAME"
fi

chage -d 0 "$USERNAME"

# Remove sshd if it in a production build
# If not, just chkconfig it off
if [ x"$CONFIG_BUILD_PRODUCTION" == "xy" ]; then
    echo "Removing sshd from the system"
    /bin/rpm -e openssh openssh-clients openssh-server
else
    echo "Turning sshd off"
    /sbin/chkconfig --level 0123456 sshd off
fi

# Add the user to sudoers and setup an SELinux role/type transition.
# This line enables a transition via sudo instead of requiring sudo and newrole.
if [ x"$CONFIG_BUILD_UNCONFINED_TOOR" == "xy" ]; then
	echo "$USERNAME        ALL=(ALL) ROLE=toor_r TYPE=toor_t      ALL" >> /etc/sudoers
	echo "WARNING: This is a debug build with a super user present.  DO NOT USE IN PRODUCTION!" > /etc/motd
else
	echo "$USERNAME        ALL=(ALL) ROLE=sysadm_r TYPE=sysadm_t      ALL" >> /etc/sudoers
fi

# Lock the root acct to prevent direct logins
usermod -L root

######## END DEFAULT USER CONFIG ##########

###### START SECSTATE AUDIT AND REMEDIATE ###########

# FIXME: Remove <platform> tags from SSG to temporarily resolve non-applicable openscap results
sed -i -r -e "s/<platform.*//g" /usr/local/scap-security-guide/RHEL6/output/ssg-rhel6-xccdf.xml

# SecState's timeout is too short for some remediation scripts in Aqueduct.
sed -i -e 's/^remediation_timeout.*/remediation_timeout=30/' /etc/secstate/secstate.conf

# Import SSG into secstate.
# Running this command again, even after install, will result in a harmless error
# as you are effectively importing the same IDs again.
echo "Importing SSG content into secstate..."
secstate import /usr/local/scap-security-guide/RHEL6/output/ssg-rhel6-xccdf.xml --profile=common

cd /root
echo "About to use secstate to do a pre-remediation audit using SSG content..."

###### Mitigating the false positives for remediation #####
secstate mitigate -r "This system does not support partitions." -a "John Feehley" RHEL-6 mountopt_nodev_on_removable_partitions
secstate mitigate -r "This system does not support partitions." -a "John Feehley" RHEL-6 mountopt_noexec_on_removable_partitions
secstate mitigate -r "This system does not support partitions." -a "John Feehley" RHEL-6 mountopt_nosuid_on_removable_partitions
secstate mitigate -r "This system does not support partitions." -a "John Feehley" RHEL-6 mount_option_tmp_nodev
secstate mitigate -r "This system does not support partitions." -a "John Feehley" RHEL-6 mount_option_tmp_noexec
secstate mitigate -r "This system does not support partitions." -a "John Feehley" RHEL-6 mount_option_tmp_nosuid
secstate mitigate -r "This system does not support partitions." -a "John Feehley" RHEL-6 mount_option_dev_shm_nodev
secstate mitigate -r "This system does not support partitions." -a "John Feehley" RHEL-6 mount_option_dev_shm_noexec
secstate mitigate -r "This system does not support partitions." -a "John Feehley" RHEL-6 mount_option_dev_shm_nosuid
secstate mitigate -r "This system does not support external devices." -a "John Feehley" RHEL-6 console_device_restrict_access_desktop 
secstate mitigate -r "This system does not support more than three attempts." -a "John Feehley" RHEL-6 deny_password_attempts
secstate mitigate -r "This system only supports SHA512 as a hashing algorithm." -a "John Feehley" RHEL-6 set_password_hashing_algorithm
secstate mitigate -r "This system's home dirs do not support groupwrite or world read." -a "John Feehley" RHEL-6 homedir_perms_no_groupwrite_worldread
secstate mitigate -r "This system does not support screen savers." -a "John Feehley" RHEL-6 set_screensaver_inactivity_timeout
secstate mitigate -r "This system does not support screen savers." -a "John Feehley" RHEL-6 enable_screensaver_after_idle
secstate mitigate -r "This system does not support screen savers." -a "John Feehley" RHEL-6 enable_screensaver_password_lock
secstate mitigate -r "This system does not support screen savers." -a "John Feehley" RHEL-6 set_blank_screensaver
secstate mitigate -r "This system does not support IPv6." -a "John Feehley" RHEL-6 enable_ip6tables
secstate mitigate -r "This system does support smtp as a mail client." -a "John Feehley" RHEL-6 iptables_smtp_enabled
secstate mitigate -r "This system does support httpd for web content." -a "John Feehley" RHEL-6 uninstall_httpd
secstate mitigate -r "This system does restrict access." -a "John Feehley" RHEL-6 console_device_restrict_access_server
secstate mitigate -r "This system does have a proper login banner." -a "John Feehley" RHEL-6 set_system_login_banner
secstate mitigate -r "This system does have the proper audit.rules." -a "John Feehley" RHEL-6 audit_mac_changes
secstate mitigate -r "This system's logs are only owned by administrators, mysqld.log is owned by mysql respectively."  -a "John Feehley" RHEL-6 userowner_rsyslog_files
##### End of mitigating the false positives#####
####secstate remediate -y --verbose
#secstate audit

setsebool secstate_enable_remediation 1
if [ x"$CONFIG_BUILD_SECSTATE_REMEDIATE" == "xy" ]; then
	# Remediate w/ secstate using aqueduct content
	secstate remediate -y --verbose
	echo "About to use secstate to do a post-remediation audit using SSG content..."
	secstate audit
	echo "All done with secstate :)  Now go play with your freshly remediated system!"
fi

###### END SECSTATE AUDIT AND REMEDIATE ###########

# Disable all that GUI stuff during boot so we can actually see what is going on during boot.
# The first users of a CLIP system will be devs. Lets make things a little easier on them.
# by getting rid of the framebuffer effects, rhgb, and quiet.
grubby --update-kernel=ALL --remove-args="rhgb quiet"
sed -i -e 's/^\(splashimage.*\)/#\1/' -e 's/^\(hiddenmenu.*\)/#\1/' /boot/grub/grub.conf
# This is ugly but when plymouth re-rolls the initrd it creates a new entry in grub.conf that is redundant.
# Actually rather benign but may impact developers using grubby who think there is only one kernel to work with.
title="$(sed 's/ release.*$//' < /etc/redhat-release) ($(uname -r))"
sed -i -e "s;title.*;title $title;" /boot/grub/grub.conf
echo "Modifying splash screen with plymouth..."
plymouth-set-default-theme details --rebuild-initrd &> /dev/null

###### START - ADJUST SYSTEM BASED ON BUILD CONFIGURATION VARIABLES ###########

# Set permissive mode
export POLNAME=`sestatus |awk '/Policy from config file:/ { print $5; }'`
if [ x"$CONFIG_BUILD_ENFORCING_MODE" != "xy" ]; then
    echo "Setting permissive mode..."
    echo -e "#THIS IS A DEBUG BUILD HENCE SELINUX IS IN PERMISSIVE MODE\nSELINUX=permissive\nSELINUXTYPE=$POLNAME\n" > /etc/selinux/config
	echo "WARNING: This is a debug build in permissive mode.  DO NOT USE IN PRODUCTION!" >> /etc/motd
	# This line is used to make policy development easier.  It disables the "setfiles" check used by 
	# semodule/semanage that prevents transactions containing invalid and dupe fc entries from rolling forward.
	echo -e "module-store = direct\n[setfiles]\npath=/bin/true\n[end]\n" > /etc/selinux/semanage.conf
	grubby --update-kernel=ALL --remove-args=enforcing
	grubby --update-kernel=ALL --args=enforcing=0
fi
###### END - ADJUST SYSTEM BASED ON BUILD CONFIGURATION VARIABLES ###########

#####Banner Revision#####Secstate does not recognize this as corrected.
cat << EOF > /etc/issue

You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only. By using this IS (which includes any device attached to this IS), you consent to the following conditions: -The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations. -At any time, the USG may inspect and seize data stored on this IS. -Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG-authorized purpose. -This IS includes security measures (e.g., authentication and access controls) to protect USG interests- -not for your personal benefit or privacy. -Notwithstanding the above, using this IS does not constitute consent to PM, LE or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details.

EOF
#####End Banner Revision#####

#####IPtables Configuration#####

cat << EOF > /etc/sysconfig/iptables
*filter
:INPUT DROP [0:0]"
:FORWARD DROP [0:0]
:OUTPUT DROP [0:0]
-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
-A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
-A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
-A OUTPUT -p tcp -m tcp --sport 22 -j ACCEPT
-A OUTPUT -p tcp -m tcp --sport 80 -j ACCEPT
-A OUTPUT -p tcp -m tcp --sport 443 -j ACCEPT
COMMIT
# Completed on Thu Jun  5 16:22:41 2014
EOF

#####IPtables End Configuration#####

#####Audit.rules Configuration#####Secstate does not recognize this as corrected.

cat << EOF > /etc/audit/audit.rules

# This file contains the auditctl rules that are loaded
# whenever the audit daemon is started via the initscripts.
# The rules are simply the parameters that would be passed
# to auditctl.

# First rule - delete all
-D

# Increase the buffers to survive stress events.
# Make this bigger for busy systems
-b 320

# Feel free to add below this line. See auditctl man page
-w /etc/selinux -p wa -k MAC-policy
-a always,exit -S init_module -S delete_module -k modules
-w /sbin/modprobe -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /sbin/insmod -p x -k modules
-w /etc/sudoers -p wa -k actions
-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete
-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete
-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k media_export
-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k media_export
-a always,exit -F arch=b64 -F path=/bin/ping -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged
-a always,exit -F arch=b32 -F path=/bin/ping -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged
-a always,exit -F arch=b32 -S setxattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S setxattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S removexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S removexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S lsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S lsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S lremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S lremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S fsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S fsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-always,exit -F arch=b64 -S fchownat -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S fchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S fchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S fchmod -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S fchmod -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chmod -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chmod -F auid>=500 -F auid!=4294967295 -k perm_mod

-a always,exit -F path=/bin/ping -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged

-e 2a always,exit -F arch=b32 -S fchownat -F auid>=500 -F auid!=4294967295 -k perm_modEOF

EOF
#####Audit.rules End Configuration#####

#####Console Permissions#####Secstate does not recognize this as corrected.
cat << EOF > /etc/security/console.perms
# /etc/security/console.perms
#
# This file determines the permissions that will be given to priviledged
# users of the console at login time, and the permissions to which to
# revert when the users log out.

# format is:
#   <class>=list of regexps specifying consoles or globs specifying files
#   file-glob|<class> perm dev-regex|<dev-class> \
#     revert-mode revert-owner[.revert-group]
# the revert-mode, revert-owner, and revert-group are optional, and default
# to 0600, root, and root, respectively.
#
# For more information:
# man 5 console.perms
#
# This file should not be modified.
# Rather a new file in the console.perms.d directory should be created.

# file classes -- these are regular expressions
<console>=tty[0-9][0-9]* vc/[0-9][0-9]*
<xconsole>=tty[0-9][0-9]* vc/[0-9][0-9]* :0\.[0-9] :0

# device classes -- see console.perms.d/50-default.perms
# permission definitions -- see console.perms.d/50-default.perms

EOF
#####End of Console Permissions#####

#####Network Configuration /etc/sysconfig/network-scripts/ifcfg-eth0#####

cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0

DEVICE=eth0
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=yes
BOOTPROTO=dhcp
PV6INIT=yes

EOF

#####End of Network Configuration#####

echo "Done with post install scripts..."

# This is rather unfortunate, but the remediation content
# starts services, which need to be killed/shutdown if
# we're rolling Live Media.  First, kill the known
# problems cleanly, then just kill them all and let
# <deity> sort them out.
if [ x"$CONFIG_BUILD_LIVE_MEDIA" == "xy" ]; then
	service restorecond stop
	service auditd stop
	service rsyslog stop
	service crond stop
	[ -f /etc/init.d/vmtoolsd ] && service vmtoolsd stop

	# this one isn't actually due to remediation, but needs to be done too
	kill $(jobs -p) 2>/dev/null 1>/dev/null
fi
kill $TAILPID 2>/dev/null 1>/dev/null

%end

%post --nochroot

# DO NOT REMOVE THE FOLLOWING LINE. NON-EXISTENT WARRANTY VOID IF REMOVED.
#CONFIG-BUILD-PLACEHOLDER

if [ x"$CONFIG_BUILD_PRODUCTION" == "xy" ]; then
    echo "Deleting anaconda-ks.cfg as this is a production build" >> /mnt/sysimage/root/clip_post_install.log
    rm /mnt/sysimage/root/anaconda-ks.cfg
fi

%end
