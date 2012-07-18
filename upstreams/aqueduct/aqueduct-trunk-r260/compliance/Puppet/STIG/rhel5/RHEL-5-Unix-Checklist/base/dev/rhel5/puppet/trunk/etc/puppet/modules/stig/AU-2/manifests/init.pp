# AU-2: Auditable Events
# Kickstart Actions:

	# AU-2(1)
	# Kickstart Actions:
	class au-2::p1 {	
		## (GEN002660: CAT II) (Previously - G093) The SA will configure and implement
		## auditing.
		service { "auditd": enable => true; }

		file { 
			"/etc/audit/audit.rules":
				content => template("AU-2/audit.rules"),
				mode => 640;
			"/etc/audit/auditd.conf": source => "/etc/puppet/modules/stig/AU-2/files/auditd.conf";

		## (GEN002680: CAT II) (Previously - G094) The SA will ensure audit data files
		## and directories will be readable only by personnel authorized by the IAO.

			"/var/log/audit":
				ensure => directory,
				mode => 700,
				require => Class[ "ac-3::p4" ];

		## (GEN002700: CAT I) (Previously - G095) The SA will ensure audit data files
		## have permissions of 640, or more restrictive.
			"/var/log/audit/audit.log": 
				ensure => present,
				mode => 640;
			# audit rules permissions implemented above
		}
	}

	# AU-2(2)
	# Kickstart Actions:

	# AU-2(3)
	# Kickstart Actions: None - PROCEDURAL REQUIREMENT

	# AU-2(4)
	# Kickstart Actions:
		
		# Implemented in AU-2(1)
	
	# AU-2(5)
	# Kickstart Actions:

	# AU-2(6)
	# Kickstart Actions:

	# AU-2(7)
	# Kickstart Actions:

	# AU-2(8)
	# Kickstart Actions:

	# AU-2(9)
	# Kickstart Actions:

