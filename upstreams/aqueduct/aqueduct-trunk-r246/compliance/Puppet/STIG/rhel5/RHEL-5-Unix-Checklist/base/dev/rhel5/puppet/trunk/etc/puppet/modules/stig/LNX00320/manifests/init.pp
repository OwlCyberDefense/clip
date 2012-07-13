## (LNX00320: CAT I) (Previously - L140) The SA will delete accounts that
## provide a special privilege such as shutdown and halt.
class lnx00320 {
	user { "shutdown": ensure => absent; }
	user { "halt": ensure => absent; }
	user { "sync": ensure => absent; }
	user { "ftp": ensure => absent; }
}
