class gen001820 {
	## (GEN001820: CAT II) The SA will ensure the owner of all default/skeleton
	## dot files is root or bin.
	exec { "find /etc/skel -type f -exec chown root '{}' \;": }
}
