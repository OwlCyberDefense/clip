class gen002040 {
	file {
		## (GEN002040: CAT I) The SA will ensure .rhosts, .shosts, hosts.equiv, nor
		## shosts.equiv are used, unless justified and documented with the IAO.
		"/root/.rhosts": ensure => absent;
		"/root/.shosts": ensure => absent;
		"/etc/hosts.equiv": ensure => absent;
	}
}
