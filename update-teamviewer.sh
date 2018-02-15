#!/bin/bash
rm /tmp/teamviewer.deb
wget -O /tmp/teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo dpkg -i /tmp/teamviewer.deb
sudo apt-get -f install
rm /tmp/teamviewer.deb
