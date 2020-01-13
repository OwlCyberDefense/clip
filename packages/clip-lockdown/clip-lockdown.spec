Name: %{pkgname}
Version: %{version}
Release: %{release}
Summary: CLIP Module for system lockdown configuration
Requires: audit
Requires: grep
Requires: pam
Requires: procps-ng
Requires: sed
BuildRequires: systemd
License: GPL or BSD
Group: System Environment/Base

BuildRoot: %{_tmppath}/%{name}-root

%define audit_dir		%{_sysconfdir}/audit/rules.d/
%define limits_dir		%{_sysconfdir}/security/limits.d/
%define modprobe_dir	%{_sysconfdir}/modprobe.d/
%define pam_dir			%{_sysconfdir}/pam.d/
%define remediation_dir	%{share_dir}/remediation_functions
%define share_dir		/usr/share/clip/
%define hold_dir		%{share_dir}/hold_config
%define ssh_config_dir	%{_sysconfdir}/ssh_config.d/
%define gdm_dir			%{_sysconfdir}/gdm
%define dconf_local_dir	%{_sysconfdir}/dconf/db/local.d/


Source0: %{pkgname}-%{version}.tgz

%description
This package contains various configuration files and lockdown for a CLIP based system

%prep
%setup -q -n %{pkgname}

%build

%install
rm -rf %{buildroot}

install -d %{buildroot}/%{audit_dir}
install audit/*.rules %{buildroot}/%{audit_dir}

install -d %{buildroot}/%{_sysctldir}
install sysctl/*.conf %{buildroot}/%{_sysctldir}

install -d %{buildroot}/%{modprobe_dir}
install modprobe/*.conf %{buildroot}/%{modprobe_dir}

install -d %{buildroot}/%{pam_dir}
install pam/* %{buildroot}/%{pam_dir}

install -d %{buildroot}/%{limits_dir}
install limits/*.conf %{buildroot}/%{limits_dir}

install -d %{buildroot}/%{remediation_dir}
install remediation/* %{buildroot}/%{remediation_dir}

install -d %{buildroot}/%{ssh_config_dir}
install ssh_config/* %{buildroot}/%{ssh_config_dir}

install -d %{buildroot}/%{_unitdir}
install service/* %{buildroot}/%{_unitdir}

install -d %{buildroot}/%{dconf_local_dir}/locks
install gdm/00-security-settings %{buildroot}/%{dconf_local_dir}
install gdm/00-security-settings-lock %{buildroot}/%{dconf_local_dir}/locks

install -d %{buildroot}/%{hold_dir}
install gdm/custom.conf %{buildroot}/%{hold_dir}

%triggerin -- filesystem
/bin/chmod 750 /var/log

%triggerpostun -- dbus
# auditd rules complain if this directory doesn't exist on check for dbus-daemon-launch-helper
/usr/bin/mkdir -p /usr/lib64/dbus-1

%triggerin -- dconf
dconf update

%triggerin -- gdm
/usr/bin/install -m 644 %{hold_dir}/custom.conf %{gdm_dir}/custom.conf
dconf update

%triggerpostun -- openssh
# auditd rules complain if this directory doesn't exist on check for openssh-keysign
/usr/bin/mkdir -p /usr/libexec/openssh

%triggerin -- openssh-server
. %{remediation_dir}/replace_or_append.sh

# sshd_allow_only_protocol2
# CCE-27320-1
# Only SSH protocol version 2 connections should be permitted.
replace_or_append '/etc/ssh/sshd_config' '^Protocol' '2' 'CCE-27320-1' '%s %s'

# sshd_disable_gssapi_auth
# CCE-80220-7
# Unless needed, SSH should not permit extraneous or unnecessary authentication mechanisms like GSSAPI
replace_or_append '/etc/ssh/sshd_config' '^GSSAPIAuthentication' 'no' 'CCE-80220-7' '%s %s'

# sshd_disable_kerb_auth
# CCE-80221-5
# Unless needed, SSH should not permit extraneous or unnecessary authentication mechanisms like Kerberos.
replace_or_append '/etc/ssh/sshd_config' '^KerberosAuthentication' 'no' 'CCE-80221-5' '%s %s'

# sshd_enable_strictmodes
# CCE-80222-3
# SSHs StrictModes option checks file and ownership permissions in the user's home directory .ssh folder before accepting login. If world- writable permissions are found, logon is rejected.
replace_or_append '/etc/ssh/sshd_config' '^StrictModes' 'yes' 'CCE-80222-3' '%s %s'

# sshd_use_priv_separation
# CCE-80223-1
# When enabled, SSH will create an unprivileged child process that has the privilege of the authenticated user. 
replace_or_append '/etc/ssh/sshd_config' '^UsePrivilegeSeparation' 'sandbox' 'CCE-80223-1' '%s %s'

# sshd_disable_compression
#  CCE-80224-9
# Compression is useful for slow network connections over long distances but can cause performance issues on local LANs. If use of compression is required, it should be enabled only after a user has authenticated; otherwise , it should be disabled.
replace_or_append '/etc/ssh/sshd_config' '^Compression' 'no' 'CCE-80224-9' '%s %s'

# sshd_print_last_log
# CCE-80225-6
# When enabled, SSH will display the date and time of the last successful account logon.
replace_or_append '/etc/ssh/sshd_config' '^PrintLastLog' 'yes' 'CCE-80225-6' '%s %s'

# sshd_set_idle_timeout
# CCE-27433-2
# SSH allows administrators to set an idle timeout interval. After this interval has passed, the idle user will be automatically logged out.
replace_or_append '/etc/ssh/sshd_config' '^ClientAliveInterval' 600 'CCE-27433-2' '%s %s'

# sshd_set_keepalive
# CCE-27082-7
# To ensure the SSH idle timeout occurs precisely when the ClientAliveCountMax is set
replace_or_append '/etc/ssh/sshd_config' '^ClientAliveCountMax' '0' 'CCE-27082-7' '%s %s'


# sshd_disable_rhosts
# CCE-27377-1
replace_or_append '/etc/ssh/sshd_config' '^IgnoreRhosts' 'yes' 'CCE-27377-1' '%s %s'

# sshd_disable_user_known_hosts
# CCE-80372-6
# SSH can allow system users user host-based authentication to connect to systems if a cache of the remote systems public keys are available.
replace_or_append '/etc/ssh/sshd_config' '^IgnoreUserKnownHosts' 'yes' 'CCE-80372-6' '%s %s'

# sshd_disable_empty_passwords
# CCE-27471-2
# To explicitly disallow SSH login from accounts with empty passwords
replace_or_append '/etc/ssh/sshd_config' '^PermitEmptyPasswords' 'no' 'CCE-27471-2' '%s %s'

# sshd_enable_warning_banner
# CCE-27314-4
# To enable the warning banner and ensure it is consistent across the system
replace_or_append '/etc/ssh/sshd_config' '^Banner' '/etc/issue' 'CCE-27314-4' '%s %s'

# sshd_do_not_permit_user_env
#  CCE-27363-1
# To ensure users are not able to override environment options to the SSH daemon.
replace_or_append '/etc/ssh/sshd_config' '^PermitUserEnvironment' 'no' 'CCE-27363-1' '%s %s'

# sshd_use_approved_ciphers
# CCE-27295-5
# Limit the ciphers to those algorithms which are FIPS-approved. Counter (CTR) mode is also preferred over cipher-block chaining (CBC) mode.
replace_or_append '/etc/ssh/sshd_config' '^Ciphers' 'aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc' 'CCE-27295-5' '%s %s'

# sshd_use_approved_macs
# CCE-27455-5
# Limit the MACs to those hash algorithms which are FIPS-approved. The following line in /etc/ssh/sshd_config demonstrates use of FIPS-approved MACs: 
replace_or_append '/etc/ssh/sshd_config' '^MACs' "hmac-sha2-512,hmac-sha2-256,hmac-sha1,hmac-sha1-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com" 'CCE-27455-5' '%s %s'



%triggerin -- setup
. %{remediation_dir}/set_umask.sh

# CCE-27557-8
# Terminating an idle session within a short time period reduces the window of
# opportunity for unauthorized personnel to take control of a management session
# enabled on the console or console port that has been left unattended.
echo 'TMOUT=600' >> /etc/profile

USER_UMASK=077

# XCCDF rule: user_umask_bashrc
# CCE-26917-5
# set user bash umask
set_umask $USER_UMASK /etc/bashrc

# XCCDF rule: user_umask_cshrc
# CCE-27034-8
# set user csh umask
set_umask $USER_UMASK /etc/csh.cshrc

# XCCDF rule: user_umask_profile
# CCE-26669-2
# set user umask in /etc/profile
set_umask $USER_UMASK /etc/profile

# XCCDF rule
# CCE-26855-7
# Disable root login altogether
echo > /etc/securetty

# CCE-80154-8,  CCE-80153-0, CCE-80152-2
sed -i -e "s/\(tmpfs.*shm.*\)defaults/\1noexec,nosuid,nodev/" /etc/fstab

%triggerin -- shadow-utils
. %{remediation_dir}/replace_or_append.sh

# XCCDF rule: accounts_password_minlen_login_defs
# CCE-27002-5
# set password length requirements for password-setting programs which use login.defs (as opposed to PAM)
replace_or_append '/etc/login.defs' '^PASS_MIN_LEN' 15 'CCE-27002-5' '%s\t%s'

# XCCDF rule: accounts_minimum_age_login_defs
# CCE-27013-2
# set minimum number of days between successive password changes for password-setting programs which use login.defs
replace_or_append '/etc/login.defs' '^PASS_MIN_DAYS' 1 'CCE-27013-2' '%s\t%s'

# XCCDF rule: accounts_maximum_age_login_defs
# CCE-26985-2
# set number of days a password will expire after it has been set for user authentication programs which use login.defs
replace_or_append '/etc/login.defs' '^PASS_MAX_DAYS' 60 'CCE-26985-2' '%s\t%s'

# XCCDF rule: accounts_login_fail_delay
# CCE-80352-8
# To ensure the login failure dealy controlled by /etc/login.defs is set properly
replace_or_append '/etc/login.defs' '^FAIL_DELAY' 4 'CCE-80352-8' '%s\t%s'

# XCCDF rule: account_disable_post_pw_expiration
# CCE-27355-7
# disable an account if its password expires and the user does not reset it within 35 days
replace_or_append '/etc/default/useradd' '^INACTIVE' "0" 'CCE-27355-7' '%s=%s'

%triggerin -- initscripts
. %{remediation_dir}/replace_or_append.sh
. %{remediation_dir}/set_umask.sh

# XCCDF rule: require_singleuser_auth
# CCE-27040-5
# require the root password for access to single-user mode shell
replace_or_append '/etc/sysconfig/init' '^SINGLE' '/sbin/sulogin' 'CCE-27040-5' '%s=%s'

# XCCDF rule: umask_for_daemons
# CCE-27031-4
# set daemon umask
set_umask 027 /etc/init.d/functions

%triggerin -- kexec-tools
# CCE-80258-7
/bin/systemctl disable kdump.service

%triggerin -- libpwquality
. %{remediation_dir}/replace_or_append.sh

# CCE-27333-4
# The pam_pwquality module's maxrepeat parameter controls requirements for consecutive 
# repeating characters. When set to a positive number, it will reject passwords which 
# contain more than that number of consecutive characters. Modify the maxrepeat setting 
# in /etc/security/pwquality.conf to equal 2 to prevent a run of (2 + 1) or more identical characters. 
replace_or_append '/etc/security/pwquality.conf' '^maxrepeat' 2 'CCE-27333-4' '%s = %s'

# CCE-27512-3
# The pam_pwquality module's maxclassrepeat parameter controls requirements for consecutive 
# repeating characters. When set to a positive number, it will reject passwords which 
# contain more than that number of consecutive characters. Modify the maxclassrepeat setting 
# in /etc/security/pwquality.conf to equal 4 to prevent a run of (4 + 1) or more identical characters. 
replace_or_append '/etc/security/pwquality.conf' '^maxclassrepeat' 4 'CCE-27512-3' '%s = %s'

# CCE-27214-6
# The pam_pwquality module's dcredit parameter controls requirements for usage of digits in a password. 
# When set to a negative number, any password will be required to contain that many digits. When set to a 
# positive number, pam_pwquality will grant +1 additional length credit for each digit. Modify the dcredit 
# setting in /etc/security/pwquality.conf to require the use of a digit in passwords. 
replace_or_append '/etc/security/pwquality.conf' '^dcredit' -1 'CCE-27214-6' '%s = %s'

# CCE-27293-0
# The pam_pwquality module's minlen parameter controls requirements for minimum characters required in a 
# password. Add minlen=15 after pam_pwquality to set minimum password length requirements. 
replace_or_append '/etc/security/pwquality.conf' '^minlen' 15 'CCE-27293-0' '%s = %s'

# CCE-27200-5
# The pam_pwquality module's ucredit= parameter controls requirements for usage of
# uppercase letters in a password. When set to a negative number, any password
# will be required to contain that many uppercase characters. When set to a
# positive number, pam_pwquality will grant +1 additional length credit for each
# uppercase character. Modify the ucredit setting in /etc/security/pwquality.conf
# to require the use of an uppercase character in passwords. 
replace_or_append '/etc/security/pwquality.conf' '^ucredit' -1 'CCE-27200-5' '%s = %s'

# CCE-27360-7
# The pam_pwquality module's ocredit= parameter controls requirements for usage
# of special (or "other") characters in a password. When set to a negative
# number, any password will be required to contain that many special characters.
# When set to a positive number, pam_pwquality will grant +1 additional length
# credit for each special character. Modify the ocredit setting in
# /etc/security/pwquality.conf to equal -1 to require use of a special character
# in passwords. 
replace_or_append '/etc/security/pwquality.conf' '^ocredit' -1 'CCE-27360-7' '%s = %s'

# CCE-27345-8
# The pam_pwquality module's lcredit parameter controls requirements for usage
# of lowercase letters in a password. When set to a negative number, any
# password will be required to contain that many lowercase characters. When set
# to a positive number, pam_pwquality will grant +1 additional length credit for
# each lowercase character. Modify the lcredit setting in
# /etc/security/pwquality.conf to require the use of a lowercase character in
# passwords. 
replace_or_append '/etc/security/pwquality.conf' '^lcredit' -1 'CCE-27345-8' '%s = %s'

# CCE-26631-2
# The pam_pwquality module's difok parameter sets the number of characters in a
# password that must not be present in and old password during a password
# change. Modify the difok setting in /etc/security/pwquality.conf to equal 5 to
# require differing characters when changing passwords. 
replace_or_append '/etc/security/pwquality.conf' '^difok' 8 'CCE-26631-2' '%s = %s'

# CCE-27115-5
# The pam_pwquality module's minclass parameter controls requirements for usage
# of different character classes, or types, of character that must exist in a
# password before it is considered valid. For example, setting this value to
# three (3) requires that any password must have characters from at least three
# different categories in order to be approved. The default value is zero (0),
# meaning there are no required classes. There are four categories available:
#
# * Upper-case characters
# * Lower-case characters
# * Digits
# * Special characters (for example, punctuation)
# 
# Modify the minclass setting in /etc/security/pwquality.conf entry to require 4
# differing categories of characters when changing passwords. 
replace_or_append '/etc/security/pwquality.conf' '^minclass' 4 'CCE-27115-5' '%s = %s'

%triggerin -- systemd
# CCE-27511-5
# Disable control-alt-delete
/bin/systemctl mask ctrl-alt-del.target

/bin/systemctl disable proc-sys-fs-binfmt_misc.automount
/bin/systemctl mask proc-sys-fs-binfmt_misc.automount

%triggerin -- yum
. %{remediation_dir}/replace_or_append.sh

# ensure_gpgcheck_local_packages
#  CCE-80347-8
# Yum should be configured to verify the signature(s) of local packages prior to installation
replace_or_append '/etc/yum.conf' '^localpkg_gpgcheck' 1 ' CCE-80347-8' '%s=%s'

# clean_components_post_updating
#  CCE-80346-0
# Yum should be configured to remove previous software components after previous versions have been installed.
replace_or_append '/etc/yum.conf' '^clean_requirements_on_remove' 1 ' CCE-80346-0' '%s=%s'

%triggerin -- aide

aide_conf="/etc/aide.conf"

# aide_verify_acls
# CCE-80375-9
groups=$(/bin/grep "^[A-Z]\+" $aide_conf | /bin/grep -v "^ALLXTRAHASHES" | /bin/cut -f1 -d '=' | /bin/tr -d ' ' | /bin/sort -u)

for group in $groups
do
	config=$(/bin/grep "^$group\s*=" $aide_conf | /bin/cut -f2 -d '=' | /bin/tr -d ' ')

	if ! [[ $config = *acl* ]]
	then
		if [[ -z $config ]]
		then
			config="acl"
		else
			config=$config"+acl"
		fi
	fi
	sed -i "s/^$group\s*=.*/$group = $config/g" $aide_conf
done

# aide_verify_ext_attributes
# CCE-80376-7
groups=$(/bin/grep "^[A-Z]\+" $aide_conf | /bin/grep -v "^ALLXTRAHASHES" | /bin/cut -f1 -d '=' | /bin/tr -d ' ' | /bin/sort -u)

for group in $groups
do
	config=$(/bin/grep "^$group\s*=" $aide_conf | /bin/cut -f2 -d '=' | /bin/tr -d ' ')

	if ! [[ $config = *xattrs* ]]
	then
		if [[ -z $config ]]
		then
			config="xattrs"
		else
			config=$config"+xattrs"
		fi
	fi
	sed -i "s/^$group\s*=.*/$group = $config/g" $aide_conf
done

# aide_use_fips_hashes
# CCE-80377-5
forbidden_hashes=(sha1 rmd160 sha256 whirlpool tiger haval gost crc32)

groups=$(/bin/grep "^[A-Z]\+" $aide_conf | /bin/cut -f1 -d ' ' | /bin/tr -d ' ' | /bin/sort -u)

for group in $groups
do
	config=$(/bin/grep "^$group\s*=" $aide_conf | /bin/cut -f2 -d '=' | /bin/tr -d ' ')

	if ! [[ $config = *sha512* ]]
	then
		config=$config"+sha512"
	fi

	for hash in ${forbidden_hashes[@]}
	do
		config=$(echo $config | /bin/sed "s/$hash//")
	done

	config=$(echo $config | /bin/sed "s/^\+*//")
	config=$(echo $config | /bin/sed "s/\+\++/+/")
	config=$(echo $config | /bin/sed "s/\+$//")

	/bin/sed -i "s/^$group\s*=.*/$group = $config/g" $aide_conf
done

%triggerin -- audit
. %{remediation_dir}/replace_or_append.sh

# auditd_data_retention_space_left_action
# CCE-27375-5
# The auditd service can be configured to take an action when disk space starts to run low. 
replace_or_append '/etc/audit/auditd.conf' '^space_left_action' 'halt' 'CCE-27375-5' '%s = %s'


# auditd_data_retention_space_left
# CCE-80537-4
# The auditd service can be configured to take an action when disk space is running low but prior to running out of space completely.
replace_or_append '/etc/audit/auditd.conf' '^space_left' 100 'CCE-80537-4' '%s = %s'

# auditd_audispd_syslog_plugin_activated
# CCE-27341-7
# Configure auditd to use audispd's syslog plugin
replace_or_append '/etc/audisp/plugins.d/syslog.conf' '^active' "yes" "CCE-27341-7" '%s = %s'

%triggerin -- chrony, ntp

# chronyd_or_ntpd_set_maxpoll
# CCE-80439-3
# The maxpoll should be configured to 10 in /etc/ntp.conf or /etc/chrony.conf to continuously poll time servers
var_time_service_set_maxpoll="10"

for config_file in "/etc/chrony.conf" "/etc/ntp.conf"; do
	if [ ! -e "$config_file" ]; then
		continue;
	fi

	# Delete maxpoll if it already exists
	/bin/sed -i "/^server/ s/ maxpoll [0-9][0-9]*//" "$config_file"

	# Add maxpoll to server entries with the right value
	/bin/sed -i "/^server/ s/$/ maxpoll $var_time_service_set_maxpoll/" "$config_file"
done

%clean
rm -rf %{buildroot}

%files
%defattr(755,root,root,-)
%attr(440,root,root) %{audit_dir}/*rules
%attr(440,root,root) %{limits_dir}/*conf
%attr(440,root,root) %{modprobe_dir}/*conf
%attr(440,root,root) %{pam_dir}/*
%attr(440,root,root) %{remediation_dir}/*
%attr(440,root,root) %{ssh_config_dir}/*conf
%attr(440,root,root) %{_sysctldir}/*conf
%attr(644,root,root) %{_unitdir}/*
%attr(644,root,root) %{dconf_local_dir}/00-security-settings
%attr(644,root,root) %{dconf_local_dir}/locks/00-security-settings-lock
%attr(644,root,root) %{hold_dir}/*

%post
# reload sysctl rules so newly installed rules are used
/sbin/sysctl --load=%{_sysctldir}/60-clip.conf

# auditd rules complain if this directory doesn't exist on check for openssh-keysign
/usr/bin/mkdir -p /usr/libexec/openssh

# auditd rules complain if this directory doesn't exist on check for dbus-daemon-launch-helper
/usr/bin/mkdir -p /usr/lib64/dbus-1

ln -sf password-auth-clip %{pam_dir}/password-auth
ln -sf system-auth-clip %{pam_dir}/system-auth

%changelog
* Wed May 09 2018 Dave Sugar <dsugar@tresys.com> 1.0-1
- Initial CLIP lockdown RPM

