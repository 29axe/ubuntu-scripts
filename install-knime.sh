#!/bin/bash

# download knime
rm /tmp/knime.tar.gz
wget -O /tmp/knime.tar.gz https://download.knime.org/analytics-platform/linux/knime-latest-linux.gtk.x86_64.tar.gz
tar -xzvf /tmp/knime.tar.gz -C /opt/
rm /tmp/knime.tar.gz
