class gen004540 {
	## (GEN004540: CAT II) The SA will ensure the help sendmail command is
	## disabled.
	file {
		"/etc/mail/helpfile.bak":
			source => "/etc/mail/helpfile",
			replace => false;

		"/etc/mail/helpfile":
			content => "\n",
			require => File["/etc/mail/helpfile.bak"];
	}

	exec { "sed -i '/HelpFile/s/^/#/' /etc/mail/sendmail.cf":
		unless => "grep -q '^#.*HelpFile' /etc/mail/sendmail.cf"
	}
}
