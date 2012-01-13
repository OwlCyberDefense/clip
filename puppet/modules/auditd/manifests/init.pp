# Module: auditd
#
# Class: auditd
#
# Description:
#	This class configures the auditd daemon on a system
#
# Defines:
#	None
#
# Variables:
#	None
#
# Facts:
#	None
#
class auditd {
	# CCE requirements from USGCB's audit module
	# GuideSection 2.6.2.1
	# CCE-4292-9
	# Enables the auditd service
	package {
		"audit":
			ensure => installed;
	}
	
	service {
		"auditd":
			enable     => true,
			hasstatus  => true,
			require    => Package["audit"],
	}

	#Set the default path for exec
	Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

	# GuideSection 2.6.2.4.*
	# Configure default comprehensive rules
	file {
		"/etc/audit/audit.rules":
			 content => template("../files/audit.rules"),
		 	mode => 640;
	
		"/var/log/audit": 
			ensure => directory,
			mode => 700,
		
		"/var/log/audit/audit.log":
			ensure => present,
			mode => 640;
			owner => root;

		"/etc/logrotate.d/audit":
			source => "../files/audit.logrotate";

		"/etc/ntp.conf":
			owner	=> root;
			mode	=> 640;
			group 	=> root;
		
		"/sbin/auditctl":
			owner	=> root;
			mode	=> 750;
			group	=> root;
		
		 "/sbin/audispd/":
			owner	=> root;
			mode	=> 750;
			group	=> root;
		
		"/sbin/auditd":
			owner	=> root;
			mode	=> 750;
			group	=> root;

		"aureport":
			owner	=> root;
			mode	=> 750;
			group	=> root;
		
		"ausearch":
			owner	=> root;
			mode	=> 750;
			group	=> root;
		
		 "autrace":
			owner	=> root;
			mode	=> 750;
			group	=> root;
			
	}

	augeas {
		context => "/etc/auditd.conf"
		lens 	=> "auditd.lns"
		incl	=> "/etc/audit/audit.log"
		exec {
			"Disable extended ACLs for audit files":
				command	=>	setfacl -b "/etc/auditd.conf"
		};

		context => "/etc/pam.d/system-auth.tpl"
		lens 	=> "pam.lns"
		
		# deny root logins
		context => "/etc/ssh/sshd_config"
		lens 	=> "sshd.lns"
		changes	=> ["set PermitRootLogin no"];
		
		# ensure DoD authoritative clock
		context => "/etc/ntp.conf"
		lens	=> "ntpd.lns"
		exec {
			"Disable Extended ACLs in NTP":
				command => setfacl -b "/etc/ntp.conf"
		};

		changes	=> ["set server tock.usno.navy.mil"];

		context	=> "/sbin/auditctl", "/sbin/audispd", "/sbin/auditd", "/sbin/aureport", "/sbin/ausearch", "/sbin/autrace":
		
		exec {
			command	=> setfacl -b /sbin/auditctl /sbin/audispd /sbin/auditd/ /sbin/aureport /sbin/ausearch /sbin/autrace
		};


	# GuideSection 2.6.2.3
	# Enable audit prior to daemon
	# To do: change to use augeas
	exec {
		"AuditBoot, 2.6.2.3":
			command => "/bin/sed -i 's/quiet/quiet audit=1/g' /boot/grub/grub.conf",
			onlyif  => "/usr/bin/test `grep audit /boot/grub/grub.conf |wc -l` -eq 0",
			user    => "root",
			require => Package["audit"],
	}
}
