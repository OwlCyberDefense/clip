# Module: acl
#
# Class: acl
#
# Description:
#	Enable acls on filesystems
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
#	None
#
# LinuxGuide:
#	2.3.7.1
#	2.3.7.2
#	3.6.2.1
#
# CCERef#:
#
# NIST800.53:
#	AC-3
#
# DCID6/3:
#	4.B.4.a(2)
#

# AC-3(1)
class acl {
	Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }
	
	#nosuid, nodev, and acl on /home
	exec { "fstab_home":
		command => "sed -i 's/\( \/home.*defaults\)/\1,nosuid,nodev,acl/' /etc/fstab",
		onlyif => "test `grep ' \/home ' /etc/fstab | grep -c nosuid` -eq 0",
	}

	#nosuid and acl on /sys
	exec { "fstab_sys":
		command => "sed -i 's/\( \/sys.*defaults\)/\1,nosuid,acl/' /etc/fstab",
		onlyif => "test `grep ' \/sys ' /etc/fstab | grep -c nosuid` -eq 0",
	}

	#nosuid and acl on /boot
	exec { "fstab_boot":
		command => "sed -i 's/\( \/boot.*defaults\)/\1,nosuid,acl/' /etc/fstab",
		onlyif => "test `grep ' \/boot ' /etc/fstab | grep -c nosuid` -eq 0",
	}

	#nodev and acl on /usr
	exec { "fstab_usr":
		command => "sed -i 's/\( \/usr.*defaults\)/\1,nodev,acl/' /etc/fstab",
		onlyif => "test `grep ' \/usr ' /etc/fstab | grep -c nodev` -eq 0",
	}

	#nodev and acl on /usr/local
	exec { "fstab_usr_local":
		command => "sed -i 's/\( \/usr\/local.*defaults\)/\1,nodev,acl/' /etc/fstab",
		onlyif => "test `grep ' \/usr/local ' /etc/fstab | grep -c nodev` -eq 0",
	}
}

