# Module: cronat
#
# Class: cronat
#
# Description:
#       This class configures cron
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
class cronat {
	
	file { "/etc/cron.allow":
			owner 	=> "root",
			group 	=> "root",
			mode  	=> 600,

			ensure	=> file,
			content	=> "root\n";
	

	## (GEN003200: CAT II)  The SA will ensure the cron.deny
        ## file has permissions of 600, or more restrictive.
        ## (GEN003260: CAT II) The SA will ensure the owner and
        ## group owner of the cron.deny file is root.
        	"/etc/cron.deny":
        	        owner	=> "root",
                        group	=> "root",
                        mode  	=> '0600',

                        ## (GEN003060: CAT II) The SA will ensure default system accounts (with the
                        ## possible exception of root) will not be listed in the cron.allow file. If
                        ## there is only a cron.deny file, the default accounts (with the possible
                        ## exception of root) will be listed there.
                        # CLIP note: this is not needed for AC-3, but this STIG is
                        # added here due to prevent duplicate puppet resources.  See above
                        # for the cron.allow part of the STIG.
                        content => generate("/bin/awk", "-F:", "\$1 != \"root\" { print \$1 }", "/etc/passwd");
        
		"/etc/cron.deny":
			owner	=> "root",
			group 	=> "root",
			mode  	=> '0755';
	
		"/etc/cron.daily":
			recurse => true,
			owner 	=> "root",
			mode 	=> '0755';

		"/etc/cron.hourly":
			recurse => true,
			owner 	=> "root",
			mode	=> '0755';
	
		"/etc/cron.weekly":
			recurse => true,
			owner 	=> "root",
			mode 	=> '0755';

		"etc/cron.monthly":
			recurse => true,
			owner 	=> "root",
			mode 	=> '0755';

		"/etc/cron.d":
			recurse => true,
			owner	=> "root",
			mode 	=> '0755';

		"/var/spool/cron":
			recurse => true,
			owner 	=> "root",
			mode 	=> '0755';
	
		"/etc/crontab":
			mode 	=> '0755';

		"/var/spool/cron":
			mode	=> '0755';
	}

}
