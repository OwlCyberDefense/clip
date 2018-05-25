set_umask() {
	local UMASK=$1
	local FILE="$2"

	if /bin/grep -q '^[[:space:]]*umask[[:space:]]' "$FILE"; then
		/bin/sed -i "s/^\([[:space:]]*umask[[:space:]]\+\).*$/\1${UMASK}/" "$FILE"
	else
		echo "umask $UMASK" >> "$FILE"
	fi
}