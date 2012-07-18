class gen006360 {
	## (GEN005360: CAT II) The SA will ensure the owner of the snmpd.conf file is root with a group
	## owner of sys and the owner of MIB files is root with a group owner of sys or the application.
	file { "/etc/snmp/snmpd.conf":
		owner => "root",
		group => "sys"
	}
}


