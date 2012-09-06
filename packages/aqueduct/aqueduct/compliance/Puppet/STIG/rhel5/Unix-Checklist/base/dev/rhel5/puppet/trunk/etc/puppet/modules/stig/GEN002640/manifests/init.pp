class gen002640 {
	## (GEN002640: CAT II) (Previously - G092) The SA will ensure logon capability
	## to default system accounts (e.g., bin, lib, uucp, news, sys, guest, daemon,
	## and any default account not normally logged onto) will be disabled by
	## making the default shell /bin/false, /usr/bin/false, /sbin/false,
	## /sbin/nologin, or /dev/null, and by locking the password.
	exec { "for i in `awk -F: '\$3 < 500 && \$1 != \"root\" { print \$1 }' /etc/passwd`; do /usr/bin/usermod -L -s /dev/null \$i; done": }
}
