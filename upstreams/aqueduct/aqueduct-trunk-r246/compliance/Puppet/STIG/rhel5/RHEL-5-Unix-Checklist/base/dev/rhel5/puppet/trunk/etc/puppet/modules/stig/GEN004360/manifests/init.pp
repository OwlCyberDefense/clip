class gen004360 {
	file { "/etc/aliases":
		## (GEN004360: CAT II) (Previously - G127) The SA will ensure the aliases file
		## is owned by root.
		owner => "root",

		## (GEN004380: CAT II) (Previously - G128) The SA will ensure the aliases file
		## has permissions of 644, or more restrictive.
		mode => 644
	}
}
