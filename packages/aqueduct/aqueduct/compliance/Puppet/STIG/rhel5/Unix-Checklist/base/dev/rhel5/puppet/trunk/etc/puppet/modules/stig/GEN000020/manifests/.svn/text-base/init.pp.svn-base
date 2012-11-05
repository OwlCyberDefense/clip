class gen000020 {
	## (GEN000020: CAT II) (Previously - G001) The IAO and SA will ensure, if
	## configurable, the UNIX host is configured to require a password for access
	## to single-user and maintenance modes.
	append_if_no_such_line { "sulogin":
		line => "~~:S:wait:/sbin/sulogin",
		file => "/etc/inittab"
	}
}
