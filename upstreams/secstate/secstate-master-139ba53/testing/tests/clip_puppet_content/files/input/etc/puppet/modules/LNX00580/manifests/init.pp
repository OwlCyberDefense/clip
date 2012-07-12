class lnx00580 {
	## (LNX00580: CAT I) (Previously - L222) The SA will disable the
	## Ctrl-Alt-Delete sequence unless the system is located in a controlled
	## access area accessible only by SAs.

	# need to add back:
	#echo "" >> /etc/inittab
	#echo "#Require password in single-user mode" >> /etc/inittab

	exec { "sed -i 's/ca\:\:ctrlaltdel/\#ca\:\:ctrlaltdel/' /etc/inittab":
		unless => "grep -q '#ca\:\:ctrlaltdel' /etc/inittab"
	}
}
