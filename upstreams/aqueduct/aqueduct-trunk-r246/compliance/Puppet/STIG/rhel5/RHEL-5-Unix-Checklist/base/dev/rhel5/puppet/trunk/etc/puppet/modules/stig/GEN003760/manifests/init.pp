class gen003760 {
	file { "/etc/services":
		## (GEN003760: CAT II) (Previously - G109) The SA will ensure the owner of the
		## services file is root or bin.
		owner => "root",

		## (GEN003780: CAT II) (Previously - G110) The SA will ensure the services
		## file has permissions of 644, or more restrictive.
		mode => 644
	}
}

