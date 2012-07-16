class gen003040 {
	file {
		## (GEN003040: CAT II) The SA will ensure the owner of crontabs is root or the
		## crontab creator.
		## (GEN003080: CAT II) (Previously - G205) The SA will ensure crontabs have
		## permissions of 600, or more restrictive, (700 for some Linux crontabs, which
		## is detailed in the UNIX Checklist).
		"/etc/cron.daily":
			recurse => true,
			owner => "root",
			mode => 700;

		"/etc/cron.hourly":
			recurse => true,
			owner => "root",
			mode => 700;

		"/etc/cron.weekly":
			recurse => true,
			owner => "root",
			mode => 700;

		"/etc/cron.monthly":
			recurse => true,
			owner => "root",
			mode => 700;

		"/etc/cron.d":
			recurse => true,
			owner => "root",
			mode => 600;

		"/var/spool/cron":
			recurse => true,
			owner => "root",
			mode => 600;

		"/etc/crontab":
			mode => 600;

		## (GEN003100: CAT II) (Previously - G206) The SA will ensure cron and crontab
		## directories have permissions of 755, or more restrictive.
		## (GEN003120: CAT II) (Previously - G207) The SA will ensure the owner of the
		## cron and crontab directories is root or bin.
		## (GEN003140: CAT II) (Previously - G208) The SA will ensure the group owner
		## of the cron and crontab directories is root, sys, or bin.
	}
exec { "find /etc/cron.* -type d -exec chmod 755 '{}' \;": }
exec { "chmod 755 /var/spool/cron;": }
}
