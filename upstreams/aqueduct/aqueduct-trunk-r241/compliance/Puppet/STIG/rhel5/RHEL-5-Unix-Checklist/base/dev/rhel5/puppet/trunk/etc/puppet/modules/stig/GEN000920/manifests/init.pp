class gen000920 {
        ## (GEN000920: CAT II) (Previously - G023) The SA will ensure the root account
        ## home directory (other than â/â) has permissions of 700. Do not change the
        ## permissions of the â/â directory to anything other than 0755.
        file { "/root":
        mode => 700,
        require => User["root"];
        }

        ## (GEN001480: CAT II) If a user.s home directory(s) is more permissive the 750,
        ##  this is a finding.  Home directories with permissions greater than 750 must
        ##  be justified and documented with the IAO.
        # exec { "find $(awk -F: '$3 > 100 {print $6}' /etc/passwd) -perm -750 ! -type l -exec chmod 750 '{}' \;" :}
}