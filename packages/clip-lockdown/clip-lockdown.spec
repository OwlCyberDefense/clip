Name:	clip-lockdown
Version: %{version}
Release: %{release}
Summary: CLIP Module for system lockdown confinguration
Requires: audit
Requires: grep
Requires: procps-ng
Requires: sed
License: GPL or BSD
Group: System Environment/Base

BuildRoot: %{_tmppath}/%{name}-root

%define audit_dir		%{_sysconfdir}/audit/rules.d/
%define limits_dir		%{_sysconfdir}/security/limits.d/
%define modprobe_dir	%{_sysconfdir}/modprobe.d/
%define remediation_dir	%{share_dir}/remediation_functions
%define share_dir		/usr/share/clip/
%define sysctl_dir		%{_sysconfdir}/sysctl.d/

Source0: %{pkgname}-%{version}.tgz

%description
This package contains various configuration files and lockdown for a CLIP based system

%prep
%setup -q -n %{pkgname}

%build

%install
rm -rf $RPM_BUILD_ROOT

install -d $RPM_BUILD_ROOT/%{audit_dir}
install audit/*.rules $RPM_BUILD_ROOT/%{audit_dir}

install -d $RPM_BUILD_ROOT/%{sysctl_dir}
install sysctl/*.conf $RPM_BUILD_ROOT/%{sysctl_dir}

install -d $RPM_BUILD_ROOT/%{modprobe_dir}
install modprobe/*.conf $RPM_BUILD_ROOT/%{modprobe_dir}

install -d $RPM_BUILD_ROOT/%{limits_dir}
install limits/*.conf $RPM_BUILD_ROOT/%{limits_dir}

install -d $RPM_BUILD_ROOT/%{remediation_dir}
install remediation/* $RPM_BUILD_ROOT/%{remediation_dir}

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
# CCE-27557-8
# Terminating an idle session within a short time period reduces the window of
# opportunity for unauthorized personnel to take control of a management session
# enabled on the console or console port that has been left unattended.
echo 'TMOUT=600' >> /etc/profile

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

%triggerin -- initscripts
. %{remediation_dir}/replace_or_append.sh

# XCCDF rule: require_singleuser_auth
# CCE-27040-5
# require the root password for access to single-user mode shell
replace_or_append '/etc/sysconfig/init' '^SINGLE' '/sbin/sulogin 'CCE-27040-5' '%s = %s'

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
# in /etc/security/pwquality.conf to equal 2 to prevent a run of (2 + 1) or more identical characters. 
replace_or_append '/etc/security/pwquality.conf' '^maxclassrepeat' 2 'CCE-27333-4' '%s = %s'

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

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(755,root,root,-)
%attr(440,root,root) %{audit_dir}/*rules
%attr(440,root,root) %{limits_dir}/*conf
%attr(440,root,root) %{modprobe_dir}/*conf
%attr(440,root,root) %{remediation_dir}/*
%attr(440,root,root) %{sysctl_dir}/*conf

%post
# reload sysctl rules so newly installed rules are used
/sbin/sysctl --load=%{sysctl_dir}/60-clip.conf

# auditd rules complain if this directory doesn't exist on check for openssh-keysign
/usr/bin/mkdir -p /usr/libexec/openssh


%changelog
* Wed May 09 2018 Dave Sugar <dsugar@tresys.com> 1.0-1
- Initial CLIP lockdown RPM

