class gen001800 {
	## (GEN001800: CAT II) (Previously - G038) The SA will ensure all
	## default/skeleton dot files have permissions of 644, or more restrictive.
	exec { "find /etc/skel -type f -exec chmod 644 '{}' \;": }
}
