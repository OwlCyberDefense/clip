class gen002120 {
	file {
		## (GEN002120: CAT II) (Previously - G069) The SA will ensure the /etc/shells
		## (or equivalent) file exits.
		"/etc/shells": source => "/etc/puppet/modules/stig/GEN002120/files/shells";

		## (GEN002160: CAT I) (Previously - G072) The SA will ensure no shell has the
		## suid bit set.
		## (GEN002180: CAT II) (Previously - G073) The SA will ensure no shell has the
		## sgid bit set.
		## (GEN002200: CAT II) (Previously - G074) The SA will ensure the owner of all
		## shells is root or bin.
		## (GEN002220: CAT II) (Previously - G075) The SA will ensure all shells
		## (excluding /dev/null and sdshell) have permissions of 755, or more
		## restrictive.
		"/bin/sh":
			mode => 755,
			owner => "root";
		"/bin/bash":
			mode => 755,
			owner => "root";
		"/sbin/nologin":
			mode => 755,
			owner => "root";
		"/bin/tcsh":
			mode => 755,
			owner => "root";
		"/bin/csh":
			mode => 755,
			owner => "root";
		"/bin/ksh":
			mode => 755,
			owner => "root";
	}
}
