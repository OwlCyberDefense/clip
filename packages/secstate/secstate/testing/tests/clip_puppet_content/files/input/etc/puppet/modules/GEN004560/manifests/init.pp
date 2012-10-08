class gen004560 {
	## (GEN004560: CAT II) (Previously - G646) To help mask the e-mail version,
	## the SA will use the following in place of the original sendmail greeting
	## message:
	##   O SmtpGreetingMessage= Mail Server Ready ; $b
	exec { "sed -i '/SmtpGreetingMessage/ c\O SmtpGreetingMessage= Mail Server Ready ; $b' /etc/mail/sendmail.cf":
		unless => "grep -q 'O SmtpGreetingMessage= Mail Server Ready ; $b' /etc/mail/sendmail.cf"
	}
}
