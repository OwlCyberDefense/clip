class gen004580 {
	## (GEN004580: CAT I) (Previously - G647) The SA will ensure .forward files
	## are not used.
	exec { "for HOMEDIR in `cut -d: -f6 /etc/passwd`; do rm -f \$HOMEDIR/.forward; done": }
}
