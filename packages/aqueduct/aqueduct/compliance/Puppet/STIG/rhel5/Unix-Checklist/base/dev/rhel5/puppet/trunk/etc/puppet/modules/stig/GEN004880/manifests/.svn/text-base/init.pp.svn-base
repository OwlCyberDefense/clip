class gen004880 {
	file { "/etc/ftpusers":
		## (GEN004880: CAT II) (Previously - G140) The SA will ensure the ftpusers
		## file exists.
		ensure => file,

		## (GEN004900: CAT II) (Previously - G141) The SA will ensure the ftpusers
		## file contains the usernames of users not allowed to use FTP, and contains,
		## at a minimum, the system pseudo-users usernames and root.
		content => generate("/bin/awk", "-F:", "\$3 < 500 { print \$1 }", "/etc/passwd"),

		## (GEN004920: CAT II) (Previously - G142) The SA will ensure the owner of the
		## ftpusers file is root.
		owner => "root",

		## (GEN004940: CAT II) (Previously - G143) The SA will ensure the ftpusers
		## file has permissions of 640, or more restrictive.
		mode => 640
	}
}
