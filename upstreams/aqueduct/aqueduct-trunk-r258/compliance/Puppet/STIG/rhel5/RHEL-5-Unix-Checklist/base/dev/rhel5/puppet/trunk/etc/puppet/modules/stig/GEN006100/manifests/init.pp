class gen006100 {
	file { "/etc/samba/smb.conf":
		## (GEN006100: CAT II) (Previously - L050) The SA will ensure the owner of
		## the/etc/samba/smb.conf file is root.
		owner => "root",

		## (GEN006120: CAT II) (Previously - L051) The SA will ensure the group owner
		## of the /etc/samba/smb.conf file is root.
		group => "root",

		## (GEN006140: CAT II) (Previously - L052) The SA will ensure the
		## /etc/samba/smb.conf file has permissions of 644, or more restrictive.
		mode => 644
	}
}

