#/bin/sh
make -qp | grep -v '^# ' | grep -v '^[[:space:]]' | grep --only-matching '^.*:'|grep -vE '^[\.%]'
