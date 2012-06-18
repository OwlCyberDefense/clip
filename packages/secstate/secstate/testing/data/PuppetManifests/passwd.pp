class passwd {
   file_perms { '/etc/passwd' :
      owrite => ifdefined('etc_passwd_owrite'),
      gwrite => ifdefined('etc_passwd_gwrite'),
      uexec => ifdefined('etc_passwd_uexec'),
      gexec => ifdefined('etc_passwd_gexec'),
      oexec => ifdefined('etc_passwd_oexec'),
      owner => ifdefined('etc_passwd_owner'),
      group => ifdefined('etc_passwd_group_owner'),
   }
}
    
class passwd_complexity {
   pam {"pam_cracklib.so":
      type => "password",
      control => "requisite",
      module_args => $cracklib_args,
      args_membership => minimum,
   }
}

