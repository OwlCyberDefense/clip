class gen003740 {
	file {
		## (GEN003740: CAT II) (Previously - G108) The SA will ensure the inetd.conf
		## (xinetd.conf for Linux) file has permissions of 440, or more restrictive.
		## The Linux xinetd.d directory will have permissions of 755, or more
		## restrictive. This is to include any directories defined in the includedir
		## parameter.
		"/etc/xinetd.d":
			mode => 755;

		# Follow the spirit of the STIG, 
		# make conf files in xinet.d as locked down as xinetd.conf
		"/etc/xinetd.d/*":
			mode => 440;
		"/etc/xinetd.conf":
			mode => 440;
	}
}
