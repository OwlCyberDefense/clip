#!/usr/bin/expect
set p "p"
spawn svn list https://svn.forge.mil/svn/repos/slim/slim/base/dev/rhel5/rpm/trunk/sysutil
expect "(R)eject, accept (t)emporarily or accept (p)ermanently?"
send -- "$p\r"
expect eof





# spawn svn list https://svn.forge.mil/svn/repos/slim/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts
# 
# set p "/home/sysutil/forge-cert.p12"
#   expect "Client certificate filename:"
#   send -- "$p\r"
# 
# set p "P@\$\$w0rd"
#   expect "Passphrase for '/home/sysutil/forge-cert.p12':"
#   send -- "$p\r"
# 
# set p "yes"
#   expect "Store passphrase unencrypted (yes/no)?"
#   send -- "$p\r"
# 
# set p "p"
#   expect "(R)eject, accept (t)emporarily or accept (p)ermanently?"
#   send -- "$p\r"
# 
# expect eof
