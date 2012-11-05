# AC-7: Unsuccessful Login Attempts
# Kickstart Actions:

	# AC-7(1)
	# Kickstart Actions:
	define ac-7::p1($failed_attempts = "3", $deny_interval = "30", $lockout_time = "60") {
		# specify lockout time in seconds
		# specify deny interval in seconds

		## (GEN000460: CAT II) (Previously - G013) The SA will ensure, after three consecutive
		## failed logon attempts for an account, the account is locked for 15 minutes or until
		## the SA unlocks the account.
		## (GEN000600: CAT II) (Previously - G019) The IAO will ensure passwords include at
		## least two alphabetic characters, one of which must be capitalized.
		## (GEN000800: CAT II) (Previously - G606) The SA will ensure passwords will not be
		## reused within the last ten changes.
		file { "/etc/pam.d/system-auth":
			content => template("/etc/puppet/modules/stig/AC-7/templates/system-auth.tpl");
		}

		# originally chmod ugo-x in the ks, but puppet only supports
		# setting the exact mode (in octal) on a file
		file { "/usr/sbin/authconfig": mode => 644; }

		## (GEN000480: CAT II) (Previously - G015) The SA will ensure the logon delay between
		## logon prompts after a failed logon is set to at least four seconds.
		append_if_no_such_line { "FAIL_DELAY":
			line => "FAIL_DELAY                      4",
			file => "/etc/login.defs"
		}

	}

	# AC-7(2)
	# Kickstart Actions:

