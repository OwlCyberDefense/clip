# IA-2: User Identification and Authentication
# Kickstart Actions:

class ia-2::main {
        ## (GEN000540: CAT II) (Previously - G004) The SA will ensure passwords are
        ## not changed more than once a day.

        # default path for following execs
        Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

        exec { "sed -i '/^PASS_MIN_DAYS/ c\PASS_MIN_DAYS\t1' /etc/login.defs": }

        ## (GEN000580: CAT II) (Previously - G019) The IAO will ensure all passwords contain a
        ## minimum of eight characters.
        ## (GEN000620: CAT II) . Password Character Mix. # grep dcredit /etc/pam.d/system-auth.
        ## Dcredit should be set to -1
        ## (GEN000640: CAT II) . Password Character Mix. # grep dcredit /etc/pam.d/system-auth.
        ## Ocredit should be set to -1
        ## (GEN000680: CAT II) . Password Character Mix. # grep dcredit /etc/pam.d/system-auth.
        ## maxrepeat is less than 3
        exec { "sed '/pam_cracklib.so/ c\
                password    required      pam_cracklib.so try_first_pass retry=3 minlen=14 difok=3 dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1 enforce_root maxrepeat=2' /etc/pam.d/system-auth":
                onlyif => "test `grep -c pam_cracklib.so /etc/pam.d/system-auth` -gt 0"
			 }

## (GEN000560: CAT I) (Previously - G018) The SA will ensure each account in
## the /etc/passwd file has a password assigned or is disabled in the
## password, shadow, or equivalent, file by disabling the password and/or by
## assigning a false shell in the password file.
        # exec { "for i in `grep -iR nullok /etc/pam.d/* | grep -v slim | cut -d: -f1 | uniq`;do sed -i.slim 's/\ nullok//g' \$i;done": }

        ## (GEN000580: CAT II) (Previously - G019) The IAO will ensure all passwords contain a
        ## minimum of eight characters.
        #sed -i "s/PASS_MIN_LEN[ \t]*[0-9]*/PASS_MIN_LEN\t8/" /etc/login.defs
        #exec { "sed -i '/^PASS_MIN_LEN/ c\PASS_MIN_LEN\t8' /etc/login.defs": }

        ## (GEN000600: CAT II) (Previously - G019) The IAO will ensure passwords include at
        ## least two alphabetic characters, one of which must be capitalized.
        # See GEN000460

        ## (GEN000700: CAT II) (Previously - G020) If passwords are not changed at
        ## least every 60 days, this is a finding.
        ## (GEN000760: CAT II) An account is not locked after 35 days of inactivity.
        #exec { "sed -i '/^PASS_MAX_DAYS/ c\PASS_MAX_DAYS\t60' /etc/login.defs": }
        ##  Changing to 35 days, from 60 was the easiest way to automate this on linux
        exec { "sed -i '/^PASS_MAX_DAYS/ c\PASS_MAX_DAYS\t35' /etc/login.defs": }

        ## (GEN000800: CAT II) (Previously - G606) The SA will ensure passwords will not be
        ## reused within the last ten changes.
        # See GEN000460

        file {

                ## (GEN001380: CAT II) (Previously - G048) The SA will ensure the /etc/passwd
                ## file has permissions of 644, or more restrictive.
                ## (GEN001400: CAT I) (Previously - G047) The SA will ensure the owner of the
                ## /etc/passwd and /etc/shadow files (or equivalent) is root.
                ## (GEN001420: CAT II) (Previously - G050) The SA will ensure the /etc/shadow
                ## file (or equivalent) has permissions of 400.

                "/etc/passwd":
                        owner => "root",
                        mode => 644;
                "/etc/shadow":
                        owner => "root",
                        mode => 400;
        }
}
        # IA-2(1)
        # Kickstart Actions:

        # IA-2(2)
        # Kickstart Actions:

        # IA-2(3)
        # Kickstart Actions:

        # IA-2(4)
        # Kickstart Actions:

        # IA-2(5)
        # Kickstart Actions:

        # IA-2(6)
        # Kickstart Actions:

        # IA-2(7)
        # Kickstart Actions:

        # IA-2(8)
        # Kickstart Actions: