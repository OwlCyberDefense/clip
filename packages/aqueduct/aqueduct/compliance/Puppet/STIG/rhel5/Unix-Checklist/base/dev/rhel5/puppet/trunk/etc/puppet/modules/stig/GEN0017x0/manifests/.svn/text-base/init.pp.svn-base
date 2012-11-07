class gen0017x0 {
	file {

		## (GEN001720: CAT II) The SA will ensure global initialization files have
		## permissions of 644, or more restrictive.
		## (GEN001740: CAT II) The SA will ensure the owner of global initialization
		## files is root.
		## (GEN001760: CAT II) The SA will ensure the group owner of global
		## initialization files is root, sys, bin, other, or the system default.

		"/etc/profile":
			mode => 644,
			owner => "root",
			group => "root";

		"/etc/bashrc":
			mode => 644,
			owner => "root",
			group => "root";

		"/etc/environment":
			mode => 644,
			owner => "root",
			group => "root";
	}

	append_if_no_such_line {
		## (GEN001780: CAT III) (Previously - G112) The SA will ensure global
		## initialization files contain the command mesg –n.
		"profilemesg":
			file => "/etc/profile",
			line => "mesg n";

		"bashrcmesg":
			file => "/etc/bashrc",
			line => "mesg n";
	}
}
