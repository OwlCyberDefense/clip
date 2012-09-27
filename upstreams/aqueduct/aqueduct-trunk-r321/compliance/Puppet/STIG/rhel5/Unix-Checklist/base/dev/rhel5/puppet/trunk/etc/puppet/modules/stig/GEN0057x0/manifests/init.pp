class gen0057x0 {
	file { "/etc/exports":
		## (GEN005740: CAT II) (Previously - G178) The SA will ensure the owner of the
		## export configuration file is root.
		owner => "root",

		## (GEN005760: CAT III) (Previously - G179) The SA will ensure the export
		## configuration file has permissions of 644, or more restrictive.
		mode => 644
	}
}

