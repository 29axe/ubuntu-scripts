#!/bin/bash
# add repository 
sudo cp /etc/apt/sources.list /tmp/sources.list.bak
echo -e "deb     https://qgis.org/debian $(lsb_release -cs) main\ndeb-src\n#https://qgis.org/debian $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list >/dev/null

# get qgis key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key CAEB3DC3BDF7FB45

# update and install qgis and related software
sudo apt update
sudo apt-get install qgis python-qgis qgis-plugin-grass

