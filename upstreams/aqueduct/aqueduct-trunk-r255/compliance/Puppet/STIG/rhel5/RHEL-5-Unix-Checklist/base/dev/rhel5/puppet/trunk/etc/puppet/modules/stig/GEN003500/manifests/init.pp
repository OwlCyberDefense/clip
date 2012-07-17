class gen003500 {
	## (GEN003500: CAT III) The SA will ensure core dumps are disabled or
	## restricted.
	append_if_no_such_line { "limits.conf":
		line => "* - core 0",
		file => "/etc/security/limits.conf"
	}
}
