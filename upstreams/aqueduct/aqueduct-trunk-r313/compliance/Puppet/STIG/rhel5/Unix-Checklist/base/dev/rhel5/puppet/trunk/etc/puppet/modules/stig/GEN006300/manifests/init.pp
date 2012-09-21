class gen006300 {
	## (GEN006300: CAT II) (Previously - L158) The SA will ensure the
	## /etc/news/nnrp.access file has permissions of 600, or more restrictive.
	file { "/etc/news/nnrp.access": mode => 600 }
}

