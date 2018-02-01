#!/bin/bash
# ask for version
echo "Which version: "
read version
rm /tmp/pycharm.tar.gz
wget --server-response -O /tmp/pycharm.tar.gz https://download.jetbrains.com/python/pycharm-professional-$version.tar.gz
mkdir ~/Software/pycharm
tar -xvzf /tmp/pycharm.tar.gz -C ~/Software/pycharm
rm /tmp/pycharm.tar.gz
#response="$(wget --server-response -O /tmp/pycharm.tar.gz https://download.jetbrains.com/python/pycharm-professional-$version.tar.gz)"
#echo $response
#if grep -c 'HTTP/1.1 200 OK' <<< $response;
#then
#	tar -xvzf /tmp/pycharm.tar.gz -C ~/Software/pycharm
#	rm /tmp/pycharm.tar.gz
#	echo "Installed successfuly!"
#	exit 0
#else
#	echo "Error while trying to retrieve data. Make sure the software version is correct."
#	exit 1
#fi

