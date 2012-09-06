class gen006280 {
	## (GEN006280: CAT II) (Previously - L156) The SA will ensure the
	## /etc/news/hosts.nntp.nolimit file has permissions of 600, or more
	## restrictive.
	file { "/etc/news/hosts.nntp.nolimit": mode => 600 }
}
