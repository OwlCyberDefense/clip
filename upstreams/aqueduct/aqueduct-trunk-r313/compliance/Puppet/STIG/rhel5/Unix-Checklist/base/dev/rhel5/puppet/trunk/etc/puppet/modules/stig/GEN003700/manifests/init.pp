## (GEN003700: CAT II) The SA will ensure inetd (xinetd for Linux) is disabled
## if all inetd/xinetd based services are disabled.
class gen003700 {
	service {
		"bluetooth":
			enable => false,
			ensure => stopped;
		"irda":
			enable => false,
			ensure => stopped;
		"lm_sensors":
			enable => false,
			ensure => stopped;
		"portmap":
			enable => false,
			ensure => stopped;
		"rawdevices":
			enable => false,
			ensure => stopped;
		"rpcgssd":
			enable => false,
			ensure => stopped;
		"rpcimapd":
			enable => false,
			ensure => stopped;
		"rpcsvcgssd":
			enable => false,
			ensure => stopped;
#		"sendmail":
#			enable => false,
#			ensure => stopped;
		"cups":
			enable => false,
			ensure => stopped;
		"rhnsd":
			enable => false,
			ensure => stopped;
		"autofs":
			enable => false,
			ensure => stopped;
	}
	exec{ "/sbin/chkconfig xinetd off;": }
}
