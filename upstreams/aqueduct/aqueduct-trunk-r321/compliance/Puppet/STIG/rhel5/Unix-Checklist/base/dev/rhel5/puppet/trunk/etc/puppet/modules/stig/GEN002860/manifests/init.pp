## (GEN002860: CAT II) (Previously - G674) The SA and/or IAO will ensure old
## audit logs are closed and new audit logs are started daily.
class gen002860 {
	file { "/etc/logrotate.d/audit":
		source => "/etc/puppet/modules/stig/GEN002860/files/audit.logrotate";
	}
}
