class passreqs {
   if $shadow_users_in_passwd != '' {
      exec { 'sed -i -n "/^\(`cat /etc/shadow | awk -F: \'{print $1 }\' | sed \'s/\(.*\)/\1\\\\/\' | tr \'\n\' \'|\' | sed \'s/\(.*\)\\\\|/\1/\'`\).*/p" /etc/passwd' : 
         onlyif => ["test -f /etc/passwd", "test -f /etc/shadow"],
         path => "/bin:/usr/bin"
      }
   }

   if $lock_accounts_missing_password != '' {
      exec { 'for shadowname in `awk -F: \'{ if ($2 == "") print $1 }\' /etc/shadow`; do passwd -l $shadowname; done' :
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
      exec { "sed -i -e '/^[^#]*PASS_MIN_LEN/d' -e '$ a\\PASS_MIN_LEN $login_defs_min_len' /etc/login.defs" : 
         onlyif => "test -f /etc/login.defs",
         path => "/bin:/usr/bin"
      } 
   }
   
   if $login_defs_min_days != '' {
      exec { "sed -i -e '/^[^#]*PASS_MIN_DAYS/d' -e '$ a\\PASS_MIN_DAYS $login_defs_min_days' /etc/login.defs" : 
         onlyif => "test -f /etc/login.defs",
         path => "/bin:/usr/bin"
      } 
   }
   
   if $login_defs_max_days != '' {
      exec { "sed -i -e '/^[^#]*PASS_MAX_DAYS/d' -e '$ a\\PASS_MAX_DAYS $login_defs_max_days' /etc/login.defs" : 
         onlyif => "test -f /etc/login.defs",
         path => "/bin:/usr/bin"
      } 
   }
   
   
   if $password_min_length != '' {
      $password_min_length_arg = "minlen=$password_min_length"
   }
   if $password_min_upper != '' {
      $password_min_upper_arg = "ucredit=-$password_min_upper"
   }
   if $password_min_lower != '' {
      $password_min_lower_arg = "lcredit=-$password_min_lower"
   }
   if $password_min_other != '' {
      $password_min_other_arg = "ocredit=-$password_min_other"
   }
   if $password_min_digit != '' {
      $password_min_digit_arg = "dcredit=-$password_min_digit"
   }
   if $password_max_repeat_characters != '' {
      $password_max_repeat_characters_arg = "maxrepeat=$password_max_repeat_characters"
   }

   $cracklib_args = [$password_min_length_arg,
                     $password_min_upper_arg,
                     $password_min_lower_arg,
                     $password_min_other_arg,
                     $password_min_digit_arg,
                     $password_max_repeat_characters_arg,
                    ]

   if $cracklib_args != ['','','','','',''] {
      pam {"password:pam_cracklib.so":
            control => "requisite",
            module_args => $cracklib_args,
            args_membership => minimum,
      }
   }

   if $password_remember != '' {
      $password_remember_arg = "remember=$password_remember"
   }

   $pam_unix_args = [$password_remember_arg]

   if $pam_unix_args != [''] {
      pam {"password:pam_unix.so":
            control => "requisite",
            module_args => $pam_unix_args,
            args_membership => minimum,
      }
   }
}
