#!/bin/bash
rm /tmp/mailspring.deb
wget -O /tmp/mailspring.deb https://updates.getmailspring.com/download?platform=linuxDeb
sudo dpkg -i /tmp/mailspring.deb
rm /tmp/mailspring.deb
