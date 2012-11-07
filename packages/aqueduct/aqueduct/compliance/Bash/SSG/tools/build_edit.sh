#!bin/bash

sed -i -r -e "s/allprofiles/\$(IN)\/profiles\/common.xml/g" /home/mpalmiotto/clip-alpha/packages/scap-security-guide/scap-security-guide/RHEL6/Makefile
