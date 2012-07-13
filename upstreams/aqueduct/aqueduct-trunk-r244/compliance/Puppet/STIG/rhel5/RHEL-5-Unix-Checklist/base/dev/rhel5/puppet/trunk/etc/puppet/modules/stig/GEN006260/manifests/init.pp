class gen006260 {
	## (GEN006260: CAT II) (Previously - L154) The SA will ensure the
	## /etc/news/hosts.nntp file has permissions of 600, or more restrictive.
	file { "/etc/news/hosts.nntp": mode => 600 }
}

