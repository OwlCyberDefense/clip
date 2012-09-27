class gen001280 {
	## (GEN001280: CAT III) (Previously - G042) The SA will ensure all manual page
	## files (i.e.,files in the man and cat directories) have permissions of 644,
	## or more restrictive.
	exec { "find /usr/share/man -type f -not -perm 644 -exec chmod 644 {} \;": }
}
