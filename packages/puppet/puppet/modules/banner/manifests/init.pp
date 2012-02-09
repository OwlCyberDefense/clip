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

		# Create Warning Banners for GUI Login Users
		"/usr/share/gdm/themes/RHEL/RHEL.xml":
			owner  => "root",
			group  => "root",
			mode   => 644,
			source => "/etc/puppet/modules/banner/files/rhel.xml";		
	}

	# 3.6.2.1 Create Warning Banners for GUI Login Users
	# Not implemented - redundant with the RHEL themed banner
}
