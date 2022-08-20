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
bootloader --location=mbr --timeout=5 --append="audit=1 audit_backlog_limit=8192 vsyscall=none page_poison=1 slub_debug=P pti=on systemd.confirm_spawn=no loglevel=4 ipv6.disable=0" --password=neutronbass

# FIXME: Change the root password.
#        CLIP locks the root account in the post below so this password won't 
#        work.  However, if the field is missing you will be prompted during 
#        installation for a password so specify one to avoid install-time 
#        questions.
# rootpw correctbatteryhorsestaple
rootpw neutronbass

# CCE-80258-7
%addon com_redhat_kdump --disable 
%end

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
clearpart --all
reqpart --add-boot
part pv.os --size=1   --grow        --asprimary

volgroup vg00 --pesize=65536 pv.os
logvol /              --vgname=vg00 --name=root  --fstype=ext4 --size 5500 --maxsize 21000 --grow
logvol /var           --vgname=vg00 --name=var   --fstype=ext4 --size 4000 --fsoptions=defaults,nosuid --grow
logvol /home          --vgname=vg00 --name=home  --fstype=ext4 --fsoptions=defaults,nosuid,nodev --percent=10 --grow
logvol swap           --vgname=vg00 --name=swap  --fstype=swap --recommended

logvol /var/log       --vgname=vg00 --name=log   --fstype=ext4 --size 1500 --fsoptions=defaults,nosuid,noexec,nodev --maxsize 25000 --grow
logvol /var/log/audit --vgname=vg00 --name=audit --fstype=ext4 --size 1500 --fsoptions=defaults,nosuid,noexec,nodev --maxsize 25000 --grow
logvol /tmp           --vgname=vg00 --name=tmp   --fstype=ext4 --size 100  --fsoptions=defaults,nosuid,noexec,nodev --maxsize 6000  --grow
logvol /var/tmp       --vgname=vg00 --name=vtmp  --fstype=ext4 --size 100  --fsoptions=defaults,nosuid,noexec,nodev --maxsize 5000  --grow
logvol /var/lib/aide  --vgname=vg00 --name=aide  --fstype=ext4 --size 100  --fsoptions=defaults,nosuid,noexec,nodev --maxsize 5000  --grow

%packages --nobase --nocore
#CONFIG-BUILD-ADDTL-PACKAGES
clip-selinux-policy
# by default use MCS policy (clip-selinux-policy-clip)
-clip-selinux-policy-mls
clip-selinux-policy-clip
clip-lockdown
m4
# TODO Add back in once we get everything installing
scap-security-guide
dracut
dracut-fips
dracut-fips-aesni
clip-dracut-module
# SRS: this will need python-simplejson from epel on RHEL 7

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
chrony
coreutils
cpio
crontabs
dhclient
dbus
device-mapper
e2fsprogs
efibootmgr
filesystem
firewalld
grub2
grub2-efi-x64
glibc
initscripts
iproute
iptables
iptables-ipv6
iputils
kbd
kernel
libcroco
lvm2
ncurses
openscap
#openscap-content
openscap-utils
libreswan
passwd
#pam_passwdqc
perl
policycoreutils
policycoreutils-newrole
policycoreutils-python
procps
rootfiles
rpm
rsync
rsyslog
ruby
screen
-selinux-policy-targeted
setup
setools-console
shadow-utils
shim-x64
systemd
sudo
util-linux-ng
vim-minimal
vlock
xfsprogs
yum
-Red_Hat_Enterprise_Linux-Release_Notes-7-en-US
-abrt-addon-ccpp
-abrt-addon-kerneloops
-abrt-addon-python
-abrt-cli
-acpid
-alsa-utils
-blktrace
-bridge-utils
-cryptsetup
-cryptsetup-reencrypt
-dmraid
-dosfstools
-fprintd
-fprintd-pam
-hicolor-icon-theme
-kexec-tools
-mdadm
-mlocate
-mtr
-nano
-ntsysv
-pinfo
-postfix
-prelink
-psacct
-pm-utils
-redhat-indexhtml
-rdate
-rhnsd
-setserial
-setuptool
-strace
-subscription-manager
-sysstat
-systemtap-runtime
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
-libertas-usb8388-firmware
-rt61pci-firmware
-xorg-x11-drv-ati
-zd1211-firmware

%end

%post --interpreter=/bin/bash
# DO NOT REMOVE THE FOLLOWING LINE. NON-EXISTENT WARRANTY VOID IF REMOVED.
#CONFIG-BUILD-PLACEHOLDER
SYSTEM_NAME=#SYSTEM-NAME-PLACEHOLDER
export PATH="/sbin:/usr/sbin:/usr/bin:/bin:/usr/local/bin"
if [ x"$CONFIG_BUILD_LIVE_MEDIA" != "xy" ]; then
	exec >/root/${SYSTEM_NAME}_post_install.log 2>&1
	# Print the log to tty7 so that the user know what's going on
	/usr/bin/tail -f /root/${SYSTEM_NAME}_post_install.log >/dev/tty7 &
	TAILPID=$!
	/bin/chvt 7
fi

echo "Installation timestamp: `date`" > /root/${SYSTEM_NAME}-info.txt
echo "#CONFIG-BUILD-PLACEHOLDER" >> /root/${SYSTEM_NAME}-info.txt

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
	/usr/sbin/semanage user -a -R toor_r -R staff_r -R sysadm_r "${USERNAME}_u" 
else
	/usr/sbin/semanage user -a -R staff_r -R sysadm_r "${USERNAME}_u" || /usr/sbin/semanage user -a -R staff_r "${USERNAME}_u"
fi
/sbin/useradd -m "$USERNAME" -G wheel -Z "${USERNAME}_u"

if [ x"$HASHED_PASSWORD" == "x" ]; then
	/sbin/passwd --stdin "$USERNAME" <<< "$PASSWORD"
else
	/sbin/usermod --pass="$HASHED_PASSWORD" "$USERNAME"
fi

# Add the user to sudoers and setup an SELinux role/type transition.
# This line enables a transition via sudo instead of requiring sudo and newrole.
if [ x"$CONFIG_BUILD_UNCONFINED_TOOR" == "xy" ]; then
	/bin/echo "$USERNAME        ALL=(ALL) ROLE=toor_r TYPE=toor_t      ALL" >  /etc/sudoers.d/clip_toor
	/bin/echo "WARNING: This is a debug build with a super user present.  DO NOT USE IN PRODUCTION!" > /etc/motd
else
	/bin/echo "$USERNAME        ALL=(ALL) ROLE=sysadm_r TYPE=sysadm_t      ALL" > /etc/sudoers.d/clip_toor
fi

# Lock the root acct to prevent direct logins
/sbin/usermod -L root


# Disable all that GUI stuff during boot so we can actually see what is going on during boot.
# The first users of a CLIP system will be devs. Lets make things a little easier on them.
# by getting rid of the framebuffer effects, rhgb, and quiet.
GRUB_ARGS=""
# NOTE: to quiet down the boot process in production
if [ x"$CONFIG_BUILD_PRODUCTION" == "xy" ]; then
	GRUB_ARGS=${GRUB_ARGS}" quiet"
fi
# This is ugly but when plymouth re-rolls the initrd it creates a new entry in grub.conf that is redundant.
# Actually rather benign but may impact developers using grubby who think there is only one kernel to work with.
/bin/echo "Modifying splash screen with plymouth..."
/sbin/plymouth-set-default-theme details --rebuild-initrd &> /dev/null

###### START - ADJUST SYSTEM BASED ON BUILD CONFIGURATION VARIABLES ###########

# Set permissive mode
export POLNAME=`sestatus |awk '/Loaded policy name:/ { print $4; }'`
if [ x"$CONFIG_BUILD_ENFORCING_MODE" != "xy" ]; then
    echo "Setting permissive mode..."
    echo -e "#THIS IS A DEBUG BUILD HENCE SELINUX IS IN PERMISSIVE MODE\nSELINUX=permissive\nSELINUXTYPE=$POLNAME\n" > /etc/selinux/config
	echo "WARNING: This is a debug build in permissive mode.  DO NOT USE IN PRODUCTION!" >> /etc/motd
	GRUB_ARGS=${GRUB_ARGS}" enforcing=0"
else
	GRUB_ARGS=${GRUB_ARGS}" enforcing=1"
fi

if [ x"$CONFIG_BUILD_PRODUCTION" == "xy" ]; then
	# for production builds - hide the grub prompt
	/bin/sed -i -e "s/\(^GRUB_TIMEOUT=\).*$/\10/" /etc/default/grub
	/bin/echo "GRUB_HIDDEN_TIMEOUT=0" >> /etc/default/grub
	/bin/echo "GRUB_HIDDEN_TIMEOUT_QUIET=true" >> /etc/default/grub
else
	# for non-production builds - remove the grub password
	/bin/echo "Non-production mode - remove grub password:"
	find /boot -name user.cfg -print -exec rm {} \;
fi

# enable FIPS mode
if [ x"$CONFIG_BUILD_FIPS_MODE" == "xy" ]; then
	uuid=$(findmnt -no uuid /boot)
	if [ -n $uuid ]; then
		GRUB_ARGS=${GRUB_ARGS}" boot=UUID=${uuid}"
	fi
	GRUB_ARGS=${GRUB_ARGS}" fips=1"
else
	GRUB_ARGS=${GRUB_ARGS}" fips=0"
fi

/bin/echo "GRUB args ${GRUB_ARGS}"
/bin/sed -i "/^GRUB_CMDLINE_LINUX=/s/\"$/ ${GRUB_ARGS}\"/" /etc/default/grub
# setup grub config for both BIOS and UEFI booting
/sbin/grub2-mkconfig > /etc/grub2.cfg
/sbin/grub2-mkconfig > /etc/grub2-efi.cfg

# CCE-26957-1 - import RPM keys
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-*-release

###### END - ADJUST SYSTEM BASED ON BUILD CONFIGURATION VARIABLES ###########

# we do not really want these packages installed but they are required earlier during the iso build process so force their removal now
if [ x"$CONFIG_BUILD_PRODUCTION" == "xy" ]; then
	rpm -e dracut dracut-fips dracut-fips-aesni dracut-network --nodeps --allmatches
fi

echo "Done with post install scripts..."

# This is rather unfortunate, but the remediation content 
# starts services, which need to be killed/shutdown if
# we're rolling Live Media.  First, kill the known 
# problems cleanly, then just kill them all and let
# <deity> sort them out.
if [ x"$CONFIG_BUILD_LIVE_MEDIA" == "xy" ]; then
	/sbin/service restorecond stop
	/sbin/service auditd stop
	/sbin/service rsyslog stop
	/sbin/service crond stop
	[ -f /etc/init.d/vmtoolsd ] && /sbin/service vmtoolsd stop

	# this one isn't actually due to remediation, but needs to be done too
	/bin/kill $(jobs -p) 2>/dev/null 1>/dev/null
fi

if [ x"$CONFIG_BUILD_PRODUCTION" == "xy" ]; then
	# Remove sshd and rsync if in a production build
	/bin/echo "Removing ssh and rsync from the system"
	/bin/yum remove -y openssh* rsync
fi

# Scan and remediate CLIP using SSG
profile="stig"
SSG_PATH=/root/ssg
CONTENT_PATH=/usr/share/xml/scap/ssg/content
/usr/bin/mkdir $SSG_PATH
CONTENT_FILE="ssg-rhel7-xccdf.xml"
if [ -e $CONTENT_PATH/ssg-centos7-xccdf.xml ]; then
	CONTENT_FILE=ssg-centos7-xccdf.xml
fi

if [ -e $CONTENT_PATH/$CONTENT_FILE ]; then
/bin/echo "Beginning xccdf evaluation use the profile: $profile"
/bin/oscap xccdf eval --profile $profile \
--results $SSG_PATH/$SYSTEM_NAME-ssg-pre-results.xml \
--report $SSG_PATH/$SYSTEM_NAME-ssg-pre-results.html \
--cpe $CONTENT_PATH/ssg-rhel7-cpe-dictionary.xml \
$CONTENT_PATH/$CONTENT_FILE


# DJS - TODO - removed - 8-May-2018 seeing problems where remediation
#  is forcing policy to enforcing (which isn't helpful in non-production build)
#  and also forcing policy to targeted which isn't helpful as we build clip policy.
#
#/bin/echo "Scan complete. Beginning remediation..."
#/bin/oscap xccdf eval --remediate --profile $profile \
#--results $SSG_PATH/clip-el7-ssg-remediation-results.xml \
#--report $SSG_PATH/clip-el7-ssg-remediation-results.html \
#--cpe $CONTENT_PATH/ssg-rhel7-cpe-dictionary.xml \
#$CONTENT_PATH/$CONTENT_FILE 2>&1 | tee $SSG_PATH/clip-el7-ssg-fix_log.txt

# setup service to run xccdf evaluation after boot
install -D --mode=644 /dev/stdin /etc/systemd/system/xccdf_review@.service.d/$SYSTEM_NAME.conf <<- EOF
	[Service]
	Environment="SSG_PATH=$SSG_PATH"
	Environment="SYSTEM_NAME=$SYSTEM_NAME"
	Environment="CONTENT_PATH=$CONTENT_PATH"
	Environment="CONTENT_FILE=$CONTENT_FILE"

	[Unit]
	AssertPathExists=${CONTENT_PATH}/ssg-rhel7-cpe-dictionary.xml
	AssertPathExists=${CONTENT_PATH}/${CONTENT_FILE}
	ConditionPathExists=!${SSG_PATH}/${SYSTEM_NAME}-ssg-post-%i-results.html
	ConditionPathExists=!${SSG_PATH}/${SYSTEM_NAME}-ssg-post-%i-results.xml
EOF

else
	/bin/echo "XCCDF evaluation skipped - expected content unavailable" > $SSG_PATH/results.txt
fi

if [ x"$CONFIG_REMOVE_SCAP" == "xy" ]; then
	rpm -e scap-security-guide rpmdevtools gdb rpm-build openscap-utils openscap-containers openscap-scanner openscap redhat-rpm-config man-db emacs-filesystem elfutils 
	/usr/sbin/semodule -d oscap
else
	/usr/bin/systemctl enable xccdf_review@$profile.service
fi

###### START - ADD AUDIT RULES TO COMPLY WITH SSG ###########
if [ x"$CONFIG_BUILD_PRODUCTION" == "xn" ]; then
	/bin/echo -e "# Not a production build - log errors to kernel - this overwrote the default file" > /etc/audit/rules.d/50-clip-failure.rules
	/bin/echo -e "-f 1" >> /etc/audit/rules.d/50-clip-failure.rules
fi
###### END - ADD AUDIT RULES TO COMPLY WITH SSG ###########

### Setup AIDE ###
AIDE_DIR=/var/lib/aide
AIDE_SCRIPT=/root/aide.sh

echo "configuring AIDE"
cat <<- EOF > $AIDE_SCRIPT
	#!/bin/sh
	/bin/rm -f $AIDE_SCRIPT
	/bin/mv /sbin/aide $AIDE_DIR/aide
	echo "/sbin/auditctl NORMAL+b" >> /etc/aide.conf
	echo "/sbin/auditd NORMAL+b" >> /etc/aide.conf
	echo "/sbin/ausearch NORMAL+b" >> /etc/aide.conf
	echo "/sbin/aureport NORMAL+b" >> /etc/aide.conf
	echo "/sbin/autrace NORMAL+b" >> /etc/aide.conf
	echo "/sbin/audispd NORMAL+b" >> /etc/aide.conf
	echo "/sbin/augenrules NORMAL+b" >> /etc/aide.conf
	/bin/mv /etc/aide.conf $AIDE_DIR/aide.conf
	/bin/ln -s $AIDE_DIR/aide /usr/sbin/aide
	# run aide cron job daily
	echo "0 1 * * * root $AIDE_DIR/aide --check --config=$AIDE_DIR/aide.conf" >> /etc/crontab
	/bin/sed -ie '/vg00-aide/ s/defaults/ro,defaults/' /etc/fstab
	/sbin/aide --init --config=$AIDE_DIR/aide.conf
	/bin/mv $AIDE_DIR/aide.db.new.gz $AIDE_DIR/aide.db.gz
	/usr/bin/systemctl disable aide.service
	/usr/sbin/reboot
EOF

/bin/chmod 755 $AIDE_SCRIPT

/usr/bin/cat <<- EOF > /etc/systemd/system/aide.service
	[Unit]
	Description=AIDE one time service
	Before=systemd-user-sessions.service

	[Service]
	User=root
	Group=root
	Type=oneshot
	ExecStart=$AIDE_SCRIPT
	RemainAfterExit=true

	[Install]
	WantedBy=multi-user.target
EOF

if [ x"$CONFIG_BUILD_AIDE" == "xy" ]; then
	systemctl enable aide.service
else
	systemctl disable aide.service
fi

### Done with AIDE ###
if [ x"$ENABLE_NETWORKING" == "xn" ]; then
	/bin/echo "Disabling networking"
	/bin/yum remove -y dhclient
	/usr/bin/systemctl disable network.service
fi

#DJS - SCAP tests require rpm to be installed - only remove if SCAP also being removed
if [ x"$CONFIG_BUILD_PRODUCTION" == "xy" ]; then
	if [ x"$CONFIG_REMOVE_SCAP" == "xy" ]; then
		# Remove yum (and dependencies, which are openscap dependencies) before removing rpm
		/bin/rpm -e yum rpm-python rpm-build-libs
		# Force remove rpm if in a production build (and SCAP being removed)
		/bin/rpm -e --nodeps rpm
	fi
fi

# Force password reset
/bin/chage -d 0 "$USERNAME"

/bin/kill $TAILPID 2>/dev/null 1>/dev/null

# DJS - must unmount /var/log/audit so the directory gets labeled properly.
# if not, then when rebooting the mount of /var/log/audit will fail during boot!
/bin/umount /var/log/audit
# SRS: leave this restorecon as the last line to ensure files created in the ks %post get the proper label
/sbin/restorecon -e /proc -e /sys -F -R /

%end

%post --nochroot

# DO NOT REMOVE THE FOLLOWING LINE. NON-EXISTENT WARRANTY VOID IF REMOVED.
#CONFIG-BUILD-PLACEHOLDER
SYSTEM_NAME=#SYSTEM-NAME-PLACEHOLDER

if [ x"$CONFIG_BUILD_PRODUCTION" == "xy" ]; then
    /bin/echo "Deleting anaconda-ks.cfg as this is a production build" >> /mnt/sysimage/root/${SYSTEM_NAME}_post_install.log
    /bin/rm /mnt/sysimage/root/anaconda-ks.cfg
fi

# Back to VT 6 so the installer will complete
/bin/chvt 6

%end
