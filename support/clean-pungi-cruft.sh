#!/bin/bash
echo "WARNING: This script blindly removes all Pungi-related directories from /tmp."
echo "         If anyone is building an ISO at this time please hit ctrl-c."
echo "         You probably need to sudo to run this script successfully."
read

pushd . 1>/dev/null
cd /tmp;
rm -rf keepfile* modinfo* instimage* keymaps* makeboot* yumcache* yumdir* buildinstall*
popd 1>/dev/null
