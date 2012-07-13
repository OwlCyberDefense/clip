class gen003520 {
	## (GEN003520: CAT III) The SA will ensure the owner and group owner of the
	## core dump  data directory is root with permissions of 700, or more
	## restrictive.
	file {
		"/var/crash":
			ensure => directory,
			owner => "root",
			group => "root",
			mode => 700;

		"/var/crash/*":
			recurse => true,
			mode => 700;
	}
}

