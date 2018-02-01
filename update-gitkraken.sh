#!/bin/bash
rm /tmp/gitkraken.deb
wget -O /tmp/gitkraken.deb https://release.gitkraken.com/linux/gitkraken-amd64.deb
dpkg -i /tmp/gitkraken.deb
rm /tmp/gitkraken.deb
