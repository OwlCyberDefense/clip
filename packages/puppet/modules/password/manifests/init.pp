# Module: password
#
# Class: password
#
# Description:
#       Password file
#
# Defines:
#       None
#
# Variables:
#       None
#
# Facts:
#       None
#
class password {
	file {
		"/etc/passwd":
			owner 		=> "root",
			group 		=> "root",
			mode 		=> '0644';
	
		"/etc/group":
			owner 		=> "root",
			group 		=> "root",
			mode 		=> '0644';
	
		"/etc/shadow":
			owner 		=> "root",
			group		=> "root",
			mode 		=> '0644';
	
		"/etc/gshadow":
			owner 		=> "root",
			group 		=> "root",
			mode 		=> '0644';
	
		"/etc/libuser.conf":
			owner 		=> "root",
			group 		=> "root",
			mode 		=> '0644';
	
		 "/etc/puppet/scripts/checkUsers.bash":
                        user		=> "root",
                        logoutput	=> true,
                        require  	=> File["/etc/puppet/scripts/checkUsers.bash"];

	}

	augeas {
		"Password length and expiration settings":	
			context	=> "/etc/login.defs",
			lens	=> "login_defs.lns",
			incl	=> "/etc/login.defs",
			changes	=> [
					"set PASS_MAX_DAYS 60",
					"set PASS_MIN_DAYS 1",
					"set PASS_MIN_LEN 8"
	  	 	];

		"Set password crypt algorithm to sha512":
			context => "/etc/sysconfig/authconfig",
			lens    => "shellvars.lns",
			incl    => "/etc/sysconfig/authconfig",
			changes => "set PASSWDALGORITHM sha512";

		"Password complexity requirements":	
			context => "/etc/pam.d/system-auth",
			lens	=> "pam.lns",
			incl	=> "/etc/pam.d/system-auth",
			changes => [
					"set password requisite pam_cracklib.so try_first_pass retry=3 minlen=8 dcredit=-2 ucredit=-2 ocredit=2 lcredit=-2 enforce_root",
					"set password sufficient pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5",
					"set password required pam_deny.so"
			];

			
	}

	#To do: change to use augeas
	exec {
		"cryptstyle":
			command		=> "/bin/sed -i 's/crypt_style[ \t]*=[ \t]*md5/crypt_style = sha512/g' /etc/libuser.conf";		
		"/bin/awk -F: '(\$2 == \"\") {print}' /etc/shadow":
			user		=> "root",
			logoutput	=> true;

		# GuideSection 2.3.1.6
		# Verify that No Non-Root Accounts Have UID 0
		"/bin/awk -F: '(\$3 == \"0\" && \$1 !=\"root\") {print}' /etc/passwd":
			user		=> "root",
			logoutput	=> true;

		# GuideSection 2.3.1.4
		# Block Shell and Login Access for Non-Root System Accounts
		
	}

}
