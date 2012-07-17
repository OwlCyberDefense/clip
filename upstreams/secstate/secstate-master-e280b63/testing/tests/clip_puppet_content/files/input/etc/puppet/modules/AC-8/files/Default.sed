/^PATH/i\
if ! /usr/bin/zenity --warning --no-wrap --text "`cat /etc/issue`"; then\
  /usr/bin/zenity --info --text "Logging out in 10 Seconds" &\
  sleep 10\
  exit 1\
fi\

