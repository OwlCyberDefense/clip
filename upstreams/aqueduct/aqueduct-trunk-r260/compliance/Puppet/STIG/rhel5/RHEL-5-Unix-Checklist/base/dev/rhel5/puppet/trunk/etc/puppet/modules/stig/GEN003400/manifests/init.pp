class gen003400 {
	file { "/var/spool/at/spool":
		## (GEN003400: CAT II) (Previously - G625) The SA will ensure the at (or
		## equivalent) directory has permissions of 755, or more restrictive.
		mode => 755,

		## (GEN003420: CAT II) (Previously - G626) The SA will ensure the owner and
		## group owner of the at (or equivalent) directory is root, sys, bin, or daemon.
		owner => "root",
		group => "root"
	}
}
