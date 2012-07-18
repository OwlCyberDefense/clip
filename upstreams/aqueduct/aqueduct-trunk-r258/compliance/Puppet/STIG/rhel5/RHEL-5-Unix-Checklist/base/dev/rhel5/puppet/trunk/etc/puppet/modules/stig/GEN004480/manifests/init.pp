class gen004480 {
	file { "/var/log/maillog":
		## (GEN004480: CAT II) (Previously - G135) The SA will ensure the owner of the
		## critical sendmail log file is root.
		owner => "root",

		## (GEN004500: CAT II) (Previously - G136) The SA will ensure the critical
		## sendmail log file has permissions of 644, or more restrictive.
		mode => 640
	}
}
