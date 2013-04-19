#!/bin/bash
if [[ x$shadow_users_in_passwd != x'' ]]; then 
	if [[ -f /etc/passwd ]] && [[ -f /etc/shadow ]]; then
		echo "Remediating shadow_users_in_passwd='$shadow_users_in_passwd'"
		sed -i -n "/^\\(`cat /etc/shadow | awk -F: '{ print $1; }' | sed 's/\(.*\)/\1\\\\/' | tr '\n' '|' | sed 's/\(.*\)\\\\|/\1/'`\\).*/p" /etc/passwd
	fi
fi

if [[ x$shadow_min_days != x'' ]]; then
	echo "Remediating shadow_min_days='$shadow_min_days'"
	for shadowname in `awk -F: '{ print $1; }' /etc/shadow`; do
		passwd -n $shadow_min_days $shadowname;
	done
fi

if [[ x$shadow_max_days != x'' ]]; then 
	echo "Remediating shadow_max_days='$shadow_max_days'"
	for shadowname in `awk -F: '{ print $1; }' /etc/shadow`; do
		passwd -x $shadow_max_days $shadowname;
	done
fi

if [[ x$login_defs_min_len != x'' ]]; then 
	echo "Remediating login_defs_min_len='$login_defs_min_len'"
	if [[ -f /etc/login.defs ]]; then
		sed -i -e "/PASS_MIN_LEN/d" -e "$ a\\PASS_MIN_LEN $login_defs_min_len" /etc/login.defs
	fi
fi

if [[ x$login_defs_min_days != x'' ]]; then 
	echo "Remediating login_defs_min_days='$login_defs_min_days'"
	if [[ -f /etc/login.defs ]]; then
		sed -i -e "/PASS_MIN_DAYS/d" -e "$ a\\PASS_MIN_DAYS $login_defs_min_days" /etc/login.defs 
	fi
fi

if [[ x$login_defs_max_days != x'' ]]; then 
	echo "Remediating login_defs_max_days='$login_defs_max_days'"
	if [[ -f /etc/login.defs ]]; then
  		sed -i -e "/PASS_MAX_DAYS/d" -e "$ a\\PASS_MAX_DAYS $login_defs_max_days" /etc/login.defs 
	fi
fi

if [[ x$cracklib_args != x'' ]] && [[ -f /etc/pam.d/system-auth ]]; then 
	echo "Remediating cracklib_args='$cracklib_args'"
	CONFIGLINE="password requisite pam_cracklib.so $cracklib_args"
	SEARCHPAT="password .*? pam_cracklib.so.*"
	sed -i -e "/$SEARCHPAT/d" -e "a\\$CONFIGLINE" /etc/pam.d/system-auth
fi

if [[  x$pam_unix_args != x'' ]] && [[ -f /etc/pam.d/system-auth ]]; then 
	echo "Remediating pam_unix_args='$pam_unix_args'"
	CONFIGLINE="password requisite pam_unix.so $pam_unix_args"
	SEARCHPAT="password .*? pam_unix.so.*"
	sed -i -e "/$SEARCHPAT/d" -e "a\\$CONFIGLINE" /etc/pam.d/system-auth
fi

echo "positional arg received: 1 = $1, 2 = $2" >> /etc/posarglog
