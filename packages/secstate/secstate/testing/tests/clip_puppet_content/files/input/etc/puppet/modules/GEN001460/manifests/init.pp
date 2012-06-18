class gen001460 {
	## (GEN001460: CAT IV) (Previously - G052) The SA will ensure all home
	## directories defined in the /etc/passwd file exist.
	exec { "/bin/bash -c for HOMEDIR in `cut -d: -f6 /etc/passwd`; do mkdir -p \$HOMEDIR; done": }
}
