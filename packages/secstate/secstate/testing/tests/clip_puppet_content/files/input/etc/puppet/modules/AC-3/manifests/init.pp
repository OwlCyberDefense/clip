# AC-3: Access Enforcement
# Kickstart Actions:

	# AC-3(1)
	# Kickstart Actions:
	class ac-3::p1 {
		## (GEN002420: CAT II) (Previously - G086) The SA will ensure user filesystems,
		## removable media, and remote filesystems will be mounted with the nosuid
		## option.

		# global defaults
		Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }
		
		#nosuid, nodev, and acl on /home
		exec { "sed -i 's/\( \/home.*defaults\)/\1,nosuid,nodev,acl/' /etc/fstab":
			onlyif => "test `grep ' \/home ' /etc/fstab | grep -c nosuid` -eq 0",
		}

		#nosuid and acl on /sys
		exec { "sed -i 's/\( \/sys.*defaults\)/\1,nosuid,acl/' /etc/fstab":
			onlyif => "test `grep ' \/sys ' /etc/fstab | grep -c nosuid` -eq 0",
		}

		#nosuid and acl on /boot
		exec { "sed -i 's/\( \/boot.*defaults\)/\1,nosuid,acl/' /etc/fstab":
			onlyif => "test `grep ' \/boot ' /etc/fstab | grep -c nosuid` -eq 0",
		}

		#nodev and acl on /usr
		exec { "sed -i 's/\( \/usr.*defaults\)/\1,nodev,acl/' /etc/fstab":
			onlyif => "test `grep ' \/usr ' /etc/fstab | grep -c nodev` -eq 0",
		}

		#nodev and acl on /usr/local
		exec { "sed -i 's/\( \/usr\/local.*defaults\)/\1,nodev,acl/' /etc/fstab":
			onlyif => "test `grep ' \/usr/local ' /etc/fstab | grep -c nodev` -eq 0",
		}
}

	# AC-3(2)
	# Kickstart Actions:

	# AC-3(3)
	# Kickstart Actions:

	# AC-3(4)
	# Kickstart Actions:
	class ac-3::p4 {
		## (GEN001260: CAT II) (Previously - G037) The SA will ensure all system log
		## files have permissions of 640, or more restrictive.

		# default path for following execs
		Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

		exec { "find /var/log/ -type f -exec chmod 640 '{}' \;":
		}

		### The following files are created with the wrong permissions when
		##  the system first boots. To ensure they are granted the correct permissions
		##  we will create them with puppet and assign all information. Reference GEN001260 failure.
 		file { "/var/log/dmesg":
		ensure => present,
		owner => "root",
		group => "root",
		mode  => 640;
                }

               file { "/var/log/acpid":
		ensure => present,
		owner => "root",
		group => "root",
		mode  => 640;
                }

		file { "/etc/init.d/sysstat":
		ensure => present,
		content => template("AC-3/sysstat"),
		mode => 755;
		}

		if $architecture == "x86_64" {
		file {
		"/usr/lib64/sa/sa1":
                ensure => present,
		content => template("AC-3/sa1"),
		mode => 755;
		
                "/usr/lib64/sa/sa2":
                ensure => present,
		content => template("AC-3/sa2"),
                mode => 755;
		}
		} else {
		file {
		"/usr/lib/sa/sa1":
                ensure => present,
		content => template("AC-3/sa1"),
		mode => 755;

                "/usr/lib/sa/sa2":
                ensure => present,
                content => template("AC-3/sa2"),
                mode => 755;
		}
		}

		exec { "sed -i 's/chmod 0664/chmod 0640/' /etc/rc.d/rc.sysinit":
			cwd => "/",
			path => "/bin:/sbin:/usr/bin:/usr/sbin";
		}


		## (GEN002980: CAT II) The SA will ensure the cron.allow
		## file has permissions of 600, or more restrictive.
		## (GEN003240: CAT II) The SA will ensure the owner and
		## group owner of the cron.allow file is root.
		file { "/etc/cron.allow":
				owner => "root",
				group => "root",
				mode  => 600,

				## (GEN003060: CAT II) The SA will ensure default system accounts (with the
				## possible exception of root) will not be listed in the cron.allow file. If
				## there is only a cron.deny file, the default accounts (with the possible
				## exception of root) will be listed there.
				# CLIP note: this is not needed for AC-3, but this STIG is
				# added here due to prevent duplicate puppet resources.  See below
				# for the cron.deny part of the STIG.
				ensure => file,
				content => "root\n"
		}

		## (GEN003200: CAT II)  The SA will ensure the cron.deny
		## file has permissions of 600, or more restrictive.
		## (GEN003260: CAT II) The SA will ensure the owner and
		## group owner of the cron.deny file is root.
		file { "/etc/cron.deny":
			owner => "root",
			group => "root",
			mode  => 600,

			## (GEN003060: CAT II) The SA will ensure default system accounts (with the
			## possible exception of root) will not be listed in the cron.allow file. If
			## there is only a cron.deny file, the default accounts (with the possible
			## exception of root) will be listed there.
			# CLIP note: this is not needed for AC-3, but this STIG is
			# added here due to prevent duplicate puppet resources.  See above
			# for the cron.allow part of the STIG.
			content => generate("/bin/awk", "-F:", "\$1 != \"root\" { print \$1 }", "/etc/passwd")
		}

		## (GEN003960: CAT II) (Previously - G631) The SA will ensure the owner of
		## the traceroute command is root.
		## (GEN003980: CAT II) (Previously - G632) The SA will ensure the group
		## owner of the traceroute command is root, sys, or bin.
		## (GEN004000: CAT II) (Previously - G633) The SA will ensure the traceroute
		## command has permissions of 700, or more restrictive.
		file { "/bin/traceroute":
			owner => "root",
			group => "root",
			mode  => 700;
		}

		## (GEN006520: CAT II) (Previously - G189) The SA will ensure security tools
		## and databases have permissions of 740, or more restrictive.
		file {
			"/etc/rc.d/init.d/iptables": mode => 740;
			"/sbin/iptables": mode => 740;
			"/usr/share/logwatch/scripts/services/iptables": mode => 740;
		}
	}
