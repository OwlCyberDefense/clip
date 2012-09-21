# AC-15: Automated Marking
# Puppet Actions:
# cupsd.conf taken from linux LSPP project - http://klaus.vh.swiftco.net/lspp/git/

class ac-15::main {
	file { "/etc/cups/cupsd.conf": source => "/etc/puppet/modules/stig/AC-15/files/cupsd.conf" }
}

