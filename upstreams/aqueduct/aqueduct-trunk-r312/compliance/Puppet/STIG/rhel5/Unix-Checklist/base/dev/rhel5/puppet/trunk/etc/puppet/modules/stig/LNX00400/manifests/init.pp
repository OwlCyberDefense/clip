class lnx00400 {
	file { "/etc/security/access.conf":
		## (LNX00400: CAT II) (Previously - L044) The SA will ensure the owner of the
		## /etc/login.access or /etc/security/access.conf file is root.
		owner => "root",

		## (LNX00420: CAT II) (Previously - L045) The SA will ensure the group owner
		## of the /etc/login.access or /etc/security/access.conf file is root.
		group => "root",

		## (LNX00440: CAT II) (Previously - L046) The SA will ensure /etc/login.access
		## or /etc/security/access.conf file will be 640, or more restrictive.
		mode => 640
	}
}
