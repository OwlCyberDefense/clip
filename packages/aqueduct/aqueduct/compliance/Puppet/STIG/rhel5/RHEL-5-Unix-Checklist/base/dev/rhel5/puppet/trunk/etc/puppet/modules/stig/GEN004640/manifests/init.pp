class gen004640 {
	## (GEN004640: CAT I) (Previously - V126) The SA will ensure the decode entry
	## is disabled (deleted or commented out) from the alias file.
	exec { aliases_sed:
		command => "sed -i s/^decode\:/\#decode\:/ /etc/aliases",
		onlyif => "grep ^decode /etc/aliases"
	}

	exec { refresh_aliases:
		command => "/usr/bin/newaliases",
		subscribe => Exec[aliases_sed],
		refreshonly => true
	}
}
