## (LNX00340: CAT II) (Previously - L142) The SA will delete accounts that
## provide no operational purpose, such as games or operator, and will delete
## the associated software.
class lnx00340 {
	user { "news": ensure => absent; }
	user { "operator": ensure => absent; }
	user { "games": ensure => absent; }
	user { "gopher": ensure => absent; }
	user { "nfsnobody": ensure => absent; }
}
