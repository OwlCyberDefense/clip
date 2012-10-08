#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
#<%= failed_attempts %> login attempts within <%= deny_interval %> seconds.  Locked out for <%= lockout_time %> seconds if fail
auth        required      pam_tally.so deny=<%= failed_attempts %> onerr=fail unlock_time=<%= lockout_time %> deny_interval=<%= deny_interval %>
auth        required      pam_env.so
auth        sufficient    pam_unix.so nullok try_first_pass audit
auth        requisite     pam_succeed_if.so uid >= 500 quiet
auth        required      pam_deny.so

account     required      pam_unix.so
account     required      pam_tally.so
account     sufficient    pam_succeed_if.so uid < 500 quiet
account     required      pam_permit.so

password    required      pam_cracklib.so try_first_pass retry=3 minlen=12 difok=3 dcredit=-2 ucredit=-2 ocredit=-2 lcredit=-2
password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=12
password    required      pam_deny.so

session     optional      pam_keyinit.so revoke
session     required      pam_limits.so
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     required      pam_unix.so

