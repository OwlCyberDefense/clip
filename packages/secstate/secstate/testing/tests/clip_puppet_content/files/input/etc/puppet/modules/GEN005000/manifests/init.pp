class gen005000 {
	## (GEN005000: CAT I) (Previously - G649) The SA will implement the anonymous
	## FTP account with a non-functional shell such as /bin/false.
	user { "ftp": shell => "/dev/null" }
}
