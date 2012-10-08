class shells {
   exec { 'login_shells_exist' :
      command => 'for shell in `awk -F: \'{ if($7 != "") {print $7 } }\' /etc/passwd | sort | uniq` ; do exists=`grep -c $shell /etc/shells`; if [ "$exists" -le "0" ]; then sed -i -e "s|$shell|/sbin/nologin|" /etc/passwd; fi; done',
      path => '/bin:/usr/bin',
      require => Exec["etc_shells_exist"]
   }
   
   exec { 'etc_shells_exist' :
      command => 'for shell in `cat /etc/shells`; do if [ ! -f $shell ]; then sed -i -e "s|$shell||" -e \'/^$/d\' /etc/shells; fi; done ',
      path => '/bin'
   }
}
