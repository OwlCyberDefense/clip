#!/bin/bash -x


for i in `cat hosts`;do HOST=`echo $i | cut -d, -f1`;IP=`echo $i | cut -d, -f2`;sed "s/<PROFILE>/$HOST/g" isolinux/isolinux.cfg.template > isolinux/isolinux.cfg;sed -i "s/<IP>/$IP/g" isolinux/isolinux.cfg;mkisofs -o ./$HOST.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -l -r -T -v -V "$i" .;mv $HOST.iso /root/iso/;done
