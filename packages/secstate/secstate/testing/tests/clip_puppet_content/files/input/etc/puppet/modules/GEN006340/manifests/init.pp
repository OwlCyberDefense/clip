class gen006340 {
	file { "/etc/news/*":
		recurse => true,

		## (GEN006340: CAT II) (Previously - L162) The SA will ensure the owner of all
		## files under the /etc/news subdirectory is root or news.
		owner => "root",

		## (GEN006360: CAT II) (Previously - L164) The SA will ensure the group owner
		## of all files in /etc/news is root or news.
		group => "root"
	}
}
