# include site::remove
# include site::template
# include site::services
# include site::admin
# include site::run

class site::remove {
# default path for following execs
Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

	file { "/etc/logrotate.d/puppet": # puppet user removed in /etc/puppet/modules/AC-17/manifests/init.pp
	ensure => absent,
	}
}

class site::template {
# default path for following execs
Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

	file { "/etc/issue":
	ensure => present,
	content => template ("/etc/puppet/modules/site/templates/issue"),
	owner => "root",
	group => "root",
	mode => 644;
	}

	file { "/etc/issue.net":
	ensure => present,
	content => template ("/etc/puppet/modules/site/templates/issue.net"),
	owner => "root",
	group => "root",
	mode => 644;
	}

	file { "/etc/crontab":
	ensure => present,
	content => template ("/etc/puppet/modules/site/templates/crontab"),
	owner => "root",
	group => "root",
	mode => 500;
	}

	file { "/etc/cron.hourly/puppet-stig-cron.sh":
	ensure => present,
	content => template ("/etc/puppet/modules/site/templates/puppet-stig-cron.sh"),
	owner => "root",
	group => "root",
	mode => 500;
	}

	file { "/etc/cron.hourly/puppet-site-cron.sh":
	ensure => present,
	content => template ("/etc/puppet/modules/site/templates/puppet-site-cron.sh"),
	owner => "root",
	group => "root",
	mode => 500;
	}

	file { "/etc/cron.hourly/puppet-site-yum.sh":
	ensure => present,
	content => template ("/etc/puppet/modules/site/templates/puppet-site-yum.sh"),
	owner => "root",
	group => "root",
	mode => 500;
	}

	file { "/etc/cron.daily/uvscan.sh":
	ensure => present,
	content => template ("/etc/puppet/modules/site/templates/uvscan.sh"),
	owner => "root",
	group => "root",
	mode => 500;
	}

	file { "/etc/mail/sendmail.cf":
	#ensure => present,
	content => template ("/etc/puppet/modules/site/templates/sendmail.cf"),
	owner => "root",
	group => "root",
	mode => 644;
	}

	file { "/etc/ntp.conf":
	ensure => present,
	content => template ("/etc/puppet/modules/site/templates/ntp.conf"),
	owner => "root",
	group => "root",
	mode => 644;
	}

	file { "/etc/ntp/step-tickers":
	ensure => present,
	content => template ("/etc/puppet/modules/site/templates/step-tickers"),
	owner => "root",
	group => "root",
	mode => 644;
	}

	file { "/etc/resolv.conf":
	ensure => present,
	content => template ("/etc/puppet/modules/site/templates/resolv.conf"),
	owner => "root",
	group => "root",
	mode => 644;
	}

	file { "/etc/cron.daily/sosreport.sh":
	ensure => present,
	content => template ("/etc/puppet/modules/site/templates/sosreport.sh"),
	owner => "root",
	group => "root",
	mode => 500;
	}
}

class site::services {
# default path for following execs
Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

        exec { "chkconfig ntpd on":}
        service { "ntpd":
        ensure => running,
        subscribe => File["/etc/ntp.conf"];
        }

        exec { "chkconfig sendmail on":}
        service { "sendmail":
        ensure => running,
        # subscribe => File["/etc/aliases"];
        }

}

class site::admin {
# default path for following execs
Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

        append_if_no_such_line { "aliases":
        line => "root:             email,email",
        file => "/etc/aliases"
        }

        file { "/etc/hosts.allow":
        content => "ALL:x.x.\nALL:127.0.0.1\nsendmail: ALL\n";
        }
}
class site::run {
# default path for following execs
Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

        exec { " yum install -y ntp":
        onlyif => "test `ps aux | grep yum | grep -v grep | grep -v yum-updatesd | wc -l` -eq 0"
        }
}
