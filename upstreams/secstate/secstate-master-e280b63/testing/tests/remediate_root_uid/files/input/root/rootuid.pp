class rootuid {
   exec{ 'for record in `awk -F: \'{if($3 == 0 && $1 != "root" && $6 != "/root")print $1":"$6}\' /etc/passwd`; do uid=`awk -F: \'{uid[$3]=1}END{for(x=500; x<=1000; x++){if(uid[x] == ""){print x; exit;}}}\' /etc/passwd`; uname=${record%:*}; homedir=${record#*:}; sed -r -i -e "s|${uname}:([^:]*):0|${uname}:\1:${uid}|g" /etc/passwd; chown $uname $homedir; chgrp $uname $homedir; done' :
      path => '/bin'
   }   
}



