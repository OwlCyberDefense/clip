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
	Exec { path=> "/usr/bin:/usr/sbin:/bin:sbin" }

	# GuideSection 2.6.2.4.*
	# Configure default comprehensive rules
	file {

		"etc/audit/audit.rules":
			content => template("../files/audit.rules"),
			mode 	=> '0640';
	
		"/var/log/audit": 
			ensure 	=> directory,
			mode 	=> '0700';
		
		"/var/log/audit/audit.log":
			ensure 	=> present,
			owner   => root,
			mode 	=> '0640';
	
		"/etc/logrotate.d/audit":
			source 	=> "../files/audit.logrotate";

		"/etc/ntp.conf":
			owner	=> root,
			group   => root,
			mode	=> '0640';
			
		"/sbin/auditctl":
			owner	=> root,
			group   => root,
			mode	=> '0750';
		
		 "/sbin/audispd/":
			owner	=> root,
			group   => root,
			mode	=> '0750';
		
		"/sbin/auditd":
			owner	=> root,
			group   => root,
			mode	=> '0750';

		"aureport":
			owner	=> root,
			group   => root,
			mode	=> '0750';

		"ausearch":
			owner	=> root,
			group   => root,
			mode	=> '0750';

		"autrace":
			owner	=> root,
			group   => root,
			mode	=> '0750';
	}

	augeas {

		"Disable extended ACLs for audit files":
			context => "/etc/auditd.conf",
			lens 	=> "auditd.lns",
			incl	=> "/etc/audit/audit.log";

		"ensure DoD authoritative clock":
			context => "/etc/ntp.conf",
			lens	=> "ntpd.lns",
			changes	=> "set server tock.usno.navy.mil";


#		"Disable Extended ACLs for audit executables":
#			context	=> "/sbin/au*";
	}

	 exec {
                "Disable Extended ACLs for auditd.conf":
                        command => 'setfacl -b "/etc/auditd.conf"';

                "Disable Extended ACLs in NTP":
                        command => 'setfacl -b "/etc/ntp.conf"';

                "Disable Extended ACLs for audit executables":
                        command => 'setfacl -b "/sbin/auditctl" "/sbin/audispd" "/sbin/auditd/" "/sbin/aureport" "/sbin/ausearch" "/sbin/autrace"';

                "AuditBoot, 2.6.2.3":
                        command => "/bin/sed -i 's/quiet/quiet audit=1/g' /boot/grub/grub.conf",
                        onlyif  => "/usr/bin/test `grep audit /boot/grub/grub.conf |wc -l` -eq 0",
                        user    => "root",
                        require => Package["audit"];
       }

}
