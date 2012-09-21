class gen003340 {
	## (GEN003300: CAT II) (Previously - G212) The SA will ensure the at.deny file
	## is not empty.
	exec { "awk -F: '{print $1}' /etc/passwd | grep -v root > /etc/at.deny":
		# run the other STIGS related to at.deny afterwards
		notify => File["/etc/at.deny"]		
	}

	file {
		"/etc/at.allow":
			## (GEN003320: CAT II) (Previously - G213) The SA will ensure default system
			## accounts (with the possible exception of root) are not listed in the
			## at.allow file. If there is only an at.deny file, the default accounts
			## (with the possible exception of root) will be listed there.
			content => "root\n",

			## (GEN003460: CAT II) (Previously - G629) The SA will ensure the owner and
			## group owner of the at.allow file is root.
			owner => "root",
			group => "root",

			## (GEN003340: CAT II) (Previously - G214) The SA will ensure the at.allow and
			## at.deny files have permissions of 600, or more restrictive.
			mode => 600;

		"/etc/at.deny":
			## (GEN003340: CAT II) (Previously - G214) The SA will ensure the at.allow and
			## at.deny files have permissions of 600, or more restrictive.
			mode => 600,

			## (GEN003480: CAT II) (Previously - G630) The SA will ensure the owner and
			## group owner of the at.deny file is root.
			owner => "root",
			group => "root";
	}
}

