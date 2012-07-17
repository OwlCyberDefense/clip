class gen001560 {
	## (GEN001560: CAT II) (Previously - G068) The user, application developers,
	## and the SA will ensure user files and directories will have an initial
	## permission no more permissive than 700, and never more permissive than 750.
	exec { "find /home/* /root -type f -exec chmod 600 '{}' \;": 
		require => User["clipuser"];
	}
	exec { "find /home/* -type d -exec chmod 700 '{}' \;": 
		require => User["clipuser"];
	}
}
