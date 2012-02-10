# Module: ntp
#
# Class: ntp
#
# Description:
#       This class configures ntp on a system
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
class ntp {
	exec {
		  "Disable Extended ACLs in NTP":
       	                 command => 'setfacl -b "/etc/ntp.conf"';
	}	
	
	augeas {
		"ensure DoD authoritative clock":
                	context => "/etc/ntp.conf",
                        lens    => "ntpd.lns",
                        changes => "set server tock.usno.navy.mil";
	}
}	
