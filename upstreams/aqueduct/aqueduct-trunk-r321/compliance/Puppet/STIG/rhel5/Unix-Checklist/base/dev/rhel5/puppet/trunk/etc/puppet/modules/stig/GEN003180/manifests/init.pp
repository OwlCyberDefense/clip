class gen003180 {
	file { "/var/log/cron":
		## (GEN003180: CAT II) (Previously - G210) The SA will ensure cron logs have
		## permissions of 600, or more restrictive.
		require => Class["ac-3::p4"],
		ensure => file,
		mode => 600
	}
}

