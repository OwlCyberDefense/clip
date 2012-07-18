class gen002320 {
	## (GEN002320: CAT II) (Previously - G501) The SA will ensure the audio devices
	## have permissions of 644, or more restrictive.
	## (GEN002340: CAT II) (Previously - G502) The SA will ensure the owner of
	## audio devices is root.
	## (GEN002360: CAT II) (Previously - G504) The SA will ensure the group owner
	## of audio devices is root, sys, or bin.
	exec { "sed -i -r '/sound|snd|mixer/ d' /etc/security/console.perms.d/50-default.perms": }

	file { "/etc/udev/rules.d/55-audio-perms.rules":
		content => "SUBSYSTEM==\"sound|snd\", OWNER=\"root\", GROUP=\"root\", MODE=\"0644\""
	}
}
