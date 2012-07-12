class gen001560 {
	## (GEN001560: CAT II) (Previously - G068) The user, application developers,
	## and the SA will ensure user files and directories will have an initial
	## permission no more permissive than 700, and never more permissive than 750.
	## aaron prayther 4/5/11
	exec { "for i in `ls -d \$(awk -F: '\$6 != \"/\" && \$7 != \"/sbin/nologin\" && \$3 > 100 {print \$6}' /etc/passwd) | grep -v \".\"`;do chmod 700 \$i;done":
		#require => User["clipuser"];
	}
}
