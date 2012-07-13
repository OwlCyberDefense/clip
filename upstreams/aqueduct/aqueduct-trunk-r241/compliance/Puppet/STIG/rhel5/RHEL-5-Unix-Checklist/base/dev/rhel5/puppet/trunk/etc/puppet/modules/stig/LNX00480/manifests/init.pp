class lnx00480 {
	file { "/etc/sysctl.conf":
		## (LNX00480: CAT II) (Previously - L204) The SA will ensure the owner of the
		## /etc/sysctl.conf file is root.
		owner => "root",

		## (LNX00500: CAT II) (Previously - L206) The SA will ensure the group owner
		## of the /etc/sysctl.conf file is root.
		group => "root",

		## (LNX00520: CAT II) (Previously - L208) The SA will ensure the
		## /etc/sysctl.conf file has permissions of 600, or more restrictive.
		mode => 600
	}
}
