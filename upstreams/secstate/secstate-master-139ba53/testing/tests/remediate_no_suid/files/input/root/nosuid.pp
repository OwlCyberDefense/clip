class nosuid {
   if $nosuid_nfs_mounts != '' {
      exec { 'nosuid_nfs_mounts' :
         command => 'for record in `awk \'{ if($3 == "nfs" || $3 == "nfs2" || $3 == "nfs3" || $3 == "nfs4") { print $2":"$4 }}\' /proc/mounts`; do mount_point=${record%:*}; fs_options=${record#*:}; if [[ "$fs_options" != *nosuid* ]];then mount -o remount,nosuid $mount_point; fi; done',
         path => '/bin/:/usr/bin'
      }
   }
   
   if $nosuid_nfs_fstab != '' {
      exec { 'nosuid_nfs_fstab' :
         command => 'for record in `awk \'{ if($3 == "nfs" || $3 == "nfs2" || $3 == "nfs3" || $3 == "nfs4") { print $2":"$4 }}\' /etc/fstab`; do mount_point=${record%:*}; fs_opts=${record#*:}; if [[ "$fs_opts" != *nosuid* ]];then sed -i -e "s|\(.*$mount_point.*\)$fs_opts\(.*\)|\1$fs_opts,nosuid\2|" /etc/fstab; fi; done',
         path => '/bin'
      }
   }
}