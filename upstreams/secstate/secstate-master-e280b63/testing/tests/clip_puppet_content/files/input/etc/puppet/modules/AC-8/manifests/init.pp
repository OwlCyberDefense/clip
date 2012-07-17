# AC-8: System Use Notification
# Kickstart Actions:

class ac-8::main {
	## (GEN000400: CAT II) (Previously - G010) The SA will ensure a logon-warning banner is
	## displayed on all devices and sessions at the initial logon.
	file { "/etc/issue": source => "/etc/puppet/modules/AC-8/files/issue" }

	# default path for following execs
	Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

	exec { "sed -i '/^#Banner/ c\Banner /etc/issue' /etc/ssh/sshd_config": }

	# handle graphical logins
	exec { "sed -i -f /etc/puppet/modules/AC-8/files/Default.sed /etc/gdm/PreSession/Default":
		unless => "grep -q 'zenity.*/etc/issue' /etc/gdm/PreSession/Default"
	}
}
