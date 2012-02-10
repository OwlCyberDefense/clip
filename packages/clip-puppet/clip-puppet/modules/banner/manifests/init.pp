# Module: banner
#
# Class: banner
#
# Description:
#	This class creates a warning banner when logging in that states
#	the system is a US Govt information system, with the rules and
#	regulations attached. It also sets the /etc/issue file to a
#	similar statement.
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
# Files:
#	issue
#	rhel.xml
#
# LinuxGuide:
#	2.3.7.1
#	2.3.7.2
#	3.6.2.1
#
# CCERef#:
#	CCE-4060-0
#	CCE-4188-9
#	CCE-3717-6
#
# NIST800.53:
#	AC-8
#
# DCID6/3:
#	4.B.4.a(23)
#
class banner {

	file {
		# 2.3.7.1 Modify the System Login Banner
		"/etc/issue":
			owner  => "root",
			group  => "root",
			mode   => 644,
			source => "/etc/puppet/modules/banner/files/issue";
	}

	# default path for following execs
	Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

	# Configure sshd if installed
	augeas { "sshd_banner":
		context => "/files/etc/ssh/",
		changes => ["set sshd_config/Banner /etc/issue"],
		onlyif  => "match ./sshd_config size > 0"
	}

	# handle graphical logins
	exec { "enable_gdm_banner":
		command => "gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.defaults --type bool --set /apps/gdm/simple-greeter/banner_message_enable true",
		onlyif => "test -e /usr/bin/gconftool-2"
	}
	exec { "set_gdm_banner":
		command => "gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.defaults --type string --set /apps/gdm/simple-greeter/banner_message_text \"$(cat /etc/puppet/modules/banner/files/gdm_banner)\"",
		onlyif => "test -e /usr/bin/gconftool-2"
	}
}

