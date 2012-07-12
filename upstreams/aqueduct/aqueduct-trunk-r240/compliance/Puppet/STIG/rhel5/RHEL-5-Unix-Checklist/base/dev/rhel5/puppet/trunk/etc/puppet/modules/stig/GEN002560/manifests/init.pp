class gen002560 {
	## (GEN002560: CAT II) (Previously - G089) The SA will ensure the system and
	## user umask is 077.
	exec {
		"sed -i '/umask/ c\umask 077' /etc/bashrc":
		unless => "grep -q 'umask 077' /etc/bashrc";
	}

	exec {
		"sed -i '/umask/ c\umask 077' /etc/csh.cshrc":
		unless => "grep -q 'umask 077' /etc/csh.cshrc";
	}
}
