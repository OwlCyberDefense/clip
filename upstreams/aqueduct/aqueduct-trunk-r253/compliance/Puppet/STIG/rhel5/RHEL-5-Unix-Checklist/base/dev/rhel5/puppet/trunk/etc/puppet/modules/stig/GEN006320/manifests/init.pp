class gen006320 {
	## (GEN006320: CAT II) (Previously - L160) The SA will ensure the
	## /etc/news/passwd.nntp file has permissions of 600, or more restrictive.
	file { "/etc/news/passwd.nntp": mode => 600 }
}
