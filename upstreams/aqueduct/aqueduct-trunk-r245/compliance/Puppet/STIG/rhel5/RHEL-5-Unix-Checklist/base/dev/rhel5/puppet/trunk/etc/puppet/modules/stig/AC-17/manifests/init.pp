# AC-17: Remote Access
# Kickstart Actions:

	# AC-17(1)
	# Kickstart Actions:

	# AC-17(2)
	# Kickstart Actions:
	class ac-17::p2 {	
		## (GEN005500: CAT I) (Previously - G701) The IAO and SA will ensure SSH
		## Protocol version 1 is not used, nor will Protocol version 1 compatibility
		## mode be used.
		# default path for following execs
		Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

		exec { "sed -i '/^Protocol/ c\Protocol 2' /etc/ssh/sshd_config":
			onlyif => "test `grep -c ^Protocol /etc/ssh/sshd_config` -gt 0"
		}

		exec { "echo 'Protocol 2' >> /etc/ssh/sshd_config":
			onlyif => "test `grep -c ^Protocol /etc/ssh/sshd_config` -eq 0"
		}

		append_if_no_such_line { "/etc/ssh/ssh_config":
			line => "Ciphers aes256-cbc,aes192-cbc,blowfish-cbc,cast128-cbc,aes128-cbc,3des-cbc",
			file => "/etc/ssh/ssh_config"
		}
	}

	# AC-17(3)
	# Kickstart Actions:

	# AC-17(4)
	# Kickstart Actions:

	# AC-17(5)
	# Kickstart Actions:
	class ac-17::p5 {		
		# Implemented in AC-17(2)

		## (GEN006620: CAT II) The SA will ensure an access control program (e.g.,
		## TCP_WRAPPERS) hosts.deny and hosts.allow files (or equivalent) are used to
		## grant or deny system access to specific hosts.
		file { "/etc/hosts.deny": content => "ALL:ALL\n" }
	}

	# AC-17(6)
	# Kickstart Actions:

	# AC-17(7)
	# Kickstart Actions:
	class ac-17::p7 {
		## (GEN001020: CAT II) The IAO will enforce users requiring root privileges to
		## log on to their personal account and invoke the /bin/su - command to switch
		## user to root.

		# default path for following execs
		Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

		# Configure sshd and login to consult pam_access.so
		exec { "sed -i '/^account.*auth$/ a\account\t\trequired\tpam_access.so' /etc/pam.d/sshd":
			onlyif => "test `grep -c pam_access.so /etc/pam.d/sshd` -eq 0"
		}

		exec { "sed -i '/^account.*auth$/ a\account\t\trequired\tpam_access.so' /etc/pam.d/login":
			onlyif => "test `grep -c pam_access.so /etc/pam.d/login` -eq 0"
		}
		## aaron prayther added the next line to allow cron jobs to be run by root 10/2010
		append_if_no_such_line { "access.conf":
			line => "-:ALL EXCEPT users :root",
			file => "/etc/security/access.conf"
		}

		user { "clipuser":
			require => Class["ia-2::main"],
			ensure => present,
			groups => ["users", "wheel"],
			managehome => true;
			# supports a password option but it must be
			# the hashed password
			
			"puppet":
			ensure => absent;
		}

		file {
		"/var/lib/puppet":
		owner => "root",
		group => "root";
		"/var/log/puppet":
		owner => "root",
		group => "root";

		"/var/run/puppet":	
		owner => "root",
		group => "root";
		}


		# seems to have a problem with the pipe in the command
		#exec { "echo 123)(*qweASD" | passwd --stdin clipuser":
		#	path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"],
		#	subscribe => User["clipuser"],
		#	refreshonly => true;
		#}

		## (GEN001120: CAT II) (Previously - G500) The SA will configure the
		## encryption program for direct root access only from the system console.
		exec { 	"sed -i '/^#PermitRootLogin/ c\PermitRootLogin no' /etc/ssh/sshd_config": }
	}
