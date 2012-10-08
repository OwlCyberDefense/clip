class gen000440 {
	append_if_no_such_line { "authlog":
		## (GEN000440: CAT II) (Previously - G012) The SA will ensure all logon attempts (both
		## successful and unsuccessful) are logged to a system log file.
		line => "auth.*							/var/log/authlog",
		file => "/etc/syslog.conf"
	}
}
