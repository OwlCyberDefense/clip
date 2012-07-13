class gen001580 {
	file { "/etc/rc.d/init.d/*":
		## (GEN001580: CAT II) (Previously - G058) The SA will ensure run control
		## scripts have permissions of 755, or more restrictive.
		## (GEN001620: CAT II) (Previously - G061) The SA will ensure run control
		## scripts files do not have the suid or sgid bit set.
		mode => 0755,

		## (GEN001660: CAT II) (Previously - G611) The SA will ensure the owner of run
		## control scripts is root.
		owner => "root",

		## (GEN001680: CAT II) (Previously - G612) The SA will ensure the group owner
		## of run control scripts is root, sys, bin, other, or the system default.
		group => "root"
	}
}
