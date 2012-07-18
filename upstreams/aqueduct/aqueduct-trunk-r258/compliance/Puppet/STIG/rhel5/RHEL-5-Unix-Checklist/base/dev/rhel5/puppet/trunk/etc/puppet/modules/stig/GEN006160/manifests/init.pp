class gen006160 {
	file { "/usr/bin/smbpasswd":
		## (GEN006160: CAT II) (Previously - L054) The SA will ensure the owner of
		## smbpasswd is root.
		owner => "root",

		## (GEN006180: CAT II) (Previously - L055) The SA will ensure group owner of
		## smbpasswd is root.
		group => "root",

		## (GEN006200: CAT II) (Previously - L057) The SA will configure permissions
		## for smbpasswd to 600, or more restrictive.
		mode => 600
	}
}

