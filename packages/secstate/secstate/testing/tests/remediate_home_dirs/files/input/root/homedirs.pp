class homedirs {
   if $user_home_exists != '' {
      exec { 'for record in `awk -F: \'{ print $1":"$6 }\' /etc/passwd`; do uname=${record%:*}; homedir=${record#*:}; if [ ! -e "$homedir" ]; then mkdir -p $homedir; chown $uname $homedir; chgrp $uname $homedir; fi; done' :
         path => "/bin"
      }
   }
   
   if $users_assigned_home != '' {
      exec { 'for record in `awk -F: \'{ print $1":"$6 }\' /etc/passwd`; do uname=${record%:*}; homedir=${record#*:}; if [ -z "$homedir" ]; then homedir="/home/$uname"; usermod -d $homedir $uname; mkdir -p $homedir; chown $uname $homedir; chgrp $uname $homedir; fi; done ' :
         path => "/bin:/usr/bin:/usr/sbin"
      }
   }
}