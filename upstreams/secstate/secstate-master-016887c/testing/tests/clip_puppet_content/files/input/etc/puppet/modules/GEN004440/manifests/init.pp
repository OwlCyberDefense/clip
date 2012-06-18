class gen004440 {
	## (GEN004440: CAT IV) (Previously - G133) The SA will ensure the sendmail
	## logging level (the detail level of e-mail tracing and debugging
	## information) in the sendmail.cf file is set to a value no lower than
	## nine (9).
	exec { "sed -i '/LogLevel/ c\O LogLevel=9' /etc/mail/sendmail.cf":
		unless => "grep -q 'O LogLevel=9' /etc/mail/sendmail.cf"
	}
}
