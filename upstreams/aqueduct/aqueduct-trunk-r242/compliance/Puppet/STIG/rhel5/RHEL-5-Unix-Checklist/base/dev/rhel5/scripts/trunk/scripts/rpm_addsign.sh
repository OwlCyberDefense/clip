#!/usr/bin/expect
set p "P@\$\$w0rd"
set f [lindex $argv 0]
spawn rpm --resign $f
expect "Enter pass phrase:"
send -- "$p\r"
expect eof
