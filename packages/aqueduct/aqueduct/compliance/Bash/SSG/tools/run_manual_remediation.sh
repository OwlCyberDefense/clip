#!/bin/bash

secstate remove RHEL-6
secstate import /usr/local/scap-security-guide/RHEL6/output/ssg-rhel6-xccdf.xml --profile=manual

echo "About to run the Manual portion of remediation content."
echo "You will be prompted for input before and while running each of the following scripts."
echo "Please answer with valid input."
echo ""

echo "Running secstate audit on Manual profile..."
secstate audit

echo "Running secstate remediate on Manual profile..."
IFS=$'\n'

for items in $(secstate list -ar| grep "\[X\]Rule"); do
	script=$(echo "$items"| awk '{print $4}'| sed -r -e "s@(\w+),@/usr/libexec/aqueduct/SSG/scripts/\1.sh\n@g")

	prompt=$(echo $items| awk '{$1=$2=$3=$4=$5=""; print $0}'| grep -Po "\'[^\']+\'")
	
	if [ -f $script ]; then
		while /bin/true; do
			read -p "Do you want to ${prompt}?" yn
			case $yn in
				[Yy]* ) sh $script; break;;
				[Nn]* ) break;;
				* ) echo "Valid entries are Y and N.";;
			esac
		done
	fi
done;

secstate audit

