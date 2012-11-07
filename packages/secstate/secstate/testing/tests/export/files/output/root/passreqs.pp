class passreqs {
   if $shadow_users_in_passwd != '' {
      exec { 'sed -i -n "/^\(`cat /etc/shadow | awk -F: \'{print $1 }\' | sed \'s/\(.*\)/\1\\\\/\' | tr \'\n\' \'|\' | sed \'s/\(.*\)\\\\|/\1/\'`\).*/p" /etc/passwd' : 
         onlyif => ["test -f /etc/passwd", "test -f /etc/shadow"],
         path => "/bin:/usr/bin"
      }
   }

   if $shadow_min_days != '' {
      exec { "for shadowname in `awk -F: '{ print \$1 }' /etc/shadow`; do passwd -n $shadow_min_days \$shadowname; done" : 
         path => "/bin:/usr/bin"
      }
   }

   if $shadow_max_days != '' {
      exec { "for shadowname in `awk -F: '{ print \$1 }' /etc/shadow`; do passwd -x $shadow_max_days \$shadowname; done" : 
         path => "/bin:/usr/bin"
      }
   }

   if $login_defs_min_len != '' {
      exec { "sed -i -e '/PASS_MIN_LEN/d' -e '$ a\\PASS_MIN_LEN $login_defs_min_len' /etc/login.defs" : 
         onlyif => "test -f /etc/login.defs",
         path => "/bin:/usr/bin"
      } 
   }
   
   if $login_defs_min_days != '' {
      exec { "sed -i -e '/PASS_MIN_DAYS/d' -e '$ a\\PASS_MIN_DAYS $login_defs_min_days' /etc/login.defs" : 
         onlyif => "test -f /etc/login.defs",
         path => "/bin:/usr/bin"
      } 
   }
   
   if $login_defs_max_days != '' {
      exec { "sed -i -e '/PASS_MAX_DAYS/d' -e '$ a\\PASS_MAX_DAYS $login_defs_max_days' /etc/login.defs" : 
         onlyif => "test -f /etc/login.defs",
         path => "/bin:/usr/bin"
      } 
   }
   
   
   if $cracklib_args != '' {
      pam {"pam_cracklib.so":
            type => "password",
            control => "requisite",
            module_args => $cracklib_args,
            args_membership => minimum,
      }
   }
   
   if $pam_unix_args != '' {
      pam {"pam_unix.so":
            type => "password",
            control => "requisite",
            module_args => $pam_unix_args,
            args_membership => minimum,
      }
   }
}
